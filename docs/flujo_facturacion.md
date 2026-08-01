# Flujo de Facturación

## Objetivo

Este documento describe el flujo completo de ejecución del Motor de Facturación.

Cada etapa representa un módulo independiente del sistema. El `Main.bas` será el encargado de ejecutar estas etapas en el orden definido.

---

# Flujo General

INICIO

↓

Inicializar sistema

↓

Cargar configuración

↓

Cargar movimientos

↓

Validar información

↓

Preparar datos

↓

Facturar conceptos

↓

Consolidar resultados

↓

Generar salida

↓

Finalizar proceso

↓

FIN

---

# Etapas del proceso

## 1. Inicializar sistema

### Objetivo

Preparar el entorno de trabajo.

### Tareas

- Inicializar variables globales.
- Limpiar estructuras temporales.
- Registrar fecha y hora de inicio.
- Reiniciar contadores.
- Preparar el entorno para la ejecución.

### Resultado

El sistema queda listo para comenzar el proceso.

---

## 2. Cargar configuración

### Objetivo

Obtener todos los parámetros necesarios para la ejecución.

### Ejemplos

- Cliente a facturar.
- Período.
- Carpeta de salida.
- Parámetros generales.
- Opciones del proceso.

### Resultado

Todos los parámetros quedan disponibles para el resto del sistema.

---

## 4. Cargar movimientos

### Objetivo

Leer todos los movimientos que serán utilizados durante el proceso.

### Posibles orígenes

- Excel
- Base de datos
- Archivos externos

### Resultado

Todos los movimientos quedan cargados en memoria.

**Importante**

Los movimientos deben cargarse una sola vez.

A partir de este momento ningún módulo vuelve a leer información del origen.

---

## 5. Validar información

### Objetivo

Detectar errores antes de comenzar los cálculos.

### Ejemplos

- Clientes inválidos.
- Productos inexistentes.
- Fechas incorrectas.
- Datos obligatorios faltantes.

### Resultado

Si existen errores críticos el proceso finaliza.

Si no existen errores continúa la ejecución.

---

## 6. Preparar datos

### Objetivo

Organizar la información para facilitar los cálculos posteriores.

### Posibles tareas

- Ordenar movimientos.
- Agrupar por cliente.
- Agrupar por producto.
- Agrupar por depósito.
- Agrupar por período.
- Crear estructuras auxiliares.

### Resultado

Información preparada para la facturación.

---

# 7. Facturación

Durante esta etapa cada módulo calcula únicamente su propio concepto.

Los módulos son independientes entre sí.

## 7.1 Recepciones

Calcula todos los cargos correspondientes a ingresos de mercadería.

---

## 7.3 Picking

Calcula los cargos correspondientes a preparación de pedidos.

---

## 7.4 Despachos

Calcula los cargos por egreso de mercadería.

---

## 7.5 Estadías

Calcula los cargos asociados al tiempo de permanencia.

---

### Resultado

Cada módulo devuelve su propio detalle de facturación.

---

## 8. Consolidar resultados

### Objetivo

Unificar todos los conceptos calculados.

### Tareas

- Integrar resultados.
- Eliminar duplicados si corresponde.
- Calcular subtotales.
- Calcular total general.
- Generar el detalle final.

### Resultado

Factura completa en memoria.

---

## 9. Generar salida

### Objetivo

Exportar el resultado del proceso.

### Posibles formatos

- Excel
- PDF
- CSV
- TXT
- Base de datos

### Resultado

Factura generada.

---

## 10. Finalizar proceso

### Objetivo

Cerrar correctamente la ejecución.

### Tareas

- Liberar memoria.
- Registrar fecha y hora de finalización.
- Mostrar resumen del proceso.
- Registrar errores si existieron.

### Resultado

Proceso finalizado correctamente.

---

# Reglas del flujo

1. El flujo siempre se ejecuta en el orden definido.

2. Ningún módulo puede ejecutar módulos posteriores.

3. Cada módulo tiene una única responsabilidad.

4. Los movimientos se cargan una única vez.

5. Los módulos trabajan sobre la información preparada.

6. Ningún módulo debe acceder directamente a Excel, salvo los módulos de carga y exportación.

7. El Main.bas no realiza cálculos; únicamente coordina la ejecución del proceso.

---

# Diagrama simplificado

Main.bas

↓

Inicialización

↓

Configuración

↓

Tarifas

↓

Movimientos

↓

Validaciones

↓

Preparación

↓

Recepciones

↓

Picking

↓

Despachos

↓

Estadías

↓

Consolidación

↓

Exportación

↓

Finalización