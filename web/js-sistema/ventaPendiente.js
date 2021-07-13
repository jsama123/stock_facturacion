/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function() {
    cargarDatos(19, "cuerpoVentas");
    cargarDatos(2, "clientes");
    cargarDatos(3, "cmbCaja");
    cargarDatos(4, "cmbCajero");
    $("#txtFechaVenta").datepicker();
    $("#btnModificar").hide();
    $("#btnBorrar").hide();
    $("#filaBusquedaCodBarra").hide();
    if ($("#cmbTipoDoc").val() == "fac") {
        $("#divCliente").show();
    }
    $("#cmbTipoPago").on('change', function() {
        //alert($(this).val());
        if ($(this).val() == "2" || $(this).val() == "3") {
            $("#filaBoletaTarjeta").show();
        } else {
            $("#filaBoletaTarjeta").hide();
        }
    });

    $("#cmbTipoDoc").on('change', function() {
        //alert($(this).val());
        if ($(this).val() == "fac") {
            $("#divCliente").show();
        } else {
            $("#divCliente").hide();
        }
    });

    $("#txtPagoVenta").on({
        "focus": function(event) {
            $(event.target).select();
        },
        "keyup": function(event) {
            $(event.target).val(function(index, value) {
                return value.replace(/\D/g, "")
                        .replace(/\B(?=(\d{3})+(?!\d)\.?)/g, ".");
            });
        }
    });

    $("#chkDescGs").on("click", function() {
        if ($(this).is(":checked")) {
            $("#divMontoDescGs").show();
            $("#cmbDescuentoVenta").prop("disabled", "true");
        } else {
            $("#divMontoDescGs").hide();
            $("#cmbDescuentoVenta").prop("disabled", "");
        }
    });

    $("#chkBusquedaCodBarra").on("change", function() {
        if (this.checked) {
            $("#filaBusquedaCodBarra").show();
            $("#filaBusquedaDescri").hide();
        } else {
            $("#filaBusquedaDescri").show();
            $("#filaBusquedaCodBarra").hide();
        }
    });

    $("#txtCodBarraBusqueda").on("keyup", function() {
        setTimeout(buscarArticuloxCodigoBarra(), 5000);
    });
});

