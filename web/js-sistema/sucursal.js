/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    cargarDatos(1, "cuerpoSucursals");
    $("#btnModificar").hide();
    $("#btnBorrar").hide();
});

function cargarDatos(opcion, objeto, id) {
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'SucursalDatos.jsp',
        type: 'POST',
        data: {
            opcion: opcion,
            id: id
        },
        dataType: 'html',
        success: function (datos) {
            if (opcion == 2) {
                var valor = [];
                valor = $.trim(datos).split("-");
                $("#txtId").val(valor[0]);
                $("#txtDescripcion").val(valor[1]);
                $("#txtDireccion").val(valor[2]);
                $("#txtTelefono").val(valor[3]);
                $("#txtNroSucursal").val(valor[4]);
            } else {
                $("#" + objeto).html($.trim(datos));
                $("#cargando").hide();
            }
        },
        error: function () {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    $('#tblSucursals').DataTable();
    $('.dataTables_length').addClass('bs-select');
}

function accionProceso(opcion) {
    datosJson = {
        "opcion": opcion,
        "nro_telefono_sucursal": $("#txtTelefono").val(),
        "direccion_sucursal": $("#txtDireccion").val(),
        "descripcion_sucursal": $("#txtDescripcion").val(),
        "nro_sucursal": $("#txtNroSucursal").val(),
        "id": $("#txtId").val()
    };
    if (validarCampos()) {
        alert("Complete los campos correspondientes");
    }else{
        $.ajax({
            async: false,
            cache: false,
            url: "SucursalControl",
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
        $("#tblSucursals").DataTable().destroy();
        cargarDatos(1, "cuerpoSucursals");
    }
}

function limpiarCampos() {
    $("[name='camposForm']").val("");
}

function validarCampos() {
    if ($("#txtDescripcion").val() == "")
        return true;
    if ($("#txtNroSucursal").val() == "")
        return true;
}

function abrirFormulario(opcion, id) {
    //alert(id);
    cargarDatos(2,"", id);
    switch (opcion) {
        case "modificar":
            $("#modalFormTittle").text("Modificar Registro / Sucursal");
            $("#btnModificar").show();
            $("[name='camposForm']").prop("disabled", false);
            $("#btnInsertar").hide();
            $("#btnBorrar").hide();
            break;
        case "eliminar":
            $("#modalFormTittle").text("Eliminar Registro / Sucursal");
            $("#btnBorrar").show();
            $("[name='camposForm']").prop("disabled", true);
            $("#btnModificar").hide();
            $("#btnInsertar").hide();
            break;
        case "insertar":
            $("#modalFormTittle").text("Agregar un Nuevo Registro / Sucursal");
            $("#btnInsertar").show();
            $("[name='camposForm']").prop("disabled", false);
            $("#btnBorrar").hide();
            $("#btnModificar").hide();
            break;
    }
}