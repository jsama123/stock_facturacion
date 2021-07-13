/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    cargarDatos(1, "cuerpoVentaManuals");
    cargarDatos(2, "clientes");
    cargarDatos(3, "cmbCaja");
    cargarDatos(4, "cmbCajero");
    $("#txtFechaVentaManual").datepicker();
    $("#btnModificar").hide();
    $("#btnBorrar").hide();
    if ($("#cmbTipoDoc").val() == "fac") {
        $("#divCliente").show();
    }
    $("#cmbTipoDoc").on('change', function () {
        //alert($(this).val());
        if ($(this).val() == "fac") {
            $("#divCliente").show();
        } else {
            $("#divCliente").hide();
        }
    });
    
    $("#chkDescGs").on("click", function () {
        if ($(this).is(":checked")) {
            $("#divMontoDescGs").show();
            $("#cmbDescuentoVentaManual").prop("disabled", "true");
        } else {
            $("#divMontoDescGs").hide();
            $("#cmbDescuentoVentaManual").prop("disabled", "");
        }
    });
});

function cargarDatos(opcion, objeto, id) {
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'VentaManualDatos.jsp',
        type: 'POST',
        data: {
            opcion: opcion,
            id: id
        },
        dataType: 'html',
        success: function (datos) {
            if (opcion == 6) {
                var valor = [];
                valor = $.trim(datos).split(",");
                var valor2 = [];
                valor2 = valor[0].split("/");
                var id = valor2[0];
                $("#cmbCaja").val(valor[1]);
                $("#cmbCajero").val(valor[2]);
                $("#txtFechaVentaManual").val(valor[3]);
                $("#txtNroFactura").val(valor[5]);
                $("#txtId").val(valor[4]);
                if (id == "0") {
                    $("#cmbTipoDoc").val("tck");
                } else {
                    $("#cmbTipoDoc").val("fac");
                }
                $("#txtCliente").val(valor[0]);
            } else {
                $("#" + objeto).html($.trim(datos));
                $("#cargando").hide();
            }
        },
        error: function () {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    $('#tblVentaManuals').DataTable();
    $('.dataTables_length').addClass('bs-select');
}

function obtenerIdClienteSinNombre() {
    var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'ClienteDatos.jsp',
        type: 'POST',
        data: {
            opcion: 3,
        },
        dataType: 'html',
        success: function (datos) {
            retorno = $.trim(datos);
        },
        error: function () {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    return retorno;
}

function validarTimbradoVigente() {
    var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'TimbradoDatos.jsp',
        type: 'POST',
        data: {
            opcion: 5,
        },
        dataType: 'html',
        success: function (datos) {
            retorno = $.trim(datos);
        },
        error: function () {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    return retorno;
}

function obtenerNroCaja(id_caja) {
    var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'CajaDatos.jsp',
        type: 'POST',
        data: {
            opcion: 3,
            id: id_caja
        },
        dataType: 'html',
        success: function (datos) {
            retorno = $.trim(datos);
        },
        error: function () {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    return retorno;
}

function obtenerNroSucursal() {
    var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'SucursalDatos.jsp',
        type: 'POST',
        data: {
            opcion: 3,
        },
        dataType: 'html',
        success: function (datos) {
            retorno = $.trim(datos);
        },
        error: function () {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    return retorno;
}

function accionProceso(opcion, id, valor) {
    var idv;
    var descuento;
    if (opcion != "4" && opcion != "6") {
        idv = $("#txtId").val();
    } else {
        idv = id;
    }

    var id_cliente, id_timbrado, ultimo_nro_ticket, ultimo_nro_factura;
    // *******OBTIENE EL ID DEL CLIENTE SI ES CON NOMBRE O SIN NOMBRE
    if ($("#cmbTipoDoc").val() == "tck") {
        id_cliente = obtenerIdClienteSinNombre();
    } else {
        var campos;
        campos = $.trim($("#txtCliente").val()).split("/");
        id_cliente = campos[0];
    }
    datosJson = {
        "opcion": opcion,
        "id_cliente": id_cliente,
        "id_cajero": $("#cmbCajero").val(),
        "id_caja": $("#cmbCaja").val(),
        "fecha_venta": $("#txtFechaVentaManual").val(),
        "id_tipo_pago": $("#cmbTipoPago").val(),
        "monto_pago": $("#txtPagoVentaManual").val(),
        "numero_factura_venta": $("#txtNroFactura").val(),
        "id": idv
    };
    if (validarCampos()) {
        alert("Complete los campos correspondientes");
    } else {
        $.ajax({
            async: false,
            cache: false,
            url: "VentaManualControl",
            type: 'POST',
            data: datosJson,
            dataType: 'html',
            success: function (data, textStatus, jqXHR) {
                if ($.trim(data) == "bien") {
                    toastr.success("Operacion Realizada", "Notificación", {
                        "progressBar": true,
                        "positionClass": "toast-top-center",
                        "timeOut": "2000"
                    });
                } else {
                    toastr.error("No se pudo realizar la operacion", "Notificación", {
                        "progressBar": true,
                        "positionClass": "toast-top-center",
                        "timeOut": "2000"
                    });
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {

            }
        });
        $("#btnCancelar").trigger("click");
        $("#tblVentaManuals").DataTable().destroy();
        cargarDatos(1, "cuerpoVentaManuals");
        if (opcion == "4") {
            cargarDatos(10, "cuerpoPagoVentaManual", $("#txtIdVentaManual").val());
            $("#txtPagoVentaManual").val("");
        }
        if (opcion == "6") {
            cargarDatos(13, "cuerpoDescuentoVentaManual", $("#txtIdVentaManual").val());
            mostrarTotalVentaManualConDescuento();
        }
    }
}

function limpiarCampos() {
    $("[name='camposForm']").val("");
}

function validarCampos() {
    if ($("#txtNombre").val() == "")
        return true;
}

function abrirFormulario(opcion, id) {
    //alert(id);
    cargarDatos(6, "", id);
    switch (opcion) {
        case "modificar":
            $("#modalFormTittle").text("Modificar Registro / Venta Manual");
            $("#btnModificar").show();
            $("[name='camposForm']").prop("disabled", false);
            $("#btnInsertar").hide();
            $("#btnBorrar").hide();
            break;
        case "eliminar":
            $("#modalFormTittle").text("Eliminar Registro / Venta Manual");
            $("#btnBorrar").show();
            $("[name='camposForm']").prop("disabled", true);
            $("#btnModificar").hide();
            $("#btnInsertar").hide();
            break;
        case "insertar":
            $("#modalFormTittle").text("Agregar un Nuevo Registro / Venta Manual");
            $("#btnInsertar").show();
            $("[name='camposForm']").prop("disabled", false);
            $("#btnBorrar").hide();
            $("#btnModificar").hide();
            break;
    }
}

function validarArqueoCajaAbierto() {
    var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'VentaManualDatos.jsp',
        type: 'POST',
        data: {
            opcion: 5,
            id_caja: $("#cmbCaja").val()
        },
        dataType: 'html',
        success: function (datos) {
            retorno = $.trim(datos);
        },
        error: function () {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    return retorno;
}

// *************** FUNCIONES PARA EL DETALLE *********************

function abrirDetalle(id) {
    $("#txtIdVentaManual").val(id);
    cargarDatos(7, "articulos", id);
    cargarDatos(8, "cuerpoArticuloVentaManualss", id);
    cargarDatos(9, "cmbTipoPago");
    cargarDatos(10, "cuerpoPagoVentaManual", id);
    cargarDatos(13, "cuerpoDescuentoVentaManual", id);
    cargarDatos(12, "cmbDescuentoVentaManual");
    mostrarTotalVentaManual();
}

function accionProcesoDetalleVentaManual(opcion, id) {
    var camposArticuloSelect, valores, valores2, valores3 = [];
    var precioArticulo, ivaArticulo, id_stock;
    camposArticuloSelect = $.trim($("#txtArticulo").val()).split("|");
    valores = $.trim(camposArticuloSelect[2]).split(":");
    precioArticulo = $.trim(valores[1]);

    valores2 = $.trim(camposArticuloSelect[4]).split(":");
    ivaArticulo = $.trim(valores2[1]);

    valores3 = $.trim(camposArticuloSelect[0]).split(":");
    id_stock = $.trim(valores3[1]);
    datosJson = {
        "opcion": opcion,
        "id_venta": $("#txtIdVentaManual").val(),
        "cantidad_venta": $("#cantidadArticulo").val(),
        "precio_unitario": precioArticulo,
        "iva_aplicado": ivaArticulo,
        "id_stock": id_stock,
        "descuenta_venta": $("#chkDescGs").is(":checked")?'0':$("#cmbDescuentoVentaManual").val(),
        "es_desc_gs_venta": $("#chkDescGs").is(":checked")?true:false,
        "descuento_gs_venta":$("#chkDescGs").is(":checked")?$("#txtMontoGsDesc").val():'0',
        "id": id
    };
    $.ajax({
        async: false,
        cache: false,
        url: "VentaManualDetalleControl",
        type: 'POST',
        data: datosJson,
        dataType: 'html',
        success: function (data, textStatus, jqXHR) {
            if ($.trim(data) == "bien") {
                $("#sucess").show("slow");
                setTimeout(function () {
                    $("#sucess").fadeOut(1500);
                }, 3000);
            } else {
                $("#error").show("slow");
                setTimeout(function () {
                    $("#sucess").fadeOut(1500);
                }, 3000);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {

        }
    });
    cargarDatos(8, "cuerpoArticuloVentaManualss", $("#txtIdVentaManual").val());
    cargarDatos(7, "articulos", $("#txtIdVentaManual").val());
    mostrarTotalVentaManual();
    mostrarTotalVentaManualConDescuento();
    limpiarCampoDetalle();
    $("#txtArticulo").focus();
}

function limpiarCampoDetalle() {
    $("[name='camposFormDetalle']").val("");
}

function mostrarTotalVentaManual() {
    var total = 0;
    $("#tblArticuloVentaManuals tbody").find('tr').each(function (i) {
        total += parseFloat($(this).find('td').eq(4).text());
    });
    $("#thTotalVentaManual").text(total);
}

function mostrarTotalVentaManualConDescuento() {
    var descuento = parseFloat($.trim($("#tdDescVentaManual").text())) / 100;
    var descuentoGs = parseFloat($.trim($("#thTotalVentaManual").text())) * descuento;
    $("#thTotalconDescuentoManual").text(parseFloat($.trim($("#thTotalVentaManual").text())) - descuentoGs);
}

function validarCantidadNosupereExistencia() {
    var retorno, existencia;
    var camposArticuloSelect, valores = [];
    camposArticuloSelect = $.trim($("#txtArticulo").val()).split("|");
    valores = $.trim(camposArticuloSelect[3]).split(":");
    existencia = valores[1];
    if (parseInt($("#cantidadArticulo").val()) > parseInt(existencia)) {
        retorno = "s";
    } else {
        retorno = "n";
    }
    return retorno;
}

function completarCamposPago(id_pago, monto_pago) {
    $("#cmbTipoPago").val(id_pago);
    $("#txtPagoVentaManual").val(monto_pago);
}

function finiquitar(opcion, id) {
    datosJson = {
        "opcion": opcion,
        "id": id
    };
    $.ajax({
        async: false,
        cache: false,
        url: "VentaManualControl",
        type: 'POST',
        data: datosJson,
        dataType: 'html',
        success: function (data, textStatus, jqXHR) {
            if ($.trim(data) == "bien") {
                toastr.success("Operacion Realizada", "Notificación", {
                    "progressBar": true,
                    "positionClass": "toast-top-center",
                    "timeOut": "2000"
                });
            } else {
                toastr.error("No se pudo realizar la operacion", "Notificación", {
                    "progressBar": true,
                    "positionClass": "toast-top-center",
                    "timeOut": "2000"
                });
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {

        }
    });
    $("#btnCancelVentaManual").trigger("click");
    $("#tblVentaManuals").DataTable().destroy();
    cargarDatos(1, "cuerpoVentaManuals");
}

function finiquitarVentaManualImprimir() {
    if ($("#tdDescriPago").text() == "SIN PAGO REGISTRADO") {
        alert("FAVOR REGISTRAR EL PAGO DE LA VENTA A FINIQUITAR !!");
    } else {
        finiquitar(5, $("#txtIdVentaManual").val());
    }
}

function imprimir(id) {
    window.open("ReporteVentaManual.jsp?id_venta_manual=" + id, "_blank");
}

function insertarCliente(opcion) {
    datosJson = {
        "opcion": opcion,
        "ci_ruc_cliente": $("#ciRucClient").val(),
        "razon_social_cliente": $("#razonCliente").val()
    };
    $.ajax({
        async: false,
        cache: false,
        url: "ClienteControl",
        type: 'POST',
        data: datosJson,
        dataType: 'html',
        success: function (data, textStatus, jqXHR) {
            if ($.trim(data) == "bien") {
                toastr.success("Operacion Realizada", "Notificación", {
                    "progressBar": true,
                    "positionClass": "toast-top-center",
                    "timeOut": "2000"
                });
            } else {
                toastr.error("No se pudo realizar la operacion", "Notificación", {
                    "progressBar": true,
                    "positionClass": "toast-top-center",
                    "timeOut": "2000"
                });
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
        }
    });
    $("#btnCancelModalClient").trigger("click");
    cargarDatos(2, "clientes");
    $("#txtCliente").focus();
}