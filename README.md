# **Fuentes de Partículas con el Software FLUKA**

Este proyecto se centra en la creación de **fuentes de partículas personalizadas** para simulaciones en FLUKA, basadas en datos digitalizados de curvas gráficas. La finalidad es demostrar cómo integrar datos experimentales en FLUKA para realizar simulaciones realistas y útiles en diversas aplicaciones como diseño de detectores y análisis de blindajes.

---

## **Descripción del Proceso**

### **1. Digitalización de Datos**
- Los datos de una curva gráfica en formato `.jpeg` (por ejemplo, flujo vs energía) se digitalizan con herramientas especializadas como **WebPlotDigitizer**.
- Esto permite extraer las coordenadas \( E \) (energía) y \( \frac{dN}{dE} \) (flujo), que luego se convierten en un archivo tabular (CSV).

### **2. Creación de una Fuente Personalizada**
- Los datos digitalizados son procesados en **Python** para convertirlos en un formato compatible con FLUKA.
- Se genera un archivo que describe la distribución energética de la fuente de partículas.

### **3. Simulación con FLUKA**
- La fuente personalizada se integra en una simulación que incluye un detector o sistema experimental.
- Esto permite analizar cómo interactúan las partículas definidas por la curva digitalizada.

---

## **Objetivo**
Este proyecto busca demostrar cómo integrar datos experimentales o gráficos preexistentes en FLUKA para realizar simulaciones personalizadas y realistas. Es útil en el diseño y análisis de detectores, blindajes y sistemas experimentales.

---

## **Requisitos**
- **FLUKA** instalado.
- Herramienta de digitalización como **WebPlotDigitizer**.
- **Python** para procesar los datos digitalizados.
- **FORTRAN** para escribir y editar subrutinas.

---

## **Estructura del Proyecto**

### **Carpeta: Digitalizacion_de_Fuente**
- `No_Shielding.jpeg`: Gráfico que contiene los datos de la curva a digitalizar.
- `Dataset.csv`: Datos digitalizados de la curva.
- `Curva_No_Shielding_FLUKA.ipynb`: Notebook con el código para procesar y visualizar los datos.
- `No_Shielding.csv`: Archivo procesado en el formato requerido por FLUKA.

### **Carpeta: Code_no_editado**
- `example.flair`: Simulación básica sin fuente de partículas externa.
- `example.inp`: Archivo de entrada de simulación básico.
- `source_newgen.f`: Subrutina editable para fuentes externas escrita en FORTRAN.

### **Carpeta: simulacion_direccion_unica**
- `simulacion.flair`: Simulación lista para ejecutar con una fuente externa.
- `simulacion.inp`: Archivo de entrada de simulación preparado.
- `No_Shielding.csv`: Archivo procesado listo para FLUKA.
- `fuente_direccion_unica.f`: Subrutina que define una fuente externa con dirección fija.
- **Otros archivos**: Archivos generados durante la simulación.

### **Carpeta: simulacion_direccion_random**
- `simulacion.flair`: Simulación lista para ejecutar con una fuente externa.
- `simulacion.inp`: Archivo de entrada de simulación preparado.
- `fuente_direccion_random.f`: Subrutina que define una fuente externa con dirección aleatoria.
- `No_Shielding.csv`: Archivo procesado listo para FLUKA.
- **Otros archivos**: Archivos generados durante la simulación.

### **Carpeta: simulacion_direccion_random_grilla** (NUEVA)
- `simulacion.flair`: Simulación configurada para fuentes aleatorias en una grilla de posiciones.
- `simulacion.inp`: Archivo de entrada de simulación preparado.
- `fuente_direccion_random_grilla.f`: Subrutina que genera partículas con posiciones aleatorias del haz de particula basadas en una grilla y en una direccion aleatoria.
- `No_Shielding.csv`: Archivo procesado listo para FLUKA.
- **Otros archivos**: Archivos generados durante la simulación.

---

## **Cómo Usar este Proyecto**

1. **Digitalización**:
   - Usa la carpeta `Digitalizacion_de_Fuente` para digitalizar un gráfico y procesar los datos con Python.
2. **Preparación**:
   - Selecciona una de las carpetas de simulación (`simulacion_direccion_unica`, `simulacion_direccion_random`, o `simulacion_direccion_random_grilla`) según el tipo de fuente que desees utilizar.
   - Edita los archivos `.f` si necesitas personalizar la fuente.
3. **Simulación**:
   - Usa FLUKA y ejecuta la simulación en la carpeta seleccionada.
   - Analiza los resultados generados.

---
