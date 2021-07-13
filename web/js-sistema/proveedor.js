/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    cargarDatos(1, "cuerpoProveedors");
    $("#btnModificar").hide();
    $("#btnBorrar").hide();
});

function cargarDatos(opcion, objeto, id) {
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'ProveedorDatos.jsp',
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
                $("#txtCiRuc").val(valor[1]);
                $("#txtRazonSocial").val(valor[2]);
                $("#txtTelefono").val(valor[3]);
                $("#txtDireccion").val(valor[4]);
                $("#txtEmail").val(valor[5]);
            } else {
                $("#" + objeto).html($.trim(datos));
                $("#cargando").hide();
            }
        },
        error: function () {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    $('#tblProveedors').DataTable();
    $('.dataTables_length').addClass('bs-select');
}

function accionProceso(opcion) {
    datosJson = {
        "opcion": opcion,
        "ci_ruc_proveedor": $("#txtCiRuc").val(),
        "razon_social_proveedor": $("#txtRazonSocial").val(),
        "nro_telefono_proveedor": $("#txtTelefono").val(),
        "direccion_proveedor": $("#txtDireccion").val(),
        "email_proveedor": $("#txtEmail").val(),
        "id": $("#txtId").val()
    };
    if (validarCampos()) {
        alert("Complete los campos correspondientes");
    } else {
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
        $("#btnCancelar").trigger("click");
        $("#tblProveedors").DataTable().destroy();
        cargarDatos(1, "cuerpoProveedors");
    }
}

function limpiarCampos() {
    $("[name='camposForm']").val("");
}

function validarCampos() {
    if ($("#txtCiRuc").val() == "")
        return true;
    if ($("#txtRazonSocial").val() == "")
        return true;
    return false;
}

function abrirFormulario(opcion, id) {
    //alert(id);
    cargarDatos(2,"", id);
    switch (opcion) {
        case "modificar":
            $("#modalFormTittle").text("Modificar Registro / Proveedor");
            $("#btnModificar").show();
            $("[name='camposForm']").prop("disabled", false);
            $("#btnInsertar").hide();
            $("#btnBorrar").hide();
            break;
        case "eliminar":
            $("#modalFormTittle").text("Eliminar Registro / Proveedor");
            $("#btnBorrar").show();
            $("[name='camposForm']").prop("disabled", true);
            $("#btnModificar").hide();
            $("#btnInsertar").hide();
            break;
        case "insertar":
            $("#modalFormTittle").text("Agregar un Nuevo Registro / Proveedor");
            $("#btnInsertar").show();
            $("[name='camposForm']").prop("disabled", false);
            $("#btnBorrar").hide();
            $("#btnModificar").hide();
            break;
    }
}