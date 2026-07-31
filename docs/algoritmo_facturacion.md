# Algoritmo de Facturación

## Facturacion Logistica VBA

# 1. Objetivo

Procesar la información exportada desde el WMS para generar automáticamente:

* Resumen de Facturación.
* Detalle de Estadías.
* Detalle de Movimientos.
* Hoja de Incidencias.

Todo el procesamiento se realizará completamente en memoria.

---

# 2. Datos de Entrada

El algoritmo recibirá tres conjuntos de datos:

## Stock Inicial

Representa el stock físico existente al cierre del día anterior al período facturado.

Ejemplo:

Facturación Julio

Stock Inicial = Cierre 30/06

---

## Movimientos

Contiene únicamente movimientos facturables ocurridos durante el período.

Los movimientos deberán estar ordenados cronológicamente.

Cada movimiento contiene:

* Fecha
* Cliente
* Orden
* Pallet
* Tipo (IN / OUT)
* Cantidad de Bultos

---

## Stock Final

Representa el stock físico al cierre del último día del período.

Ejemplo:

Facturación Julio

Stock Final = Cierre 31/07

---

# 3. Flujo General

El procesamiento seguirá el siguiente orden:

1. Leer Stock Inicial.
2. Leer Movimientos.
3. Leer Stock Final.
4. Construir el estado de cada pallet.
5. Procesar movimientos.
6. Calcular Estadías.
7. Detectar Incidencias.
8. Generar Reportes.

---

# 4. Construcción del Estado de Pallets

Se creará un Diccionario de Pallets utilizando como clave el ID del pallet.

Durante esta etapa:

* Se incorporarán todos los pallets presentes en el Stock Inicial.
* Se incorporarán los pallets que aparezcan únicamente en los movimientos.
* Se incorporarán los pallets presentes únicamente en el Stock Final.

Cada pallet almacenará toda la información necesaria para su procesamiento.

---

# 5. Procesamiento de Movimientos

Los movimientos se recorrerán en orden cronológico.

Para cada movimiento:

## Movimiento IN

* Registrar fecha de ingreso.
* Incrementar contador de IN.
* Registrar el movimiento en el Detalle de Movimientos.

---

## Movimiento OUT

Determinar si el movimiento corresponde a:

### Salida Parcial

Si luego del movimiento el pallet continúa existiendo:

* Facturar PK por la cantidad de bultos retirados.
* Registrar PK en la orden correspondiente.

---

### Salida Total

Si luego del movimiento el pallet deja de existir:

* Facturar un único OUT.
* Registrar la fecha de salida.
* Registrar el OUT en la orden correspondiente.

---

# 6. Cálculo de Estadías

Una vez finalizados los movimientos se calcularán las estadías.

Las estadías se obtendrán recorriendo cada día del período.

Para cada pallet:

* Determinar si el pallet existió físicamente durante ese día.
* Si existió:

  * Incrementar la estadía del pallet.
  * Incrementar la estadía del cliente para esa fecha.

Las estadías nunca estarán asociadas a órdenes de procesamiento.

---

# 7. Generación del Detalle de Movimientos

Los movimientos facturados se agruparán por:

* Fecha
* Cliente
* Orden

Para cada grupo se acumularán:

* IN
* PK
* OUT

---

# 8. Generación del Detalle de Estadías

Las estadías se agruparán por:

* Fecha
* Cliente

Para cada combinación se almacenará:

* Cantidad total de estadías.

---

# 9. Generación del Resumen de Facturación

A partir del Detalle de Estadías y del Detalle de Movimientos se calculará el resumen por cliente.

Para cada cliente se obtendrá:

* Total Estadías
* Total IN
* Total PK
* Total OUT

---

# 10. Detección de Incidencias

Durante todo el procesamiento el sistema registrará inconsistencias.

Ejemplos:

* Pallet presente en Stock Final sin Stock Inicial ni movimiento IN.
* Pallet presente en Stock Inicial que desaparece sin movimiento OUT.
* Cliente inconsistente.
* Saldo negativo.
* Movimiento OUT sobre pallet inexistente.
* PK superior al saldo disponible.

Las incidencias nunca serán corregidas automáticamente.

---

# 11. Generación de Reportes

Al finalizar el procesamiento se generarán las siguientes hojas:

## Resumen de Facturación

Información consolidada por cliente.

---

## Detalle de Estadías

Información diaria por cliente.

---

## Detalle de Movimientos

Información agrupada por:

* Fecha
* Cliente
* Orden

---

## Incidencias

Listado completo de inconsistencias detectadas.

---

# 12. Principios del Algoritmo

* Nunca modificar los datos importados.
* Todo cálculo se realizará en memoria.
* Cada pallet será procesado una única vez.
* Los movimientos serán la única fuente para calcular IN, PK y OUT.
* Los stocks inicial y final serán utilizados para validar y calcular estadías.
* La lógica de negocio permanecerá independiente de la presentación en Excel.
