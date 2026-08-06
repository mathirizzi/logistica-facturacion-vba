Option Explicit

Public Sub TestConfiguracion()

    Call CargarConfiguracion

    Debug.Print "========================"
    Debug.Print "TEST CONFIGURACION"
    Debug.Print "========================"

    Debug.Print "Hoja Stock Inicial : " & wsStockInicial.Name
    Debug.Print "Hoja Movimientos   : " & wsMovimientos.Name
    Debug.Print "Hoja Stock Final   : " & wsStockFinal.Name

End Sub


'=========================================================
' TEST DEL MÓDULO DE IMPORTACIÓN
'
' Verifica que las hojas se importen correctamente a los
' arrays en memoria.
'=========================================================

Public Sub TestImportacion()

    Debug.Print
    Debug.Print "======================================="
    Debug.Print " TEST IMPORTACION"
    Debug.Print "======================================="

    '---------------------------------------
    ' Preparar configuración
    '---------------------------------------

    Call CargarConfiguracion

    '---------------------------------------
    ' Importar datos
    '---------------------------------------

    Call ImportarDatos

    '---------------------------------------
    ' Mostrar información de los arrays
    '---------------------------------------

    Call MostrarInformacionArray("Stock Inicial", arrStockInicial)

    Call MostrarInformacionArray("Movimientos", arrMovimientos)

    Call MostrarInformacionArray("Stock Final", arrStockFinal)

End Sub


'=========================================================
' Muestra información básica de un array
'=========================================================

Private Sub MostrarInformacionArray( _
                Nombre As String, _
                Datos As Variant)

    Debug.Print
    Debug.Print "Hoja: " & Nombre

    Debug.Print "Filas: " & UBound(Datos, 1)

    Debug.Print "Columnas: " & UBound(Datos, 2)

    Debug.Print "Primer registro:"

    Dim j As Long

    For j = 1 To UBound(Datos, 2)

        Debug.Print Datos(2, j) & vbTab;

    Next j

    Debug.Print

End Sub

