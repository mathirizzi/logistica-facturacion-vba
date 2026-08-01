Option Explicit

Public Sub EjecutarMotorFacturacion()

    Debug.Print "================================"
    Debug.Print " INICIO MOTOR FACTURACION"
    Debug.Print "================================"

    Call InicializarSistema

    Call CargarConfiguracion

    Call ImportarDatos

    Call ValidarDatos

    Call PrepararDatos

    Call FacturarRecepciones

    Call FacturarPicking

    Call FacturarDespachos

    Call FacturarEstadias

    Call ConsolidarFacturacion

    Call ExportarDatos

    Call FinalizarSistema

    Debug.Print "================================"
    Debug.Print " FIN MOTOR FACTURACION"
    Debug.Print "================================"

End Sub