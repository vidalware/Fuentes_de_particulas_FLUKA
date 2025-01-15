# **Simulación con FLUKA: Interacción de Neutrones con un Blanco Cilíndrico**

Este proyecto utiliza **FLUKA** para simular la interacción de un haz de neutrones con un blanco de tungsteno cilíndrico rodeado de una región de vacío. La simulación mide el flujo de neutrones en un volumen tridimensional definido alrededor del blanco.

---

## **Descripción de la Simulación**

### **Objetivo**
Analizar cómo interactúan los neutrones con un blanco de tungsteno, evaluando el flujo de neutrones en una región definida del espacio. Esto es útil en estudios de blindajes y diseño de sistemas experimentales.

---

### **Geometría del Sistema**

1. **Región de Black Body**:
   - Esfera de radio muy grande (\( 100,000 \) cm) que absorbe todas las partículas que salen de la región de interés.

2. **Región de Vacío**:
   - Esfera de radio \( 10,000 \) cm, que define el espacio alrededor del blanco cilíndrico.

3. **Blanco Cilíndrico**:
   - Cilindro de tungsteno con:
     - Radio: \( 15 \) cm.
     - Longitud: \( 80 \) cm.
     - Posicionado a lo largo del eje \( z \), comenzando en \( (0, 0, 0) \).

---

### **Configuración del Haz**

- **Partícula:** Neutrones.
- **Energía:** Valor predeterminado no especificado (\( -1.0 \), ajustable en una fuente externa).
- **Posición Inicial:**
  - \( x = -1.0 \) cm.
  - \( y = 0.0 \) cm.
  - \( z = 0.5 \) cm.

---

### **Materiales**

- **BLCKHOLE:** Región absorbente para la esfera externa.
- **VACUUM:** Región de vacío alrededor del blanco.
- **TUNGSTEN:** Material del blanco cilíndrico.

---

### **Detector (USRBIN)**

- **Tipo:** Flujo de neutrones (\( NEUTRON \)).
- **Dimensiones:**
  - Volumen tridimensional definido desde \( (-100, -100, -100) \) cm hasta \( (120, 120, 120) \) cm.
  - Resolución: \( 10 \times 10 \times 10 \) celdas.

---

## **Parámetros de la Simulación**

1. **Semilla Aleatoria:** Establecida con `RANDOMIZ`.
2. **Eventos Simulados:**
   - Configurado para simular 10 eventos primarios (`START`).
   - Se recomienda aumentar este valor para obtener resultados estadísticamente significativos.

---

## **Archivos del Proyecto**

### **Archivos de Entrada**
- `simulacion.inp`: Archivo de entrada que define la geometría, materiales, haz y configuración general.

### **Archivos Generados**
- `simulacion.flair`: Archivo para gestionar y analizar la simulación en la interfaz **FLAIR**.
- Salidas de la simulación (USRBIN y otros resultados).

---

## **Resultados Visuales**

### **Fluencia de Neutrones**
La fluencia de neutrones fue evaluada mediante proyecciones en los ejes \( y \) y \( z \):

1. **Proyección en el Eje \( y \):**
   ![Fluencia Proyección Eje Y](fluencia_proyeccion_eje_y.png)

2. **Proyección en el Eje \( z \):**
   ![Fluencia Proyección Eje Z](fluencia_proyeccion_eje_z.png)

---

## **Mejoras Sugeridas**

1. **Definir una distribución de energía personalizada:**
   - Usar una subrutina o archivo externo para especificar la distribución de energía del haz.

2. **Ajustar el rango del detector:**
   - Reducir el volumen del detector a una región cercana al blanco si solo interesa medir interacciones locales.

3. **Aumentar el número de eventos:**
   - Incrementar `START` para mejorar la estadística y confiabilidad de los resultados.

---

## **Cómo Ejecutar la Simulación**

1. **Preparar el entorno:**
   - Asegúrate de tener FLUKA y FLAIR instalados.

2. **Cargar el archivo de entrada:**
   - Abre `simulacion.flair` en FLAIR.

3. **Ejecutar la simulación:**
   - Ejecuta la simulación desde FLAIR o usando el comando:
     ```bash
     rfluka -e fluka -N0 -M1 simulacion
     ```

4. **Analizar los resultados:**
   - Visualiza los resultados del detector (USRBIN) en FLAIR o exporta los datos para un análisis externo.

---

Con esta configuración, la simulación está lista para ejecutarse y evaluar el flujo de neutrones en el sistema definido. Si necesitas personalizarla o realizar ajustes, consulta la sección de mejoras sugeridas.
