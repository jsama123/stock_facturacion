/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    cargarDatos(1, "cuerpoDepositos");
    cargarDatos(3, "cmbSucursal");
    $("#btnModificar").hide();
    $("#btnBorrar").hide();
});

function cargarDatos(opcion, objeto, id) {
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'DepositoDatos.jsp',
        type: 'POST',
        data: {
            opcion: opcion,
            id : id
        },
        dataType: 'html',
        success: function (datos) {
            if (opcion == 2) {
                var valor = [];
                valor = $.trim(datos).split(",");
                $("#"+ objeto).val(valor[0]);
                $("#txtId").val(valor[1]);
                $("#cmbSucursal").val(valor[2]);
                if(valor[3]=='v'){
                    $("#chkDepComer").prop("checked", true);
                }else{
                    $("#chkDepComer").prop("checked", false);
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
    $('#tblDepositos').DataTable();
    $('.dataTables_length').addClass('bs-select');
}

function accionProceso(opcion) {
    datosJson = {
        "opcion": opcion,
        "descripcion": $("#txtDescripcion").val(),
        "id_sucursal": $("#cmbSucursal").val(),
        "deposito_comercial": $("#chkDepComer").is(":checked") ? true : false,
        "id" : $("#txtId").val()
    };
    if (validarCampos()) {
        alert("Complete los campos correspondientes");
    } else {
        $.ajax({
            async: false,
            cache: false,
            url: "DepositoControl",
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
        $("#tblDepositos").DataTable().destroy();
        cargarDatos(1, "cuerpoDepositos");
    }
}

function limpiarCampos() {
    $("#txtDescripcion").val("");
}

function validarCampos() {
    if ($("#txtDescripcion").val() == "")
        return true;
    return false;
}

function abrirFormulario(opcion, id) {
    cargarDatos(2, "txtDescripcion", id);
    switch (opcion) {
        case "modificar":
            $("#modalFormTittle").text("Modificar Registro / Deposito");
            $("#btnModificar").show();
            $("#txtDescripcion").prop("disabled", false);
            $("#cmbSucursal").prop("disabled", false);
            $("#btnInsertar").hide();
            $("#btnBorrar").hide();
            break;
        case "eliminar":
            $("#modalFormTittle").text("Eliminar Registro / Deposito");
            $("#btnBorrar").show();
            $("#txtDescripcion").prop("disabled", true);
            $("#cmbSucursal").prop("disabled", true);
            $("#btnModificar").hide();
            $("#btnInsertar").hide();
            break;
        case "insertar":
            $("#modalFormTittle").text("Agregar un Nuevo Registro / Deposito");
            $("#btnInsertar").show();
            $("#txtDescripcion").prop("disabled", false);
            $("#cmbSucursal").prop("disabled", false);
            $("#btnBorrar").hide();
            $("#btnModificar").hide();
            break;
    }
}