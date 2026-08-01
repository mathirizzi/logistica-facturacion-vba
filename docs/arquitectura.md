# Arquitectura del Motor de Facturación

## Objetivo

Definir la estructura general del motor de facturación y la responsabilidad de cada módulo.

El motor está diseñado bajo una arquitectura modular, donde cada etapa del proceso se encuentra aislada en un módulo independiente.

El flujo siempre comienza en `Main.bas`, que actúa únicamente como orquestador del proceso.

---

# Flujo General

Main.bas
│
├── Inicialización
│
├── Configuración
│
├── Carga de datos
│
├── Validaciones
│
├── Preparación de datos
│
├── Facturación
│   ├── Recepciones
│   ├── Picking
│   ├── Despachos
│   ├── Estadías
│
├── Consolidación
│
├── Exportación
│
└── Finalización

---

# Filosofía del proyecto

Cada módulo debe tener una única responsabilidad.

Un módulo:

- Puede leer información.
- Puede transformar información.
- Puede generar resultados.

Pero nunca debe realizar tareas que pertenezcan a otro módulo.

Ejemplo:

✔ FacturacionRecepciones.bas calcula únicamente las recepciones.

✘ No debe exportar archivos.

✘ No debe leer configuraciones.

✘ No debe modificar tarifas.

---

# Flujo de información

Excel / Base de datos

↓

Carga de datos

↓

Validaciones

↓

Preparación

↓

Facturación

↓

Consolidación

↓

Exportación

---

# Dependencias

El flujo siempre avanza hacia adelante.

Un módulo nunca debe depender de un módulo posterior.

Ejemplo correcto:

CargaDatos
    ↓
Facturación
    ↓
Exportación

Ejemplo incorrecto:

Facturación
    ↓
Exportación
    ↓
Facturación

---

# Organización del proyecto

Main.bas

↓

Módulos del sistema

↓

Funciones privadas

↓

Variables internas

---

# Objetivo de la arquitectura

- Código simple.
- Fácil mantenimiento.
- Fácil agregar nuevos conceptos de facturación.
- Evitar código duplicado.
- Cada módulo debe poder modificarse sin afectar a los demás.