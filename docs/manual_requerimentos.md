# Manual de Requerimientos

## Facturacion Logistica VBA

# 1. Objetivo

Desarrollar una herramienta que permita automatizar el proceso de facturación de servicios logísticos a partir de información exportada desde un WMS.

El sistema deberá calcular automáticamente:

* Estadías.
* Movimientos de ingreso (IN).
* Movimientos de salida (OUT).
* Movimientos de Picking (PK).
* Generar reportes de respaldo.
* Detectar inconsistencias en la información procesada.

La herramienta tendrá como objetivo minimizar el trabajo manual, reducir errores y facilitar la trazabilidad de cada concepto facturado.

---

# 2. Alcance

El sistema procesará exclusivamente información correspondiente a un período de facturación determinado.

Ejemplo:

Período:

01/07/2026 al 31/07/2026

Archivos necesarios:

* Stock físico al cierre del día anterior al período (30/06).
* Movimientos del período (01/07 al 31/07).
* Stock físico al cierre del último día del período (31/07).

Todos los archivos serán exportados previamente desde el WMS.

---

# 3. Conceptos del negocio

## 3.1 Pallet

Unidad física almacenada en depósito.

Características:

* Posee un identificador único.
* Pertenece a un único cliente.
* Contiene una cantidad determinada de bultos.
* Puede permanecer activo durante varios períodos de facturación.

Un identificador de pallet nunca vuelve a reutilizarse.

---

## 3.2 Bulto

Unidad utilizada para calcular Picking.

Los movimientos parciales se facturan por cantidad de bultos retirados.

---

## 3.3 Orden de procesamiento

Agrupador operativo utilizado por el WMS.

Cada movimiento de ingreso o salida pertenece a una orden.

La orden se utilizará únicamente para la trazabilidad de movimientos.

Las estadías NO se relacionan con órdenes.

---

# 4. Reglas de facturación

## 4.1 Estadías

Las estadías representan la ocupación física del depósito.

Reglas:

* Se factura una estadía por pallet y por día calendario.
* Si un pallet permanece una parte del día, igualmente genera una estadía completa.
* Si un pallet ingresa y sale el mismo día, genera una estadía.
* Mientras exista físicamente, aunque posea un solo bulto, continúa generando estadía.
* La estadía se calcula independientemente de las órdenes de procesamiento.

---

## 4.2 Movimiento IN

Representa el ingreso físico de un pallet.

Reglas:

* Cada pallet ingresado genera un único IN.
* Sólo se factura si ocurre dentro del período facturado.

---

## 4.3 Movimiento PK

Representa una extracción parcial de mercadería.

Reglas:

* Se factura por cantidad de bultos retirados.
* Sólo aplica cuando el pallet continúa existiendo luego del movimiento.

Ejemplo:

Salida parcial de 18 bultos.

Resultado:

18 PK.

---

## 4.4 Movimiento OUT

Representa la salida definitiva del pallet.

Reglas:

* Se factura un único OUT por pallet.
* El OUT ocurre cuando el saldo del pallet llega a cero.

La última extracción nunca genera PK.

Genera únicamente OUT.

---

# 5. Movimientos procesados

Los movimientos utilizados serán exportados desde el WMS.

Se considera que dichos movimientos ya fueron filtrados previamente.

No deberán incluir:

* Ajustes de inventario.
* Movimientos administrativos.
* Movimientos internos no facturables.

---

# 6. Ajustes de inventario

Los ajustes no serán utilizados para calcular facturación.

Sin embargo, podrán provocar diferencias entre:

* Stock inicial.
* Movimientos.
* Stock final.

Estas diferencias deberán informarse como incidencias.

Nunca deberán corregirse automáticamente.

---

# 7. Salidas del sistema

El sistema deberá generar cuatro reportes.

## 7.1 Resumen de Facturación

Agrupado por cliente.

Información:

* Estadías.
* IN.
* PK.
* OUT.

Este reporte será utilizado para emitir la factura.

---

## 7.2 Detalle de Estadías

Agrupado por fecha y cliente.

Información:

* Fecha.
* Cliente.
* Cantidad de estadías.

Este reporte permitirá justificar el cálculo de ocupación del depósito.

---

## 7.3 Detalle de Movimientos

Agrupado por fecha, cliente y orden.

Información:

* Fecha.
* Cliente.
* Orden.
* IN.
* PK.
* OUT.

Este reporte permitirá justificar cada movimiento facturado.

---

## 7.4 Incidencias

Listado de inconsistencias detectadas durante el procesamiento.

Ejemplos:

* Pallet sin ingreso conocido.
* Pallet desaparecido sin OUT.
* Diferencias de saldo.
* Cliente inconsistente.
* PK superior al saldo disponible.

---

# 8. Criterios de diseño

El sistema deberá:

* Trabajar completamente en memoria durante el procesamiento.
* No modificar los datos importados.
* Mantener separación entre lógica de cálculo y presentación.
* Registrar todas las incidencias detectadas.
* Permitir futuras ampliaciones sin modificar el algoritmo principal.
* Facilitar una futura migración a otro lenguaje de programación.
