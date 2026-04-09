[CmdletBinding()]
param()

$root = Get-Location
$texFiles = Get-ChildItem -Path $root -Recurse -Filter *.tex -File
$bibFile = Join-Path $root 'referencias.bib'

$citePattern = '\\(?:cite|parencite|textcite|autocite|citep|citet|footcite)[^\{]*\{([^}]*)\}'
$nocitePattern = '\\nocite\s*\{([^}]*)\}'
$entryPattern = '@\w+\{\s*([^,\s]+)\s*,'
$refPattern = '\\ref\{([^}]*)\}'

$used = [System.Collections.Generic.HashSet[string]]::new()
$foundNociteAll = $false
$refs = [System.Collections.Generic.HashSet[string]]::new()

foreach ($f in $texFiles) {
    $path = $f.FullName
    $txt = Get-Content -Raw -Encoding UTF8 $path -ErrorAction SilentlyContinue
    if (-not $txt) { $txt = Get-Content -Raw -Encoding Default $path }
    if ($txt -match '\\nocite\s*\{\s*\*\s*\}') { $foundNociteAll = $true }
    $matches = [regex]::Matches($txt, $citePattern)
    foreach ($m in $matches) {
        $keys = $m.Groups[1].Value -split ','
        foreach ($k in $keys) {
            $kk = $k.Trim()
            if ($kk) { $used.Add($kk) | Out-Null }
        }
    }
    $nocMatches = [regex]::Matches($txt, $nocitePattern)
    foreach ($nm in $nocMatches) {
        $keys = $nm.Groups[1].Value -split ','
        foreach ($k in $keys) {
            $kk = $k.Trim()
            if ($kk -and $kk -ne '*') { $used.Add($kk) | Out-Null }
        }
    }
    $refMatches = [regex]::Matches($txt, $refPattern)
    foreach ($rm in $refMatches) {
        $refs.Add($rm.Groups[1].Value.Trim()) | Out-Null
    }
}

if (-not (Test-Path $bibFile)) { Write-Host 'referencias.bib not found'; exit 1 }
$bibText = Get-Content -Raw -Encoding UTF8 $bibFile
$entryMatches = [regex]::Matches($bibText, $entryPattern)
$bibKeys = @()
foreach ($em in $entryMatches) { $bibKeys += $em.Groups[1].Value.Trim() }

$bibKeysSet = [System.Collections.Generic.HashSet[string]]::new()
foreach ($k in $bibKeys) { $bibKeysSet.Add($k) | Out-Null }

 $unused = @()
 foreach ($k in $bibKeysSet) { if (-not $used.Contains($k)) { $unused += $k } }
 $unused = $unused | Sort-Object

 # keys cited but missing in .bib
 $missingCited = @()
foreach ($k in $used) {
    # keep only plausible bib keys (alnum, underscore, colon, dash)
    if ($k -match '^[A-Za-z0-9_:\-]+$') {
        if (-not $bibKeysSet.Contains($k)) { $missingCited += $k }
    }
}
 $missingCited = $missingCited | Sort-Object

# Check appendix labels in apendices.tex
$appendicesFile = Join-Path $root 'apendices.tex'
$appendixLabels = [System.Collections.Generic.HashSet[string]]::new()
if (Test-Path $appendicesFile) {
    $appText = Get-Content -Raw -Encoding UTF8 $appendicesFile
    # find \chapter{...}\label{ap:X} or \chapter{...}\label{ap:X}
    $labelPattern = '\\label\{([^}]+)\}'
    $labMatches = [regex]::Matches($appText, $labelPattern)
    foreach ($lm in $labMatches) { $appendixLabels.Add($lm.Groups[1].Value.Trim()) | Out-Null }
}

$missingRefs = @()
foreach ($r in $refs) {
    # if ref starts with ap: check in appendix labels
    if ($r -like 'ap:*') {
        if (-not $appendixLabels.Contains($r)) { $missingRefs += $r }
    }
}

$out = @()
$out += "Total .bib entries: $($bibKeysSet.Count)"
$out += "Citation commands found (unique keys): $($used.Count)"
$out += "Detected \nocite{*}: $(if ($foundNociteAll) {'Yes'} else {'No'})"
$out += ''
$out += 'Unused .bib entries (present in referencias.bib but not cited in .tex files):'
$out += $unused
$out += ''

$out += 'References to appendix labels found via \ref{...} that are missing in apendices.tex:'
if ($missingRefs.Count -eq 0) { $out += 'None' } else { foreach ($mr in $missingRefs | Sort-Object) { $out += "- $mr" } }

$out += ''
$out += 'Citation keys used in .tex but MISSING in referencias.bib:'
if ($missingCited.Count -eq 0) { $out += 'None' } else { foreach ($mc in $missingCited | Sort-Object) { $out += "- $mc" } }

$outText = $out -join "`n"
Write-Host $outText

# save report
 $outPath = Join-Path $root.Path 'scripts\unused_bib_report.txt'
 $outText | Out-File -FilePath $outPath -Encoding UTF8

if ($unused.Count -gt 0 -or $missingRefs.Count -gt 0) { exit 2 } else { exit 0 }