function buscarArticuloxCodigoBarra() {
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'VentaDatos.jsp',
        type: 'POST',
        data: {
            opcion: 16,
            codigo_barra: $("#txtCodBarraBusqueda").val(),
            id: $("#txtIdVenta").val()
        },
        dataType: 'html',
        success: function(datos) {
            $("#txtArticulo2").val($.trim(datos));
        },
        error: function() {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
}

function cargarDatos(opcion, objeto, id) {
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'VentaDatos.jsp',
        type: 'POST',
        data: {
            opcion: opcion,
            id: id
        },
        dataType: 'html',
        success: function(datos) {
            if (opcion == 6) {
                var valor = [];
                valor = $.trim(datos).split(",");
                var valor2 = [];
                valor2 = valor[0].split("/");
                var id = valor2[0];
                $("#cmbCaja").val(valor[1]);
                $("#cmbCajero").val(valor[2]);
                $("#txtFechaVenta").val(valor[3]);
                $("#txtId").val(valor[4]);
                if (id == "0") {
                    $("#cmbTipoDoc").val("tck");
                } else {
                    $("#cmbTipoDoc").val("fac");
                    $("#txtCliente").val(valor2[1]);
                }
            } else {
                $("#" + objeto).html($.trim(datos));
                $("#cargando").hide();
            }
        },
        error: function() {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    $('#tblVentas').DataTable();
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
        success: function(datos) {
            retorno = $.trim(datos);
        },
        error: function() {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    return retorno;
}

function obtenerTimbradoVigente() {
    var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'TimbradoDatos.jsp',
        type: 'POST',
        data: {
            opcion: 4,
        },
        dataType: 'html',
        success: function(datos) {
            retorno = $.trim(datos);
        },
        error: function() {
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
        success: function(datos) {
            retorno = $.trim(datos);
        },
        error: function() {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    return retorno;
}

function obtenerUltimoNroTicket() {
    var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'VentaDatos.jsp',
        type: 'POST',
        data: {
            opcion: 11,
        },
        dataType: 'html',
        success: function(datos) {
            retorno = $.trim(datos);
        },
        error: function() {
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
        success: function(datos) {
            retorno = $.trim(datos);
        },
        error: function() {
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
        success: function(datos) {
            retorno = $.trim(datos);
        },
        error: function() {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    return retorno;
}

function obtenerUltimoNroFacturaTimbrado() {
    var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'TimbradoDatos.jsp',
        type: 'POST',
        data: {
            opcion: 6
        },
        dataType: 'html',
        success: function(datos) {
            retorno = $.trim(datos);
        },
        error: function() {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    return retorno;
}

function obtenerNroFactura() {
    var retorno, nro_caja, nro_sucursal, nro_factura;
    switch ($.trim(obtenerNroCaja($("#txtIdVenta").val())).length) {
        case 1:
            nro_caja = "00" + obtenerNroCaja($("#txtIdVenta").val());
            break;
        case 2:
            nro_caja = "0" + obtenerNroCaja($("#txtIdVenta").val());
            break;
    }
    switch ($.trim(obtenerNroSucursal()).length) {
        case 1:
            nro_sucursal = "00" + obtenerNroSucursal();
            break;
        case 2:
            nro_sucursal = "0" + obtenerNroSucursal();
            break;
    }
    if (obtenerIdTimbrado($("#txtIdVenta").val()) !== "") {
        switch ($.trim(obtenerUltimoNroFacturaTimbrado()).length) {
            case 1:
                nro_factura = "000000" + obtenerUltimoNroFacturaTimbrado();
                break;
            case 2:
                nro_factura = "00000" + obtenerUltimoNroFacturaTimbrado();
                break;
            case 3:
                nro_factura = "0000" + obtenerUltimoNroFacturaTimbrado();
                break;
            case 4:
                nro_factura = "000" + obtenerUltimoNroFacturaTimbrado();
                break;
            case 5:
                nro_factura = "00" + obtenerUltimoNroFacturaTimbrado();
                break;
            case 6:
                nro_factura = "0" + obtenerUltimoNroFacturaTimbrado();
                break;
        }
    } else {
        switch ($.trim(obtenerUltimoNroTicket()).length) {
            case 1:
                nro_factura = "000000" + obtenerUltimoNroTicket();
                break;
            case 2:
                nro_factura = "00000" + obtenerUltimoNroTicket();
                break;
            case 3:
                nro_factura = "0000" + obtenerUltimoNroTicket();
                break;
            case 4:
                nro_factura = "000" + obtenerUltimoNroTicket();
                break;
            case 5:
                nro_factura = "00" + obtenerUltimoNroTicket();
                break;
            case 6:
                nro_factura = "0" + obtenerUltimoNroTicket();
                break;
        }
    }
    if (obtenerIdTimbrado($("#txtIdVenta").val()) !== "") {
        retorno = nro_sucursal + "-" + nro_caja + "-" + nro_factura;
    } else {
        retorno = obtenerUltimoNroTicket();
    }
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
    // *******OBTENER EL ID DEL TIMBRADO VIGENTE SI ES FACTURA O SI ES TICKET ASIGNA EL VALOR VACIO
    if ($("#cmbTipoDoc").val() == "fac") {
        id_timbrado = obtenerTimbradoVigente();
        /*if (opcion == "1") {
         actualizarNroFacturaTimbrado(obtenerUltimoNroFacturaTimbrado());
         }
         if(opcion == "3"){
         restarNroFacturaTimbrado(obtenerUltimoNroFacturaTimbrado());
         }*/
    } else {
        id_timbrado = "";
    }
    datosJson = {
        "opcion": opcion,
        "id_cliente": id_cliente,
        "id_cajero": $("#cmbCajero").val(),
        "id_caja": $("#cmbCaja").val(),
        "id_timbrado": id_timbrado,
        "fecha_venta": $("#txtFechaVenta").val(),
        "id_tipo_pago": $("#cmbTipoPago").val(),
        "monto_pago": $("#txtPagoVenta").val().replace(/[^a-z0-9\s]/gi, ''),
        "descuento_venta": valor == 's' ? '0' : $("#cmbDescuentoVenta").val(),
        "nro_boleta_tarjeta": $("#txtNroBoleta").val(),
        "id": idv
    };
    if (validarCampos()) {
        alert("Complete los campos correspondientes");
    } else {
        $.ajax({
            async: false,
            cache: false,
            url: "VentaControl",
            type: 'POST',
            data: datosJson,
            dataType: 'html',
            success: function(data, textStatus, jqXHR) {
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
            error: function(jqXHR, textStatus, errorThrown) {

            }
        });
        $("#btnCancelar").trigger("click");
        $("#tblVentas").DataTable().destroy();
        cargarDatos(19, "cuerpoVentas");
        if (opcion == "4") {
            cargarDatos(10, "cuerpoPagoVenta", $("#txtIdVenta").val());
            $("#txtPagoVenta").val("");
            $('#txtNroBoleta').val('');
        }
        if (opcion == "6") {
            cargarDatos(13, "cuerpoDescuentoVenta", $("#txtIdVenta").val());
            mostrarTotalVentaConDescuento();
        }
    }
}

function actualizarNroFacturaTimbrado(ultimoNroFactura) {
    datosJson = {
        "opcion": 5,
        "ultimoNroFactura": ultimoNroFactura
    };
    $.ajax({
        async: false,
        cache: false,
        url: "TimbradoControl",
        type: 'POST',
        data: datosJson,
        dataType: 'html',
        success: function(data, textStatus, jqXHR) {
        },
        error: function(jqXHR, textStatus, errorThrown) {
        }
    });
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
            $("#modalFormTittle").text("Modificar Registro / Venta");
            $("#btnModificar").show();
            $("[name='camposForm']").prop("disabled", false);
            $("#btnInsertar").hide();
            $("#btnBorrar").hide();
            break;
        case "eliminar":
            $("#modalFormTittle").text("Eliminar Registro / Venta");
            $("#btnBorrar").show();
            $("[name='camposForm']").prop("disabled", true);
            $("#btnModificar").hide();
            $("#btnInsertar").hide();
            break;
        case "insertar":
            $("#modalFormTittle").text("Agregar un Nuevo Registro / Venta");
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
        url: 'VentaDatos.jsp',
        type: 'POST',
        data: {
            opcion: 5,
            id_caja: $("#cmbCaja").val()
        },
        dataType: 'html',
        success: function(datos) {
            retorno = $.trim(datos);
        },
        error: function() {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    return retorno;
}

// *************** FUNCIONES PARA EL DETALLE *********************

function abrirDetalle(id) {
    $("#mensajeProcesandoVenta").hide();
    $('#btnProcesarVenta').attr("disabled", false);
    $("#txtIdVenta").val(id);
    cargarDatos(7, "articulos", id);
    cargarDatos(8, "cuerpoArticuloVentass", id);
    cargarDatos(9, "cmbTipoPago");
    cargarDatos(10, "cuerpoPagoVenta", id);
    cargarDatos(13, "cuerpoDescuentoVenta", id);
    cargarDatos(12, "cmbDescuentoVenta");
    mostrarTotalVenta();
    mostrarTotalVentaConDescuento();
}

function accionProcesoDetalleVenta(opcion, id) {
    var camposArticuloSelect, valores, valores2, valores3 = [];
    var precioArticulo, ivaArticulo, id_stock;
    if ($("#chkBusquedaCodBarra").is(":checked")) {
        camposArticuloSelect = $.trim($("#txtArticulo2").val()).split("|");
    } else {
        camposArticuloSelect = $.trim($("#txtArticulo").val()).split("|");
    }
    valores = $.trim(camposArticuloSelect[2]).split(":");
    precioArticulo = $.trim(valores[1]);

    valores2 = $.trim(camposArticuloSelect[4]).split(":");
    ivaArticulo = $.trim(valores2[1]);

    valores3 = $.trim(camposArticuloSelect[0]).split(":");
    id_stock = $.trim(valores3[1]);
    datosJson = {
        "opcion": opcion,
        "id_venta": $("#txtIdVenta").val(),
        "cantidad_venta": $("#cantidadArticulo").val(),
        "precio_unitario": precioArticulo,
        "iva_aplicado": ivaArticulo,
        "id_stock": id_stock,
        "descuenta_venta": $("#chkDescGs").is(":checked") ? '0' : $("#cmbDescuentoVenta").val(),
        "es_desc_gs_venta": $("#chkDescGs").is(":checked") ? true : false,
        "descuento_gs_venta": $("#chkDescGs").is(":checked") ? $("#txtMontoGsDesc").val() : '0',
        "id": id
    };
    $.ajax({
        async: false,
        cache: false,
        url: "VentaDetalleControl",
        type: 'POST',
        data: datosJson,
        dataType: 'html',
        success: function(data, textStatus, jqXHR) {
            if ($.trim(data) == "bien") {
                $("#sucess").show("slow");
                setTimeout(function() {
                    $("#sucess").fadeOut(1500);
                }, 3000);
            } else {
                $("#error").show("slow");
                setTimeout(function() {
                    $("#sucess").fadeOut(1500);
                }, 3000);
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {

        }
    });
    cargarDatos(8, "cuerpoArticuloVentass", $("#txtIdVenta").val());
    cargarDatos(7, "articulos", $("#txtIdVenta").val());
    mostrarTotalVenta();
    limpiarCampoDetalle();
    if ($("#chkBusquedaCodBarra").is(":checked")) {
        $("#txtCodBarraBusqueda").focus();
    } else {
        $("#txtArticulo").focus();
    }
}

function limpiarCampoDetalle() {
    $("[name='camposFormDetalle']").val("");
    $("#chkDescGs").prop("checked", false);
    $("#cmbDescuentoVenta").prop("disabled", "");
    $("#divMontoDescGs").hide();
}

function mostrarTotalVenta() {
    var total = 0;
    $("#tblArticuloVentas tbody").find('tr').each(function(i) {
        total += parseFloat($(this).find('td').eq(4).text().replace(/[^a-z0-9\s]/gi, ''));
    });
    $("#thTotalVenta").text(humanizeNumber(total));
}

function retornarTotalVenta() {
    var total = 0;
    $("#tblArticuloVentas tbody").find('tr').each(function(i) {
        total += parseFloat($(this).find('td').eq(4).text());
    });
    return total;
}

function humanizeNumber(n) {
    n = n.toString();
    while (true) {
        var n2 = n.replace(/(\d)(\d{3})($|,|\.)/g, '$1,$2$3');
        if (n == n2)
            break;
        n = n2;
    }
    return n;
}

function mostrarTotalVentaConDescuento() {
    var descuento = parseFloat($.trim($("#tdDescVenta").text().replace(/[^a-z0-9\s]/gi, ''))) / 100;
    var descuentoGs = parseFloat($.trim($("#thTotalVenta").text().replace(/[^a-z0-9\s]/gi, ''))) * descuento;
    $("#thTotalconDescuento").text(parseFloat($.trim($("#thTotalVenta").text())) - descuentoGs);
}

function validarCantidadNosupereExistencia() {
    var retorno, existencia;
    var camposArticuloSelect, valores = [];
    if ($("#chkBusquedaCodBarra").is(":checked")) {
        camposArticuloSelect = $.trim($("#txtArticulo2").val()).split("|");
    } else {
        camposArticuloSelect = $.trim($("#txtArticulo").val()).split("|");
    }
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
    $("#txtPagoVenta").val(monto_pago);
}

function obtenerIdTimbrado(id) {
    var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'VentaDatos.jsp',
        type: 'POST',
        data: {
            opcion: 15,
            id: id
        },
        dataType: 'html',
        success: function(datos) {
            retorno = $.trim(datos);
        },
        error: function() {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    return retorno;
}

function finiquitar(opcion, id) {
    $("#mensajeProcesandoVenta").show();
    datosJson = {
        "opcion": opcion,
        "id": id,
        "numero_ticket_venta": obtenerIdTimbrado(id) == "" ? obtenerUltimoNroTicket() : parseInt(obtenerUltimoNroTicket()) - 1
                //"numero_factura_venta": obtenerNroFactura()
    };
    $.ajax({
        async: false,
        cache: false,
        url: "VentaControl",
        type: 'POST',
        data: datosJson,
        dataType: 'html',
        success: function(data, textStatus, jqXHR) {
            if ($.trim(data) == "bien") {
                if (obtenerIdTimbrado(id) !== "") {
                    actualizarNroFacturaTimbrado(obtenerUltimoNroFacturaTimbrado());
                }
                actualizarNroFacturaVenta(8, id);
                if (obtenerIdTimbrado(id) !== "") {
                    window.open("ReporteTicketVenta.jsp?id_venta=" + $("#txtIdVenta").val(), "_blank");
                } else {
                    window.open("ReporteVentaSimple.jsp?id_venta=" + $("#txtIdVenta").val(), "_blank");
                }
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
        error: function(jqXHR, textStatus, errorThrown) {

        }
    });
    $("#btnCancelVenta").trigger("click");
    $("#tblVentas").DataTable().destroy();
    cargarDatos(19, "cuerpoVentas");
}

function actualizarNroFacturaVenta(opcion, id) {
    $("#mensajeProcesandoVenta").show();
    datosJson = {
        "opcion": opcion,
        "id": id,
        "numero_factura_venta": obtenerNroFactura()
    };
    $.ajax({
        async: false,
        cache: false,
        url: "VentaControl",
        type: 'POST',
        data: datosJson,
        dataType: 'html',
        success: function(data, textStatus, jqXHR) {
            if ($.trim(data) == "bien") {
                toastr.success("Operacion Realizada / Nro Factura", "Notificación", {
                    "progressBar": true,
                    "positionClass": "toast-top-center",
                    "timeOut": "2000"
                });
            } else {
                toastr.error("No se pudo realizar la operacion / Nro Factura", "Notificación", {
                    "progressBar": true,
                    "positionClass": "toast-top-center",
                    "timeOut": "2000"
                });
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {

        }
    });
}

function finiquitarVentaImprimir() {
    if ($("#tdDescriPago").text() == "SIN PAGO REGISTRADO") {
        alert("FAVOR REGISTRAR EL PAGO DE LA VENTA A FINIQUITAR !!");
    } else {
        $('#btnProcesarVenta').attr("disabled", true);
        finiquitar(5, $("#txtIdVenta").val());
    }
}

function imprimir(id, id_timbrado) {
    if (id_timbrado !== "t") {
        window.open("ReporteTicketVenta.jsp?id_venta=" + id, "_blank");
    } else {
        window.open("ReporteVentaSimple.jsp?id_venta=" + id, "_blank");
    }
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
        success: function(data, textStatus, jqXHR) {
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
        error: function(jqXHR, textStatus, errorThrown) {
        }
    });
    $("#btnCancelModalClient").trigger("click");
    cargarDatos(2, "clientes");
    $("#txtCliente").focus();
}

function validarInconsistenciasArticulosVenta() {
    var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'VentaDatos.jsp',
        type: 'POST',
        data: {
            opcion: 17,
            id: $("#txtIdVenta").val()
        },
        dataType: 'html',
        success: function(datos) {
            retorno = $.trim(datos);
        },
        error: function() {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    return retorno;
}

function articulosIncosistencia() {
    var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'VentaDatos.jsp',
        type: 'POST',
        data: {
            opcion: 18,
            id: $("#txtIdVenta").val()
        },
        dataType: 'html',
        success: function(datos) {
            retorno = $.trim(datos);
        },
        error: function() {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    return retorno;
}