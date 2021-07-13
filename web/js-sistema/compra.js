/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    cargarDatos(1, "cuerpoCompras");
    cargarDatos(2, "proveedores");
    cargarDatos(3, "cmbCaja");
    cargarDatos(4, "cmbCajero");
    cargarDatos(11, "cmbDepositoDestino");
    $("#txtFechaCompra").datepicker();
    $("#txtFechaPagoCuo").datepicker();
    $("#btnModificar").hide();
    $("#btnBorrar").hide();
    if ($("#cmbTipoDoc").val() == "fac") {
        $("#divProveedor").show();
    }

    if ($("#cmbTipoCompra").val() == "CON") {
        $("#divMontoEn").hide();
        $("#divRowCre").hide();
    }

    $("#cmbTipoDoc").on('change', function () {
        //alert($(this).val());
        if ($(this).val() == "fac") {
            $("#divProveedor").show();
        } else {
            $("#divProveedor").hide();
        }
    });

    $("#checkNewCosto").on("click", function () {
        if ($(this).is(":checked")) {
            $("#divNewCosto").show();
        } else {
            $("#divNewCosto").hide();
        }
    });

    $("#cmbTipoCompra").on('change', function () {
        //alert($(this).val());
        if ($(this).val() == "CON") {
            $("#divMontoEn").hide();
            $("#divRowCre").hide();
        } else {
            $("#divMontoEn").show();
            $("#divRowCre").show();
        }
    });
});


