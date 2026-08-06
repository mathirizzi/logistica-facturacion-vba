Option Explicit

'=========================================================
' MÓDULO: modImportacion
'
' Responsabilidad:
' Importar los datos desde las hojas de Excel y cargarlos
' en memoria mediante arrays.
'
' Este módulo NO realiza validaciones ni cálculos.
' Únicamente importa la información.
'=========================================================

'=========================================================
' PROCEDIMIENTO PRINCIPAL
'
' Importa toda la información necesaria para el motor.
'=========================================================

Public Sub ImportarDatos()

    Debug.Print "Importando datos..."

    Call ImportarStockInicial

    Call ImportarMovimientos

    Call ImportarStockFinal

End Sub

'=========================================================
' IMPORTA EL STOCK INICIAL
'
' Lee la hoja "Stock Inicial" y carga la información
' en el array arrStockInicial.
'=========================================================

Private Sub ImportarStockInicial()

    arrStockInicial = CargarArray(wsStockInicial)

End Sub

'=========================================================
' IMPORTA LOS MOVIMIENTOS
'
' Lee la hoja "Movimientos" y carga la información
' en el array arrMovimientos.
'=========================================================

Private Sub ImportarMovimientos()

    arrMovimientos = CargarArray(wsMovimientos)

End Sub

'=========================================================
' IMPORTA EL STOCK FINAL
'
' Lee la hoja "Stock Final" y carga la información
' en el array arrStockFinal.
'=========================================================

Private Sub ImportarStockFinal()
    
    arrStockFinal = CargarArray(wsStockFinal)

End Sub


'=========================================================
' CARGA UNA HOJA EN MEMORIA
'
' Lee todos los datos de una hoja y los devuelve
' como un array bidimensional.
'
' El rango leído comienza en A1 e incluye todos los
' registros hasta la última fila y columna utilizadas.
'=========================================================

Private Function CargarArray(ws As Worksheet) As Variant

    Dim ultimaFila As Long
    Dim ultimaColumna As Long

    Dim rango As Range

    '---------------------------------------
    ' Obtener última fila utilizada
    '---------------------------------------

    ultimaFila = ws.Cells(ws.Rows.Count, 1).End(xlUp).Row

    '---------------------------------------
    ' Validar que existan registros
    '---------------------------------------
    If ultimaFila = 1 Then

        Err.Raise vbObjectError + 1010, , _
            "La hoja '" & ws.Name & "' no contiene información para importar."

    End If

    '---------------------------------------
    ' Obtener última columna utilizada
    '---------------------------------------

    ultimaColumna = ws.Cells(1, ws.Columns.Count).End(xlToLeft).Column

    '---------------------------------------
    ' Definir rango a importar
    '---------------------------------------

    Set rango = ws.Range( _
                    ws.Cells(1, 1), _
                    ws.Cells(ultimaFila, ultimaColumna))

    '---------------------------------------
    ' Cargar rango en memoria
    '---------------------------------------

    CargarArray = rango.Value

    Debug.Print "Importando hoja: " & ws.Name & _
            " (" & ultimaFila - 1 & " registros)"

End Function