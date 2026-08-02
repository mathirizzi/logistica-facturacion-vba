Option Explicit

'==========================================
' PARAMETROS DEL PROCESO
'==========================================

Public FechaDesde As Date
Public FechaHasta As Date

Public Cliente As String

Public ModoDebug As Boolean

'==========================================
' NOMBRE DE LAS HOJAS
'==========================================

'Nombre físico de hojas Excel
Public Const HOJA_STOCK_INICIAL As String = "Stock Inicial"

Public Const HOJA_STOCK_FINAL As String = "Stock Final"

Public Const HOJA_MOVIMIENTOS As String = "Movimientos"

Public Const HOJA_RESULTADO As String = "Resultado"

'Clave interna de estructuras

Public Const MAP_STOCK_INICIAL As String = "STOCK_INICIAL"

Public Const MAP_MOVIMIENTOS As String = "MOVIMIENTOS"

Public Const MAP_STOCK_FINAL As String = "STOCK_FINAL"

'=====================================================
' REFERENCIAS A LAS HOJAS
'=====================================================

Public wsStockInicial As Worksheet
Public wsMovimientos As Worksheet
Public wsStockFinal As Worksheet

'=====================================================
' ARRAYS
'=====================================================

Public arrStockInicial As Variant
Public arrMovimientos As Variant
Public arrStockFinal As Variant

'=====================================================
' DICCIONARIO DE COLUMNAS
'=====================================================

' Diccionario principal.
'
' Contiene un Dictionary por cada hoja.
'
' Ejemplo:
' dictColumnas(MAP_MOVIMIENTOS)("PRODUCTO")

Public dictColumnas As Object


'==========================================
' PROCEDIMIENTO PRINCIPAL
'==========================================


'=========================================================
' Inicializa la configuración general del motor.
'
' - Obtiene las hojas del libro.
' - Inicializa las estructuras de configuración.
' - Construye el mapa de columnas.
'=========================================================


Public Sub CargarConfiguracion()

    Debug.Print "Cargando configuración..."

    Call ObtenerHojas

    Set dictColumnas = CreateObject("Scripting.Dictionary")

    Call CargarDiccionarioColumnas

End Sub


'=========================================================
' Obtiene las referencias a las hojas utilizadas
' durante la ejecución del motor.
'=========================================================

Private Sub ObtenerHojas()

    Set wsStockInicial = ThisWorkbook.Worksheets(HOJA_STOCK_INICIAL)

    Set wsMovimientos = ThisWorkbook.Worksheets(HOJA_MOVIMIENTOS)

    Set wsStockFinal = ThisWorkbook.Worksheets(HOJA_STOCK_FINAL)

End Sub


'=========================================================
' Carga el diccionario de columnas del motor.
'
' Para cada hoja configurada:
'   - Lee la fila de encabezados.
'   - Crea un diccionario con el formato:
'         Encabezado -> Número de columna
'   - Lo almacena en dictColumnas.
'
' Ejemplo:
' dictColumnas("MOVIMIENTOS")("PRODUCTO") = 5
'=========================================================

Private Sub CargarDiccionarioColumnas()

    Dim dict As Object

    '-----------------------------
    ' STOCK INICIAL
    '-----------------------------
    Set dict = CreateObject("Scripting.Dictionary")

    Call LeerEncabezados(wsStockInicial, dict)

    dictColumnas.Add MAP_STOCK_INICIAL, dict

    
    '-----------------------------
    ' MOVIMIENTOS
    '-----------------------------
    Set dict = CreateObject("Scripting.Dictionary")

    Call LeerEncabezados(wsMovimientos, dict)

    dictColumnas.Add MAP_MOVIMIENTOS, dict

    '-----------------------------
    ' STOCK FINAL
    '-----------------------------
    Set dict = CreateObject("Scripting.Dictionary")

    Call LeerEncabezados(wsStockFinal, dict)

    dictColumnas.Add MAP_STOCK_FINAL, dict

End Sub



'==================================================
' Lee la fila de encabezados de una hoja
' y arma un diccionario:
'
' "PRODUCTO" -> 3
' "LOTE" -> 4
' "CANTIDAD" -> 8
'==================================================

Private Sub LeerEncabezados(ws As Worksheet, dict As Object)

    Dim col As Long
    Dim encabezado As String

    col = 1

   Do While ws.Cells(1, col).Value <> "" 

    encabezado = UCase(Trim(ws.Cells(1, col).Value))

    If Not dict.Exists(encabezado) Then

    dict.Add encabezado, col

    Else
    Err.Raise vbObjectError + 1001, , _
        "Encabezado duplicado: " & encabezado & _
        " en la hoja " & ws.Name

    End If

    col = col + 1

   Loop

End Sub