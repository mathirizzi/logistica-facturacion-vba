# Modelo de Datos

## Facturacion Logistica VBA

# 1. Modelo general

El sistema estará compuesto por las siguientes entidades:

* Pallet
* Movimiento
* Registro de Estadía
* Registro de Movimiento Facturado
* Incidencia

La entidad principal del sistema será **Pallet**.

Toda la lógica de facturación se construirá a partir del ciclo de vida de cada pallet.

---

# 2. Entidad Pallet

Representa un pallet físico.

## Atributos

| Campo              | Tipo    | Descripción                                    |
| ------------------ | ------- | ---------------------------------------------- |
| IdPallet           | String  | Identificador único del pallet.                |
| Cliente            | String  | Cliente propietario.                           |
| BultosActuales     | Integer | Cantidad actual de bultos.                     |
| ExisteStockInicial | Boolean | Presente en el stock inicial.                  |
| ExisteStockFinal   | Boolean | Presente en el stock final.                    |
| FechaIngreso       | Date    | Fecha de ingreso dentro del período.           |
| FechaSalida        | Date    | Fecha de salida definitiva dentro del período. |
| CantidadIN         | Integer | Cantidad de IN facturados.                     |
| CantidadOUT        | Integer | Cantidad de OUT facturados.                    |
| CantidadPK         | Integer | Cantidad total de PK facturados.               |
| Estadias           | Integer | Total de estadías generadas en el período.     |

---

# 3. Entidad Movimiento

Representa un movimiento exportado desde el WMS.

## Atributos

| Campo          | Tipo    | Descripción                        |
| -------------- | ------- | ---------------------------------- |
| Fecha          | Date    | Fecha del movimiento.              |
| Cliente        | String  | Cliente.                           |
| Orden          | String  | Orden de procesamiento.            |
| IdPallet       | String  | Pallet involucrado.                |
| Tipo           | String  | IN o OUT.                          |
| CantidadBultos | Integer | Cantidad de bultos del movimiento. |

---

# 4. Entidad Registro de Estadía

Representa el resultado diario de estadías.

## Atributos

| Campo    | Tipo    | Descripción                   |
| -------- | ------- | ----------------------------- |
| Fecha    | Date    | Día facturado.                |
| Cliente  | String  | Cliente.                      |
| Estadias | Integer | Cantidad de estadías del día. |

---

# 5. Entidad Registro de Movimiento Facturado

Representa los movimientos agrupados por orden.

## Atributos

| Campo   | Tipo    | Descripción                      |
| ------- | ------- | -------------------------------- |
| Fecha   | Date    | Fecha del movimiento.            |
| Cliente | String  | Cliente.                         |
| Orden   | String  | Orden de procesamiento.          |
| IN      | Integer | Cantidad de ingresos facturados. |
| PK      | Integer | Picking facturado.               |
| OUT     | Integer | Cantidad de salidas completas.   |

---

# 6. Entidad Incidencia

Representa una inconsistencia detectada durante el procesamiento.

## Atributos

| Campo       | Tipo   | Descripción                      |
| ----------- | ------ | -------------------------------- |
| Tipo        | String | Error o Advertencia.             |
| Cliente     | String | Cliente involucrado.             |
| IdPallet    | String | Pallet involucrado.              |
| Fecha       | Date   | Fecha asociada (si corresponde). |
| Descripcion | String | Explicación de la incidencia.    |

---

# 7. Estructuras en memoria

## Diccionario de Pallets

Clave:

IdPallet

Valor:

Objeto Pallet

Será la estructura principal del sistema.

---

## Lista de Movimientos

Contendrá todos los movimientos del período.

Se recomienda procesarlos ordenados por:

1. Fecha.
2. Orden.
3. Pallet.

---

## Diccionario de Estadías

Clave:

Fecha + Cliente

Valor:

Registro de Estadía

Permitirá acumular automáticamente las estadías diarias.

---

## Diccionario de Movimientos Facturados

Clave:

Fecha + Cliente + Orden

Valor:

Registro de Movimiento Facturado

Permitirá acumular los conceptos IN, PK y OUT correspondientes a cada orden.

---

## Lista de Incidencias

Colección donde se registrarán todas las inconsistencias detectadas.

Al finalizar el proceso se exportará íntegramente a la hoja "Incidencias".

---

# 8. Arquitectura lógica

Durante el procesamiento el sistema seguirá la siguiente estructura:

1. Importar Stock Inicial.
2. Importar Movimientos.
3. Importar Stock Final.
4. Construir el estado de cada pallet.
5. Calcular Estadías.
6. Calcular Movimientos Facturados.
7. Detectar Incidencias.
8. Generar Reportes.

---

# 9. Principios de diseño

* Excel actuará únicamente como origen y destino de la información.
* Toda la lógica del negocio residirá en el código VBA.
* Las reglas de negocio estarán desacopladas de la presentación.
* Cada módulo tendrá una única responsabilidad.
* El modelo deberá poder reutilizarse en una futura implementación del sistema en Java.
