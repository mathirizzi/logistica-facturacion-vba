# Manual de Requerimientos

## Logistica Facturacion VBA

## 1. Objetivo del sistema

Desarrollar una herramienta que permita automatizar el cálculo de facturación de servicios logísticos a partir de información exportada desde un sistema WMS.

El sistema deberá calcular automáticamente:

* Estadías de pallets.
* Movimientos de ingreso (IN).
* Movimientos de salida completa (OUT).
* Movimientos de picking (PK).
* Generar un detalle diario de facturación.
* Detectar inconsistencias mediante una hoja de incidencias.

El objetivo principal es reducir el trabajo manual de cálculo de facturación y mejorar la trazabilidad de los importes generados.

---

# 2. Alcance

El sistema trabajará con tres fuentes principales de información:

1. Stock inicial del período a facturar.
2. Movimientos realizados durante el período.
3. Stock final del período.

Ejemplo:

Para facturar julio:

* Stock inicial: cierre físico del 30/06.
* Movimientos: movimientos realizados del 01/07 al 31/07.
* Stock final: cierre físico del 31/07.

---

# 3. Conceptos del negocio

## 3.1 Pallet

Un pallet representa una unidad física almacenada en el depósito.

Cada pallet posee:

* Identificador único.
* Cliente asociado.
* Cantidad de bultos.
* Estado (activo/finalizado).

Un pallet no vuelve a utilizar el mismo identificador luego de su baja.

---

# 4. Reglas de facturación

## 4.1 Estadía

La estadía representa el cobro por ocupación física del espacio dentro del depósito.

Reglas:

* Cada pallet genera una estadía por cada día calendario que permanece físicamente en el depósito.
* La estadía se cobra por día completo, independientemente de la cantidad de horas que haya permanecido.
* Si un pallet ingresa y sale el mismo día, genera una estadía.
* Si un pallet sale durante el día, la estadía de ese día igualmente se factura.
* Un pallet continúa generando estadía mientras tenga existencia física, aunque posea solamente un bulto restante.

Ejemplo:

Pallet P001:

Ingreso: 01/07
Salida completa: 05/07

Genera estadía:

01/07 - 02/07 - 03/07 - 04/07 - 05/07

Total: 5 estadías.

---

## 4.2 Movimiento IN

El movimiento IN representa el ingreso físico de un pallet al depósito.

Reglas:

* Cada pallet ingresado genera 1 movimiento IN.
* El IN solamente se factura si ocurre dentro del período facturado.
* Un pallet que ya existía antes del período no vuelve a generar IN.
* Genera una estadia a partir de la fecha de ingreso.

---

## 4.3 Movimiento PK (Picking)

El picking representa una extracción parcial de mercadería de un pallet.

Reglas:

* Cada bulto retirado parcialmente genera 1 PK.
* El PK se factura por cantidad de bultos retirados.
* Un pallet que continúa existiendo luego del movimiento genera PK.

Ejemplo:

Pallet con 30 bultos:

Día 1:
Salida de 10 bultos.

Resultado:
10 PK.

Saldo:
20 bultos.

---

## 4.4 Movimiento OUT

El OUT representa la salida completa de un pallet.

Reglas:

* Se genera cuando un movimiento deja el pallet sin existencia.
* Se factura 1 OUT por pallet finalizado.
* La última salida de un pallet genera OUT y no PK.
* Genera el descuento de 1 estadia a partir del siguiente dia de la fecha de movimiento

Ejemplo:

Pallet con 30 bultos:

Día 1:
Salida 10 → 10 PK

Día 2:
Salida 20 → 1 OUT

Resultado:

PK: 10
OUT: 1

---

# 5. Datos de entrada

## 5.1 Stock inicial

Información necesaria:

* Cliente.
* ID de pallet.
* Cantidad de bultos.

Representa el estado físico al inicio del período.

---

## 5.2 Movimientos

Información necesaria:

* Fecha.
* Cliente.
* ID de pallet.
* Numero de Orden de Procesamiento asociada al movimiento
* Tipo de movimiento.
* Cantidad de bultos.

Los movimientos cargados deberán estar previamente filtrados desde el WMS.
No se deben tomar en cuenta movimientos de ajuste/inventario ya que no generan IN/OUT/PK.
Los movimientos cargados deben ser netamente movimientos operativos.

---

## 5.3 Stock final

Información necesaria:

* Cliente.
* ID de pallet.
* Cantidad de bultos.

Representa el estado físico al cierre del período.

---

# 6. Hoja de incidencias

El sistema deberá detectar situaciones que requieran revisión manual.

Ejemplos:

## Pallet sin ingreso conocido

Un pallet aparece en stock final pero:

* No estaba en stock inicial.
* No posee movimiento IN dentro del período.

Posible causa:

* Ajuste de inventario.

---

## Pallet desaparecido

Un pallet estaba en stock inicial pero:

* No aparece en stock final.
* No posee movimiento OUT.

Posible causa:

* Ajuste de inventario.

---

## Diferencias de saldo

Ejemplos:

* Salida superior al saldo disponible.
* Pallet con cantidades inconsistentes.

---

# 7. Salidas del sistema

El sistema deberá generar:

## Detalle diario

Información:

* Fecha.
* Cliente.
* Estadías.
* Numero de Orden de Procesamiento asociada al movimiento
* IN.
* PK.
* OUT.

---

## Resumen de facturación

Información agrupada por cliente:

* Total estadías.
* Total IN.
* Total PK.
* Total OUT.

---


# 8. Criterios de diseño

El sistema deberá:

* No modificar los datos originales importados.
* Mantener trazabilidad del cálculo.
* Informar inconsistencias en lugar de corregirlas automáticamente.
* Separar lógica de cálculo y presentación.
* Permitir futuras migraciones a otros lenguajes o sistemas.
