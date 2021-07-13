/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    cargarDatos(1, "cuerpoParametroSistemas");
    $("#btnModificar").hide();
    $("#btnBorrar").hide();
});

function cargarDatos(opcion, objeto, id) {
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'ParametroSistemaDatos.jsp',
        type: 'POST',
        data: {
            opcion: opcion,
            id: id
        },
        dataType: 'html',
        success: function (datos) {
            if (opcion == 2) {
                var valor = [];
                valor = $.trim(datos).split(",");
                $("#txtId").val(valor[1]);
                $("#txtDiasGarantia").val(valor[0]);
                $("#txtInteresMorVentas").val(valor[2]);
                $("#txtTimbraVM").val(valor[3]);
            } else {
                $("#" + objeto).html($.trim(datos));
                $("#cargando").hide();
            }
        },
        error: function () {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    $('#tblParametroSistemas').DataTable();
    $('.dataTables_length').addClass('bs-select');
}

function accionProceso(opcion) {
    datosJson = {
        "opcion": opcion,
        "id": $("#txtId").val(),
        "garantia_venta": $("#txtDiasGarantia").val(),
        "interes_moratorio_venta": $("#txtInteresMorVentas").val(),
        "timbrado_venta_manual": $("#txtTimbraVM").val()
    };
        $.ajax({
            async: false,
            cache: false,
            url: "ParametroSistemaControl",
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
        $("#tblParametroSistemas").DataTable().destroy();
        cargarDatos(1, "cuerpoParametroSistemas");
}

function limpiarCampos() {
    $("#txtDescripcion").val("");
    $("#txtNroParametroSistema").val("");
}

function validarCampos() {
    if ($("#txtDiasGarantia").val() == "")
        return true;
}

function abrirFormulario(opcion, id) {
    cargarDatos(2, "txtDescripcion", id);
    switch (opcion) {
        case "modificar":
            $("#modalFormTittle").text("Modificar Registro / Parametro Sistema");
            $("#btnModificar").show();
            $("#txtDescripcion").prop("disabled", false);
            $("#btnInsertar").hide();
            $("#btnBorrar").hide();
            break;
        case "eliminar":
            $("#modalFormTittle").text("Eliminar Registro / Parametro Sistema");
            $("#btnBorrar").show();
            $("#txtDescripcion").prop("disabled", true);
            $("#btnModificar").hide();
            $("#btnInsertar").hide();
            break;
        case "insertar":
            $("#modalFormTittle").text("Agregar un Nuevo Registro / Parametro Sistema");
            $("#btnInsertar").show();
            $("#txtDescripcion").prop("disabled", false);
            $("#btnBorrar").hide();
            $("#btnModificar").hide();
            break;
    }
}