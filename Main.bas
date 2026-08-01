Option Explicit

Public Sub EjecutarMotorFacturacion()

    Debug.Print "======================================"
    Debug.Print " INICIO MOTOR DE FACTURACION"
    Debug.Print "======================================"

    ' Inicialización
    Call InicializarSistema

    ' Configuración
    Call CargarConfiguracion

    ' Datos base
    Call CargarTarifas
    Call CargarMovimientos

    ' Control previo
    Call ValidarDatos
    Call PrepararDatos

    ' Proceso de facturación
    Call FacturarRecepciones
    Call FacturarAlmacenaje
    Call FacturarPicking
    Call FacturarDespachos
    Call FacturarEstadias
    Call FacturarServicios

    ' Resultado
    Call ConsolidarFactura

    ' Salida
    Call ExportarResultado

    ' Cierre
    Call FinalizarProceso


    Debug.Print "======================================"
    Debug.Print " FIN MOTOR DE FACTURACION"
    Debug.Print "======================================"

End Sub






