# Plantilla LaTeX - Tesis de Grado | Carrera de Software PUCEM

![LaTeX](https://img.shields.io/badge/LaTeX-47A141?style=flat-square&logo=latex&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)
![Status](https://img.shields.io/badge/Status-Activo-brightgreen.svg?style=flat-square)

Una plantilla profesional en LaTeX diseñada para facilitar la redacción de tesis, trabajos de grado y documentos académicos bajo los lineamientos de la **Pontificia Universidad Católica del Ecuador Sede Manabí (PUCEM)** - Carrera de Software.

## Características Principales

- **Cumplimiento APA 7ma Edición**: Formato de citas y referencias según normativas internacionales
- **Diseño Profesional**: Estilos personalizados para títulos, capítulos y secciones
- **Márgenes Normalizados**: Según las recomendaciones de PUCEM
- **Bibliografía Automatizada**: Sistema de referencias con Biber/BibLaTeX
- **Estructura Completa**: Incluye portada, preliminares, capítulos, apéndices y referencias
- **Plantilla Flexible**: Fácil de personalizar y adaptar a diferentes proyectos
- **Tipografía Times New Roman**: Fuente recomendada para documentos académicos

## Estructura del Proyecto

```
PUCEM_Software/
├── main.tex                          # Archivo principal (punto de entrada)
├── PUCEM.sty                         # Archivo de estilos personalizados
├── referencias.bib                   # Base de datos bibliográfica
├── apendices.tex                     # Apéndices del documento
├── recomendaciones.tex               # Recomendaciones y configuración
│
├── capitulos/                        # Contenido principal
│   ├── 1_introduccion.tex
│   ├── 2_metodos.tex
│   ├── 3_resultados.tex
│   ├── 4_discucion.tex
│   └── 5_conclusiones.tex
│
├── preliminares/                     # Páginas preliminares
│   ├── 1_portada.tex
│   ├── 2_certificaion_tutor.tex
│   ├── 3_acta_aprobacion_tribunal.tex
│   ├── 4_declaracion_originalidad.tex
│   ├── 5_declaracion_derechos_autor.tex
│   ├── 6_dedicatoria.tex
│   ├── 7_agradecimientos.tex
│   └── 8_resumen_abstract.tex
│
├── imagenes/                         # Recursos gráficos
└── README.md                         # Este archivo
```

## Requisitos Previos

Para compilar esta plantilla, necesitas tener instalado:

- **LaTeX Distribution**: 
  - En Windows: [MiKTeX](https://miktex.org/) o [TeX Live](https://www.tug.org/texlive/)
  - En macOS: [MacTeX](https://www.tug.org/mactex/)
  - En Linux: `texlive` (Ubuntu/Debian: `sudo apt-get install texlive-full`)

- **Editor recomendado**:
  - [VS Code](https://code.visualstudio.com/) + Extensión [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)
  - [TeXstudio](https://www.texstudio.org/)
  - [Overleaf](https://www.overleaf.com/) (en línea, sin instalación local)

## Cómo Usar

### 1. **Configuración Inicial**

Edita el archivo `main.tex` y personaliza:

```tex
% Tus datos personales
\author{Tu Nombre}
\title{Título de tu Tesis}
\date{Año}
```

### 2. **Editar el Contenido**

Los archivos `.tex` están organizados de la siguiente manera:

- **`preliminares/`**: Portada, resumen, dedicatoria, etc.
- **`capitulos/`**: Introducción, métodos, resultados, discusión y conclusiones
- **`referencias.bib`**: Agregua tus referencias bibliográficas en formato BibTeX

### 3. **Compilar el Documento**

**Opción A: Desde terminal**
```bash
pdflatex main.tex
biber main
pdflatex main.tex
pdflatex main.tex
```

**Opción B: Con LaTeX Workshop (VS Code)**
- Presiona `Ctrl+Alt+B` o usa el botón "Build" en la barra lateral

**Opción C: En Overleaf**
- Carga todos los archivos y compila directamente en la plataforma

### 4. **Agregar Referencias Bibliográficas**

En `referencias.bib`, agrega tus referencias en formato BibTeX:

```bibtex
@article{Author2023,
  author = {Author, A. and Author, B.},
  title = {Article Title},
  journal = {Journal Name},
  year = {2023},
  volume = {10},
  pages = {1-15}
}
```

Luego, en tu documento `.tex`, cita con:
```tex
\cite{Author2023}
```

## Configuración Avanzada

### Cambiar el Idioma

Por defecto la plantilla está en español. Para cambiar a otro idioma:

```tex
\usepackage[english]{babel}  % Inglés
\usepackage[portuguese]{babel}  % Portugués
```

### Ajustar Márgenes

En `PUCEM.sty` o `main.tex`, modifica:

```tex
\usepackage[top=2.54cm, bottom=2.54cm, left=2.54cm, right=2.54cm]{geometry}
```

### Cambiar Espaciado

Para doble espaciado (común en universidades):
```tex
\usepackage{setspace}
\doublespacing
```

## Ejemplos de Uso

### Insertar una imagen

```tex
\begin{figure}[h]
  \centering
  \includegraphics[width=0.8\textwidth]{imagenes/mi_imagen.png}
  \caption{Descripción de la imagen}
  \label{fig:etiqueta}
\end{figure}
```

### Crear una tabla

```tex
\begin{table}[h]
  \centering
  \begin{tabular}{|c|c|}
    \hline
    Columna 1 & Columna 2 \\
    \hline
    Dato 1 & Dato 2 \\
    \hline
  \end{tabular}
  \caption{Descripción de la tabla}
  \label{tab:etiqueta}
\end{table}
```

### Código fuente (listings)

```tex
\usepackage{listings}
\lstset{language=Python, breaklines=true}

\begin{lstlisting}
def hello_world():
    print("Hello, World!")
\end{lstlisting}
```

## Notas Importantes

1. **Esta NO es una plantilla oficial de PUCEM**, pero está basada fielmente en la estructura y recomendaciones del documento "2023-1 Normativa de UIC 2022 V2"

2. **NO elimines paquetes críticos** a menos que comprendas su función completamente

3. **Todos los archivos `.tex` deben existir** para que la compilación sea exitosa

4. **Verifica tus referencias bibliográficas** - un error en el formato BibTeX puede causar problemas de compilación

5. **Usa caracteres UTF-8** en todos los archivos para evitar problemas de codificación

## Solución de Problemas

| Problema | Solución |
|----------|----------|
| Error de compilación | Asegúrate de que todos los archivos `.tex` existan en sus ubicaciones |
| Referencias no aparecen | Ejecuta `biber main.tex` después de `pdflatex` |
| Fuente no es Times New Roman | Verifica que el paquete `mathptmx` esté cargado en PUCEM.sty |
| Márgenes incorrectos | Revisa la configuración de `geometry` en `main.tex` |
| Caracteres especiales no se ven | Asegúrate de usar `\usepackage[utf8]{inputenc}` |

## Contribuciones

Si encuentras errores o tienes mejoras para esta plantilla:

1. Haz un fork del repositorio
2. Crea una rama para tu mejora (`git checkout -b feature/mejora`)
3. Commit con mensaje descriptivo (`git commit -m 'Agrega mejora X'`)
4. Push a la rama (`git push origin feature/mejora`)
5. Abre un Pull Request

## Licencia

Esta plantilla se distribuye bajo la licencia **MIT**. Eres libre de usarla, modificarla y compartirla con la comunidad académica.

## Autor de la Plantilla

**Ing. José Naranjo, M.Eng.**
- Máster en Ingeniería en Seguridad de la Información
- Ingeniero en Electrónica y Redes de Información
- Docente de la Carrera de Software - PUCEM

## Soporte

Para preguntas o reportar problemas:
- Abre una [Issue](../../issues/new) en GitHub
- Consulta la [Documentación de LaTeX](https://www.latex-project.org/help/documentation/)
- Revisa [Overleaf Learn](https://www.overleaf.com/learn) para tutoriales

## Agradecimientos

Agradezco a la comunidad académica de PUCEM y a todos los estudiantes que han utilizado y mejorado esta plantilla a lo largo del tiempo.

## Correcciones aplicadas (Marzo 2026)

Se incorporaron ajustes técnicos, metodológicos y de redacción en la tesis para responder observaciones de evaluación académica:

- **Paginación preliminar**: se eliminó numeración visible en portada y preliminares, y se configuró el índice para iniciar en números romanos desde `i`.
- **Citas y bibliografía**: se validaron claves bibliográficas y se resolvieron advertencias de citas indefinidas en capítulos principales.
- **Objetivos y alcance**: se reformularon objetivos específicos con criterios de validación y el alcance en términos de entregables y exclusiones.
- **Figura de flujo general**: se contextualizó en Introducción con explicación textual y su relación metodológica.
- **Tabla de operacionalización**: se reforzó su justificación en Método y su trazabilidad con métricas del capítulo de Resultados.
- **Metodología IBD**: se clarificó la separación de fases y la relación entre diseño, demostración, validación y comunicación.
- **Arquitectura backend**: se reorganizó como arquitectura **modular en capas**, diferenciando controladores, servicios, persistencia y componentes transversales.
- **Base de datos**: se dejó explícito el uso de modelo relacional PostgreSQL (Supabase), descartando NoSQL en este piloto por criterios de integridad transaccional.
- **Seguridad y despliegue**: se reubicaron y detallaron en la etapa de validación/despliegue (CORS, rate limiting, JWT, SSL, variables de entorno).
- **Resultados y pruebas**: se añadieron tamaños de muestra, periodo de medición, métricas de rendimiento y tabla de validación funcional por casos con porcentajes y `n`.
- **SUS y pruebas unitarias**: se fortaleció la evidencia con puntajes individuales, trazabilidad por ID de prueba (PU-01, PU-02, etc.) y referencia a apéndices.
- **Compilación final**: el documento se validó con `latexmk -pdf` sin errores de compilación.

---

**Última actualización**: Marzo 2026

**Estado**: Mantenida y activa para la carrera de Software de PUCEM
