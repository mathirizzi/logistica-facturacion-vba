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

