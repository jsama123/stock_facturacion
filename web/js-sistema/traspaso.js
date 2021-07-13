/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function() {
    cargarDatos(1, "cuerpoTraspasos");
    cargarDatos(2, "cmbDepOrigen");
    cargarDatos(3, "cmbDepDestino");
    $("#btnModificar").hide();
    $("#btnBorrar").hide();
    $("#txtFechaTraspaso").datepicker();
});

function cargarDatos(opcion, objeto, id, id_deposito) {
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'TraspasoDatos.jsp',
        type: 'POST',
        data: {
            opcion: opcion,
            id: id,
            id_deposito: id_deposito
        },
        dataType: 'html',
        success: function(datos) {
            if (opcion == 4) {
                var valor = [];
                valor = $.trim(datos).split(",");
                $("#txtId").val(valor[0]);
                $("#cmbDepDestino").val(valor[1]);
                $("#cmbDepOrigen").val(valor[2]);
                $("#txtFechaTraspaso").val(valor[3]);
                $("#txtObserTraspaso").val(valor[4]);
            } else {
                $("#" + objeto).html($.trim(datos));
                $("#cargando").hide();
            }
        },
        error: function() {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    $('#tblTraspasos').DataTable();
    $('.dataTables_length').addClass('bs-select');
}

function accionProceso(opcion) {
    datosJson = {
        "opcion": opcion,
        "id_deposito_destino": $("#cmbDepDestino").val(),
        "id_deposito_origen": $("#cmbDepOrigen").val(),
        "fecha": $("#txtFechaTraspaso").val(),
        "observacion": $("#txtObserTraspaso").val(),
        "id": $("#txtId").val()
    };
    if (validarCampos()) {
        alert("Complete los campos correspondientes");
    } else if ($("#cmbDepOrigen").val() == $("#cmbDepDestino").val()) {
        alert("No puede ser seleccionado el mismo deposito");
    } else {
        $.ajax({
            async: false,
            cache: false,
            url: "TraspasoControl",
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
        $("#tblTraspasos").DataTable().destroy();
        cargarDatos(1, "cuerpoTraspasos");
    }
}

function limpiarCampos() {
    $("[name='camposForm']").val("");
}

function validarCampos() {
    if ($("#cmbDepOrigen").val() == "")
        return true;
    if ($("#cmbDepDestino").val() == "")
        return true;
    return false;
}

function abrirFormulario(opcion, id) {
    //alert(id);
    cargarDatos(4, "", id);
    switch (opcion) {
        case "modificar":
            $("#modalFormTittle").text("Modificar Registro / Traspaso");
            $("#btnModificar").show();
            $("[name='camposForm']").prop("disabled", false);
            $("#btnInsertar").hide();
            $("#btnBorrar").hide();
            break;
        case "eliminar":
            $("#modalFormTittle").text("Eliminar Registro / Traspaso");
            $("#btnBorrar").show();
            $("[name='camposForm']").prop("disabled", true);
            $("#btnModificar").hide();
            $("#btnInsertar").hide();
            break;
        case "insertar":
            $("#modalFormTittle").text("Agregar un Nuevo Registro / Traspaso");
            $("#btnInsertar").show();
            $("[name='camposForm']").prop("disabled", false);
            $("#btnBorrar").hide();
            $("#btnModificar").hide();
            break;
    }
}

// *************** FUNCIONES PARA EL DETALLE *********************

function abrirDetalle(id, id_deposito) {
    $("#txtIdTraspaso").val(id);
    $("#txtIdDepositoOrigen").val(id_deposito);
    cargarDatos(5, "articulos", id, id_deposito);
    cargarDatos(6, "cuerpoArticuloTraspasos", id);
}

function accionProcesoDetalleTraspaso(opcion, id) {
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
        "id_traspaso": $("#txtIdTraspaso").val(),
        "cantidad_traspaso": $("#cantidadArticulo").val(),
        "id_stock": id_stock,
        "id": id
    };
    $.ajax({
        async: false,
        cache: false,
        url: "TraspasoDetalleControl",
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
    cargarDatos(6, "cuerpoArticuloTraspasos", $("#txtIdTraspaso").val());
    cargarDatos(5, "articulos", $("#txtIdTraspaso").val(), $("#txtIdDepositoOrigen").val());
    limpiarCampoDetalle();
    $("#txtArticulo").focus();
}

function limpiarCampoDetalle() {
    $("[name='camposFormDetalle']").val("");
}

function finiquitar(opcion, id) {
    datosJson = {
        "opcion": opcion,
        "id": id
    };
    $.ajax({
        async: false,
        cache: false,
        url: "TraspasoAprobacionControl",
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
    $("#btnCancelTraspaso").trigger("click");
    $("#tblTraspasos").DataTable().destroy();
    cargarDatos(1, "cuerpoTraspasos");
}

function finiquitarTraspasoImprimir() {
    finiquitar(1, $("#txtIdTraspaso").val());
}

function imprimir(id) {
    window.open("ReporteTraspaso.jsp?id_traspaso=" + id, "_blank");
}