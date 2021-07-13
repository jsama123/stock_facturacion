/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    cargarDatos(1, "cuerpoAjusteMTC");
    $("#btnModificar").hide();
    $("#btnBorrar").hide();
});

function cargarDatos(opcion, objeto, id) {
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'AjusteMontoTotalCompraDatos.jsp',
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
                $("#txtId").val(valor[0]);
                $("#txtMontoTotalC").val(valor[1]);
                //$("#txtInteresMensual").val(valor[2]);
            } else {
                $("#" + objeto).html($.trim(datos));
                $("#cargando").hide();
            }
        },
        error: function () {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    $('#tblAjusteMTC').DataTable();
    $('.dataTables_length').addClass('bs-select');
}

function accionProceso(opcion) {
    datosJson = {
        "opcion": opcion,
        "id": $("#txtId").val(),
        "monto_total_compra": $("#txtMontoTotalC").val(),
        //"interes_mensual": $("#txtInteresMensual").val()
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
        $("#tblAjusteMTC").DataTable().destroy();
        cargarDatos(1, "cuerpoAjusteMTC");
    }
}

function limpiarCampos() {
    $("#txtDescripcion").val("");
    $("#txtNroAjusteMontoTotalCompra").val("");
}

function validarCampos() {
    if ($("#txtMontoTotalC").val() == "")
        return true;
}

function abrirFormulario(opcion, id) {
    cargarDatos(2, "txtDescripcion", id);
    switch (opcion) {
        case "modificar":
            $("#modalFormTittle").text("Modificar Registro / Ajuste Monto Total de Compra");
            $("#btnModificar").show();
            $("#txtDescripcion").prop("disabled", false);
            $("#btnInsertar").hide();
            $("#btnBorrar").hide();
            break;
        case "eliminar":
            $("#modalFormTittle").text("Eliminar Registro / Ajuste Monto Total de Compra");
            $("#btnBorrar").show();
            $("#txtDescripcion").prop("disabled", true);
            $("#btnModificar").hide();
            $("#btnInsertar").hide();
            break;
        case "insertar":
            $("#modalFormTittle").text("Agregar un Nuevo Registro / Ajuste Monto Total de Compra");
            $("#btnInsertar").show();
            $("#txtDescripcion").prop("disabled", false);
            $("#btnBorrar").hide();
            $("#btnModificar").hide();
            break;
    }
}