function validarNroFacturaDuplicado(){
    var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'CompraDatos.jsp',
        type: 'POST',
        data: {
            opcion: 12,
            nroFactura: $("#txtNroFacturaCompra").val()
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

function cargarDatos(opcion, objeto, id, id_deposito) {
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'CompraDatos.jsp',
        type: 'POST',
        data: {
            opcion: opcion,
            id: id,
            id_deposito : id_deposito
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
                $("#txtFechaCompra").val(valor[3]);
                $("#txtNroFacturaCompra").val(valor[5]);
                $("#txtId").val(valor[4]);
                $("#cmbTipoCompra").val(valor[6]);
                $("#txtProveedor").val(valor[0]);
                $("#txtMontoEntregadoCompra").val(valor[7]);
                $("#txtFechaCuo").val(valor[8]);
                $("#txtCuotaCompra").val(valor[9]);
                $("#cmbDepositoDestino").val(valor[10]);
                $("#txtTimbradoCompra").val(valor[11]);
                if ($("#cmbTipoCompra").val() == "CRE") {
                    $("#divMontoEn").show();
                    $("#divRowCre").show();
                } else {
                    $("#divMontoEn").hide();
                    $("#divRowCre").hide();
                }
            } else {
                $("#" + objeto).html($.trim(datos));
                $("#cargando").hide();
            }
        },
        error: function () {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    $('#tblCompras').DataTable();
    $('.dataTables_length').addClass('bs-select');
}

function obtenerIdProveedorSinNombre() {
    var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'ProveedorDatos.jsp',
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

function accionProceso(opcion, id, valor) {
    var idv;
    var descuento;
    if (opcion != "4" && opcion != "6") {
        idv = $("#txtId").val();
    } else {
        idv = id;
    }

    var id_proveedor, id_timbrado, ultimo_nro_ticket, ultimo_nro_factura;
    // *******OBTIENE EL ID DEL CLIENTE SI ES CON NOMBRE O SIN NOMBRE
    if ($("#cmbTipoDoc").val() == "tck") {
        id_proveedor = obtenerIdProveedorSinNombre();
    } else {
        var campos;
        campos = $.trim($("#txtProveedor").val()).split("/");
        id_proveedor = campos[0];
    }
    datosJson = {
        "opcion": opcion,
        "id_proveedor": id_proveedor,
        "id_cajero": $("#cmbCajero").val(),
        "id_caja": $("#cmbCaja").val(),
        "fecha_compra": $("#txtFechaCompra").val(),
        "numero_factura_compra": $("#txtNroFacturaCompra").val(),
        "tipo_compra": $("#cmbTipoCompra").val(),
        "monto_entregado_compra": $("#txtMontoEntregadoCompra").val(),
        "fecha_vencimiento_cuota_compra": $("#txtFechaCuo").val(),
        "cantidad_cuota_compra": $("#txtCuotaCompra").val(),
        "id_deposito": $("#cmbDepositoDestino").val(),
        "timbrado_compra": $("#txtTimbradoCompra").val(),
        "id": idv
    };
    if (validarCampos()) {
        alert("Complete los campos correspondientes");
    } else {
        $.ajax({
            async: false,
            cache: false,
            url: "CompraControl",
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
        $("#tblCompras").DataTable().destroy();
        cargarDatos(1, "cuerpoCompras");
        if (opcion == "4") {
            cargarDatos(10, "cuerpoPagoCompra", $("#txtIdCompra").val());
            $("#txtPagoCompra").val("");
        }
        if (opcion == "6") {
            cargarDatos(13, "cuerpoDescuentoCompra", $("#txtIdCompra").val());
            mostrarTotalCompraConDescuento();
        }
    }
}

function limpiarCampos() {
    $("[name='camposForm']").val("");
}

function validarCampos() {
    if ($("#txtTimbradoCompra").val() == "")
        return true;
}

function abrirFormulario(opcion, id) {
    //alert(id);
    cargarDatos(6, "", id);
    switch (opcion) {
        case "modificar":
            $("#modalFormTittle").text("Modificar Registro / Compra");
            $("#btnModificar").show();
            $("[name='camposForm']").prop("disabled", false);
            $("#btnInsertar").hide();
            $("#btnBorrar").hide();
            break;
        case "eliminar":
            $("#modalFormTittle").text("Eliminar Registro / Compra");
            $("#btnBorrar").show();
            $("[name='camposForm']").prop("disabled", true);
            $("#btnModificar").hide();
            $("#btnInsertar").hide();
            break;
        case "insertar":
            $("#modalFormTittle").text("Agregar un Nuevo Registro / Compra");
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
        url: 'CompraDatos.jsp',
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

function abrirDetalle(id, id_deposito) {
    $("#txtIdCompra").val(id);
    $("#txtIdCompra2").val(id);
    $("#txtIdDeposito").val(id_deposito);
    cargarDatos(7, "articulos", id, id_deposito);
    cargarDatos(8, "cuerpoArticuloComprass", id);
    mostrarTotalCompra();

    cargarDatos(9, "cmbTipoComprobante");
    cargarDatos(10, "cuerpoCuotaCompra", id);
}

function accionProcesoDetalleCompra(opcion, id) {
    var camposArticuloSelect, valores, valores2, valores3 = [];
    var costoArticulo, ivaArticulo, id_stock;
    camposArticuloSelect = $.trim($("#txtArticulo").val()).split("|");
    valores = $.trim(camposArticuloSelect[2]).split(":");
    costoArticulo = $.trim(valores[1]);

    valores2 = $.trim(camposArticuloSelect[4]).split(":");
    ivaArticulo = $.trim(valores2[1]);

    valores3 = $.trim(camposArticuloSelect[0]).split(":");
    id_stock = $.trim(valores3[1]);
    datosJson = {
        "opcion": opcion,
        "id_compra": $("#txtIdCompra").val(),
        "cantidad_compra": $("#cantidadArticulo").val(),
        "costo_unitario": $("#checkNewCosto").is(":checked") ? $("#nuevoCosto").val() : costoArticulo,
        "iva_aplicado": ivaArticulo,
        "id_stock": id_stock,
        "id": id
    };
    $.ajax({
        async: false,
        cache: false,
        url: "CompraDetalleControl",
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
                    $("#error").fadeOut(1500);
                }, 3000);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {

        }
    });
    if (opcion == 1 && $("#checkNewCosto").is(":checked")) {
        actualizarCostoArticulo(4);
    }
    cargarDatos(8, "cuerpoArticuloComprass", $("#txtIdCompra").val());
    cargarDatos(7, "articulos", $("#txtIdCompra").val(), $("#txtIdDeposito").val());
    mostrarTotalCompra();
    limpiarCampoDetalle();
    $("#checkNewCosto").prop("checked", false);
    $("#divNewCosto").hide();
    $("#txtArticulo").focus();
}

function limpiarCampoDetalle() {
    $("[name='camposFormDetalle']").val("");
}

function humanizeNumber(n) {
  n = n.toString();
  while (true) {
    var n2 = n.replace(/(\d)(\d{3})($|,|\.)/g, '$1,$2$3');
    if (n == n2) break;
    n = n2;
  }
  return n;
}

function mostrarTotalCompra() {
    var total = 0;
    $("#tblArticuloCompras tbody").find('tr').each(function (i) {
        total += parseFloat($(this).find('td').eq(3).text().replace(/[^a-z0-9\s]/gi, ''));
    });
    $("#thTotalCompra").text(humanizeNumber(total));
}

function finiquitar(opcion, id) {
    datosJson = {
        "opcion": opcion,
        "id": id
    };
    $.ajax({
        async: false,
        cache: false,
        url: "CompraControl",
        type: 'POST',
        data: datosJson,
        dataType: 'html',
        success: function (data, textStatus, jqXHR) {
            if ($.trim(data) == "bien") {
                actualizarMontoTotalCompra(id, obtenerMontoCompraFiniquitada(id));
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
    $("#btnCancelCompra").trigger("click");
    $("#tblCompras").DataTable().destroy();
    cargarDatos(1, "cuerpoCompras");
}

function actualizarMontoTotalCompra(id, monto) {
    datosJson = {
        "opcion": 7,
        "id": id,
        "monto_total_compra": monto
    };
    $.ajax({
        async: false,
        cache: false,
        url: "CompraControl",
        type: 'POST',
        data: datosJson,
        dataType: 'html',
        success: function (data, textStatus, jqXHR) {
            if ($.trim(data) == "bien") {
                toastr.success("Operacion Realizada / Monto de Compra Actualizada", "Notificación", {
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
}

function obtenerMontoCompraFiniquitada(id){
    var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'CompraDatos.jsp',
        type: 'POST',
        data: {
            opcion: 13,
            id: id
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

function finiquitarCompraImprimir() {
    finiquitar(5, $("#txtIdCompra").val());
}

function imprimir(id) {
    window.open("ReporteCompra.jsp?id_compra=" + id, "_blank");
}

function insertarProveedor(opcion) {
    datosJson = {
        "opcion": opcion,
        "ci_ruc_proveedor": $("#ciRucProveedor").val(),
        "razon_social_proveedor": $("#razonProveedor").val()
    };
    $.ajax({
        async: false,
        cache: false,
        url: "ProveedorControl",
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
    $("#btnCancelModalProveedor").trigger("click");
    cargarDatos(2, "proveedores");
    $("#txtProveedor").focus();
}

function actualizarCostoArticulo(opcion) {
    var camposArticuloSelect, valores3 = [];
    var id_stock;
    camposArticuloSelect = $.trim($("#txtArticulo").val()).split("|");

    valores3 = $.trim(camposArticuloSelect[0]).split(":");
    id_stock = $.trim(valores3[1]);
    datosJson = {
        "opcion": opcion,
        "costo": $("#nuevoCosto").val(),
        "id": obtenerIdArticulo(id_stock)
    };
    $.ajax({
        async: false,
        cache: false,
        url: "ArticuloControl",
        type: 'POST',
        data: datosJson,
        dataType: 'html',
        success: function (data, textStatus, jqXHR) {
            if ($.trim(data) == "bien") {
                $("#sucessArt").show("slow");
                setTimeout(function () {
                    $("#sucessArt").fadeOut(1500);
                }, 3000);
            } else {
                $("#errorArt").show("slow");
                setTimeout(function () {
                    $("#errorArt").fadeOut(1500);
                }, 3000);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {

        }
    });
}
;

function obtenerIdArticulo(id_stock) {
    var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'StockDatos.jsp',
        type: 'POST',
        data: {
            opcion: 4,
            id_stock: id_stock
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

function accionProcesoCuotaCompra(opcion, id) {
    datosJson = {
        "opcion": opcion,
        "id_compra": $("#txtIdCompra2").val(),
        "fecha_pago_cuota": $("#txtFechaPagoCuo").val(),
        "nro_comprobante_pago_cuota": $("#txtNroCompPago").val(),
        "monto_pagado_cuota": $("#txtMontoCuoPago").val(),
        "id_tipo_comprobante": $("#cmbTipoComprobante").val(),
        "id": id
    };
    $.ajax({
        async: false,
        cache: false,
        url: "CompraCreditoControl",
        type: 'POST',
        data: datosJson,
        dataType: 'html',
        success: function (data, textStatus, jqXHR) {
            if ($.trim(data) == "bien") {
                $("#sucess2").show("slow");
                setTimeout(function () {
                    $("#sucess2").fadeOut(1500);
                }, 3000);
            } else {
                $("#error2").show("slow");
                setTimeout(function () {
                    $("#error2").fadeOut(1500);
                }, 3000);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {

        }
    });
    cargarDatos(10, "cuerpoCuotaCompra", $("#txtIdCompra2").val());
}