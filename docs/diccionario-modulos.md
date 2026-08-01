# Diccionario de Módulos

Este documento describe la responsabilidad de cada módulo del sistema.

---

# Main.bas

## Responsabilidad

Punto de entrada del motor.

Controla el orden de ejecución del proceso.

No contiene lógica de negocio.

---

# Inicializacion.bas

## Responsabilidad

Preparar el entorno de trabajo.

Ejemplos:

- Inicializar variables globales.
- Limpiar estructuras temporales.
- Registrar inicio del proceso.

---

# Configuracion.bas

## Responsabilidad

Leer todos los parámetros de configuración.

Ejemplos:

- Período a facturar.
- Cliente.
- Carpeta de salida.
- Opciones generales.

---


# Movimientos.bas

## Responsabilidad

Leer todos los movimientos que serán facturados.

Puede obtener datos desde:

- Excel
- Base de datos
- Archivos externos

No realiza cálculos.

---

# Validaciones.bas

## Responsabilidad

Verificar que toda la información sea válida antes de comenzar la facturación.

Ejemplos:

- Clientes inexistentes.
- Productos inválidos.
- Fechas incorrectas.

---

# Preparacion.bas

## Responsabilidad

Preparar la información para el cálculo.

Ejemplos:

- Ordenar movimientos.
- Agrupar registros.
- Generar estructuras auxiliares.

---

# FacturacionRecepciones.bas

## Responsabilidad

Calcular todos los conceptos relacionados con recepciones.

No calcula otros conceptos.

---


# FacturacionPicking.bas

## Responsabilidad

Calcular picking.

---

# FacturacionDespachos.bas

## Responsabilidad

Calcular despachos.

---

# FacturacionEstadias.bas

## Responsabilidad

Calcular estadías.

---


# Consolidacion.bas

## Responsabilidad

Unificar todos los conceptos calculados.

Generar el detalle final de la factura.

Calcular subtotales.

Calcular total general.

---

# Exportacion.bas

## Responsabilidad

Generar los archivos finales.

Ejemplos:

- Excel
- PDF
- CSV
- TXT

---

# Finalizacion.bas

## Responsabilidad

Cerrar correctamente el proceso.

Ejemplos:

- Liberar memoria.
- Registrar fin del proceso.
- Mostrar resumen final.

---

# Reglas generales

Todos los módulos deben cumplir las siguientes reglas:

1. Tener una única responsabilidad.

2. No duplicar lógica.

3. No acceder directamente a módulos posteriores.

4. No modificar información que no les pertenece.

5. Mantener procedimientos pequeños y específicos.

6. Ser reutilizables.

7. Estar documentados.