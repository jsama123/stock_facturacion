/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    cargarDatos(1, "cuerpoGastos");
    cargarDatos(2, "proveedoresGasto");
    $("#btnModificar").hide();
    $("#btnBorrar").hide();

    $("#txtMontoGasto").on({
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
    
    $("#txtFechaGasto").datepicker();
});

function cargarDatos(opcion, objeto, id) {
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'GastoDatos.jsp',
        type: 'POST',
        data: {
            opcion: opcion,
            id: id
        },
        dataType: 'html',
        success: function (datos) {
            if (opcion == 3) {
                var valor = [];
                valor = $.trim(datos).split(",");
                $("#txtProveedorGasto").val(valor[0]);
                $("#txtMontoGasto").val(valor[3]);
                $("#txtConcepGasto").val(valor[1]);
                $("#txtNroCompGasto").val(valor[2]);
                $("#txtFechaGasto").val(valor[4]);
                $("#txtTimbradoGastos").val(valor[5]);
                $("#cmbTipoGasto").val(valor[7]);
                $("#txtCuotaGastos").val(valor[6]);
                $("#txtId").val(id);
            } else {
                $("#" + objeto).html($.trim(datos));
                $("#cargando").hide();
            }
        },
        error: function () {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    $('#tblGastos').DataTable();
    $('.dataTables_length').addClass('bs-select');
}

function accionProceso(opcion) {
    var campos = [];
    var id_proveedor;
    campos = $.trim($("#txtProveedorGasto").val()).split("/");
    id_proveedor = campos[0];
    datosJson = {
        "opcion": opcion,
        "id_proveedor": id_proveedor,
        "concepto_gasto": $("#txtConcepGasto").val(),
        "nro_comprobante_gasto": $("#txtNroCompGasto").val(),
        "monto_gasto": $("#txtMontoGasto").val().replace(/[^a-z0-9\s]/gi, ''),
        "iva": $("#cmbIvaGasto").val(),
        "fecha_gasto": $("#txtFechaGasto").val(),
        "timbrado_gasto": $("#txtTimbradoGastos").val(),
        "tipo_gasto": $("#cmbTipoGasto").val(),
        "cantidad_cuota_gasto": $("#txtCuotaGastos").val(),
        "id": $("#txtId").val()
    };
    if (validarCampos()) {
        alert("Complete los campos correspondientes");
    } else {
        $.ajax({
            async: false,
            cache: false,
            url: "GastoControl",
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
        $("#tblGastos").DataTable().destroy();
        cargarDatos(1, "cuerpoGastos");
    }
}

function limpiarCampos() {
    $("[name='camposForm']").val("");
}

function validarCampos() {
    if ($("#txtMontoGasto").val() == "")
        return true;
    if ($("#txtNroCompGasto").val() == "")
        return true;
    if ($("#cmbIvaGasto").val() == "")
        return true;
    if ($("#txtConcepGasto").val() == "")
        return true;
    if ($("#txtTimbradoGastos").val() == "")
        return true;
    if ($("#cmbTipoGasto").val() == "" )
        return true;
    if ($("#txtCuotaGastos").val() == "" )
        return true;
    return false;
}

function abrirFormulario(opcion, id) {
    //alert(id);
    cargarDatos(3, "", id);
    switch (opcion) {
        case "modificar":
            $("#modalFormTittle").text("Modificar Registro / Gasto");
            $("#btnModificar").show();
            $("[name='camposForm']").prop("disabled", false);
            $("#btnInsertar").hide();
            $("#btnBorrar").hide();
            break;
        case "eliminar":
            $("#modalFormTittle").text("Eliminar Registro / Gasto");
            $("#btnBorrar").show();
            $("[name='camposForm']").prop("disabled", true);
            $("#btnModificar").hide();
            $("#btnInsertar").hide();
            break;
        case "insertar":
            $("#modalFormTittle").text("Agregar un Nuevo Registro / Gasto");
            $("#btnInsertar").show();
            $("[name='camposForm']").prop("disabled", false);
            $("#btnBorrar").hide();
            $("#btnModificar").hide();
            break;
    }
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