/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    cargarDatos(1, "cuerpoNotaPresupuestos");
    cargarDatos(2, "clientesNP");
    $("#txtFechaNotaPresupuesto").datepicker();
    $("#btnModificar").hide();
    $("#btnBorrar").hide();
});

function cargarDatos(opcion, objeto, id) {
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'NotaPresupuestoDatos.jsp',
        type: 'POST',
        data: {
            opcion: opcion,
            id: id
        },
        dataType: 'html',
        success: function (datos) {
            if (opcion == 4) {
                var valor = [];
                valor = $.trim(datos).split(",");
                $("#txtClienteNP").val(valor[0]);
                $("#txtFechaNotaPresupuesto").val(valor[1]);
                $("#txtObsNP").val(valor[2]);
                $("#txtIdNP").val(id)
            } else {
                $("#" + objeto).html($.trim(datos));
                $("#cargando").hide();
            }
        },
        error: function () {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    $('#tblNotaPresupuestos').DataTable();
    $('.dataTables_length').addClass('bs-select');
}

function obtenerUltimoNroNota() {
    var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'NotaPresupuestoDatos.jsp',
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

function accionProceso(opcion, id, valor) {
    var id_proveedor;
        var campos;
        campos = $.trim($("#txtClienteNP").val()).split("/");
        id_proveedor = campos[0];
    datosJson = {
        "opcion": opcion,
        "id_cliente": id_proveedor,
        "fecha_presupuesto": $("#txtFechaNotaPresupuesto").val(),
        "nro_nota_presupuesto": obtenerUltimoNroNota(),
        "observacion_presupuesto": $("#txtObsNP").val(),
        "id": $("#txtIdNP").val()
    };
    if (validarCampos()) {
        alert("Complete los campos correspondientes");
    } else {
        $.ajax({
            async: false,
            cache: false,
            url: "NotaPresupuestoControl",
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
        $("#tblNotaPresupuestos").DataTable().destroy();
        cargarDatos(1, "cuerpoNotaPresupuestos");
    }
}

function limpiarCampos() {
    $("[name='camposForm']").val("");
}

function validarCampos() {
    if ($("#txtTimbradoNotaPresupuesto").val() == "")
        return true;
}

function abrirFormulario(opcion, id) {
    //alert(id);
    cargarDatos(4, "", id);
    switch (opcion) {
        case "modificar":
            $("#modalFormTittle").text("Modificar Registro / NotaPresupuesto");
            $("#btnModificar").show();
            $("[name='camposForm']").prop("disabled", false);
            $("#btnInsertar").hide();
            $("#btnBorrar").hide();
            break;
        case "eliminar":
            $("#modalFormTittle").text("Eliminar Registro / NotaPresupuesto");
            $("#btnBorrar").show();
            $("[name='camposForm']").prop("disabled", true);
            $("#btnModificar").hide();
            $("#btnInsertar").hide();
            break;
        case "insertar":
            $("#modalFormTittle").text("Agregar un Nuevo Registro / NotaPresupuesto");
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
        url: 'NotaPresupuestoDatos.jsp',
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
    $("#txtIdNotaPresupuesto").val(id);
    $("#txtIdNotaPresupuesto2").val(id);
    $("#txtIdDeposito").val(id_deposito);
    cargarDatos(5, "articulosNP", id);
    cargarDatos(6, "cmbDescNP");
    cargarDatos(7, "cuerpoArticuloNotaPresupuestoss", $("#txtIdNotaPresupuesto").val());
    //cargarDatos(8, "cuerpoArticuloNotaPresupuestoss", id);
    mostrarTotalNotaPresupuesto();
}

function accionProcesoDetalleNotaPresupuesto(opcion, id) {
    var camposArticuloSelect, valores, valores2, valores3 = [];
    var costoArticulo, ivaArticulo, id_stock;
    camposArticuloSelect = $.trim($("#txtArticuloNP").val()).split("|");
    valores = $.trim(camposArticuloSelect[2]).split(":");
    costoArticulo = $.trim(valores[1]);

    valores2 = $.trim(camposArticuloSelect[3]).split(":");
    ivaArticulo = $.trim(valores2[1]);

    valores3 = $.trim(camposArticuloSelect[0]).split(":");
    id_stock = $.trim(valores3[1]);
    datosJson = {
        "opcion": opcion,
        "id_nota_presu": $("#txtIdNotaPresupuesto").val(),
        "id_articulo": id_stock,
        "cantidad_venta": $("#cantidadArticuloNP").val(),
        "precio_unitario": costoArticulo,
        "iva_aplicado": ivaArticulo,
        "descuenta_venta": $("#cmbDescNP").val(),
        "id": id
    };
    $.ajax({
        async: false,
        cache: false,
        url: "NotaPresupuestoDetalleControl",
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
    cargarDatos(7, "cuerpoArticuloNotaPresupuestoss", $("#txtIdNotaPresupuesto").val());
    cargarDatos(5, "articulosNP", $("#txtIdNotaPresupuesto").val());
    mostrarTotalNotaPresupuesto();
    limpiarCampoDetalle();
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

function mostrarTotalNotaPresupuesto() {
    var total = 0;
    $("#tblArticuloNotaPresupuestos tbody").find('tr').each(function (i) {
        total += parseFloat($(this).find('td').eq(3).text().replace(/[^a-z0-9\s]/gi, ''));
    });
    $("#thTotalNotaPresupuesto").text(humanizeNumber(total));
}

function finiquitar(opcion, id) {
    datosJson = {
        "opcion": opcion,
        "id": id
    };
    $.ajax({
        async: false,
        cache: false,
        url: "NotaPresupuestoControl",
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
    $("#btnCancelNotaPresupuesto").trigger("click");
    $("#tblNotaPresupuestos").DataTable().destroy();
    cargarDatos(1, "cuerpoNotaPresupuestos");
}

function finiquitarNotaPresupuestoImprimir() {
    finiquitar(5, $("#txtIdNotaPresupuesto").val());
}

function imprimir(id) {
    window.open("ReporteNotaPresupuesto.jsp?id_nota_presu=" + id, "_blank");
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

function accionProcesoCuotaNotaPresupuesto(opcion, id) {
    datosJson = {
        "opcion": opcion,
        "id_notaPresupuesto": $("#txtIdNotaPresupuesto2").val(),
        "fecha_pago_cuota": $("#txtFechaPagoCuo").val(),
        "nro_comprobante_pago_cuota": $("#txtNroCompPago").val(),
        "monto_pagado_cuota": $("#txtMontoCuoPago").val(),
        "id_tipo_comprobante": $("#cmbTipoComprobante").val(),
        "id": id
    };
    $.ajax({
        async: false,
        cache: false,
        url: "NotaPresupuestoCreditoControl",
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
    cargarDatos(10, "cuerpoCuotaNotaPresupuesto", $("#txtIdNotaPresupuesto2").val());
}