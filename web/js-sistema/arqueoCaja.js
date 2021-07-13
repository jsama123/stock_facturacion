/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    cargarDatos(1, "cuerpoArqueoCaja");
    cargarDatos(2, "cmbCajero");
    cargarDatos(3, "cmbCaja");
    $("#btnModificar").hide();
    $("#btnBorrar").hide();

    $("#txtSaldo").on({
        "focus": function (event) {
            $(event.target).select();
        },
        "keyup": function (event) {
            $(event.target).val(function (index, value) {
                return value.replace(/\D/g, "")
                        .replace(/\B(?=(\d{3})+(?!\d)\.?)/g, ".");
            });
        }
    });
});

function cargarDatos(opcion, objeto, id) {
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'ArqueoCajaDatos.jsp',
        type: 'POST',
        data: {
            opcion: opcion,
            id: id
        },
        dataType: 'html',
        success: function (datos) {
            if (opcion == 5) {
                var valor = [];
                valor = $.trim(datos).split(",");
                $("#txtId").val(id);
                $("#cmbCajero").val(valor[0]);
                $("#cmbCaja").val(valor[1]);
                $("#txtSaldo").val(valor[2]);
            } else {
                $("#" + objeto).html($.trim(datos));
                $("#cargando").hide();
            }
        },
        error: function () {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    $('#tblArqueoCaja').DataTable();
    $('.dataTables_length').addClass('bs-select');
}

function accionProceso(opcion) {
    if (opcion !== 4) {
        datosJson = {
            "opcion": opcion,
            "id_cajero": $("#cmbCajero").val(),
            "id_caja": $("#cmbCaja").val(),
            "saldo_inicial_arqueo_caja": $("#txtSaldo").val().replace(/[^a-z0-9\s]/gi, ''),
            "id": $("#txtId").val()
        };
    } else {
        datosJson = {
            "opcion": opcion,
            "total_arqueo_caja": $("#thTotal").text(),
            "resultado_arqueo_caja": parseFloat($("#thTotal").text()) - parseFloat(obtenerSaldoInicialArqueo($("#txtidArqueo").val())),
            "observacion_arqueo_caja": $("#txtObservacionCierre").val(),
            "id": $("#txtidArqueo").val()
        };
    }
    if (opcion !== 4) {
        if (validarCampos()) {
            alert("Complete los campos correspondientes");
        } else {
            $.ajax({
                async: false,
                cache: false,
                url: "ArqueoCajaControl",
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
            $("#btnCancelArqueo").trigger("click");
            $("#tblArqueoCaja").DataTable().destroy();
            cargarDatos(1, "cuerpoArqueoCaja");
        }
    } else {
        $.ajax({
            async: false,
            cache: false,
            url: "ArqueoCajaControl",
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
        $("#btnCancelArqueo").trigger("click");
        $("#tblArqueoCaja").DataTable().destroy();
        cargarDatos(1, "cuerpoArqueoCaja");
    }
}

function limpiarCampos() {
    $("#txtSaldo").val("");
}

function validarCampos() {
    if ($("#txtSaldo").val() == "")
        return true;
    return false;
}

function abrirFormulario(opcion, id) {
    cargarDatos(5, "", id);
    switch (opcion) {
        case "modificar":
            $("#modalFormTittle").text("Modificar Registro / Arqueo de Caja");
            $("#btnModificar").show();
            $("[name='cmb']").prop("disabled", false);
            $("#txtSaldo").prop("disabled", false);
            $("#btnInsertar").hide();
            $("#btnBorrar").hide();
            break;
        case "eliminar":
            $("#modalFormTittle").text("Eliminar Registro / Arqueo de Caja");
            $("#btnBorrar").show();
            $("#txtSaldo").prop("disabled", true);
            $("[name='cmb']").prop("disabled", true);
            $("#btnModificar").hide();
            $("#btnInsertar").hide();
            break;
        case "insertar":
            $("#modalFormTittle").text("Agregar un Nuevo Registro / Arqueo de Caja");
            $("#btnInsertar").show();
            $("#txtSaldo").prop("disabled", false);
            $("[name='cmb']").prop("disabled", false);
            $("#btnBorrar").hide();
            $("#btnModificar").hide();
            break;
    }
}

function validarArqueo() {
    var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'ArqueoCajaDatos.jsp',
        type: 'POST',
        data: {
            opcion: 4,
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

function obtenerSaldoInicialArqueo(id) {
    var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'ArqueoCajaDatos.jsp',
        type: 'POST',
        data: {
            opcion: 7,
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

// A PARTIR DE ACA CORRESPONDE AL DETALLE

function mostrarTotalArqueo(id) {
    $("#txtidArqueo").val(id);
    var total = 0;
    $("#tblDetalleArqueo tbody").find('tr').each(function (i) {
        total += parseFloat($(this).find('td').eq(2).text());
    });
    $("#thTotal").text(total);
}

function accionProcesoDetalle(opcion, id) {
    datosJson = {
        "opcion": opcion,
        "cantidad": $("#txtCantidadDetail").val(),
        "denominacion": $("#cmbDenominacion").val(),
        "id_arqueo_caja": $("#txtidArqueo").val(),
        "id": id
    };
    $.ajax({
        async: false,
        cache: false,
        url: "ArqueoCajaDetalleControl",
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
    cargarDatos(6, "cuerpoDetalleArqueo", $("#txtidArqueo").val());
    mostrarTotalArqueo($("#txtidArqueo").val());
}

function imprimir(id){
    window.open("ReporteArqueoCaja.jsp?id_arqueo=" +id, "_blank");
}

function validarVentasAbiertas() {
    var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'ArqueoCajaDatos.jsp',
        type: 'POST',
        data: {
            opcion: 8,
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