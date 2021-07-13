/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function() {
    cargarDatos(1, "cuerpoMalogrados");
    cargarDatos(2, "cmbDepoAjus");
    cargarDatos(3, "articulosAjustes", 0, $("#cmbDepoAjus").val());
    $("#btnModificar").hide();
    $("#btnBorrar").hide();

    $('#cmbDepoAjus').on('change', function() {
        cargarDatos(3, "articulosAjustes", 0, $(this).val());
        $("#txtArtAjustes").val("");
    });
});

function cargarDatos(opcion, objeto, id, id_deposito) {
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'MalogradoDatos.jsp',
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
                $("#cmbDepoAjus").val(valor[4]);
                $("#txtArtAjustes").val(valor[5]);
                $("#txtObs").val(valor[2]);
                $("#txtMotivoMal").val(valor[1]);
                $("#txtCantidadMal").val(valor[3]);
                $("#txtId").val(id);
            } else {
                $("#" + objeto).html($.trim(datos));
                $("#cargando").hide();
            }
        },
        error: function() {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    $('#tblMalogrados').DataTable();
    $('.dataTables_length').addClass('bs-select');
}

function accionProceso(opcion) {
    var camposArticuloSelect, valores, valores2, valores3 = [];
    var id_stock, existencia;
    camposArticuloSelect = $.trim($("#txtArtAjustes").val()).split("|");
    valores = $.trim(camposArticuloSelect[0]).split(":");
    id_stock = $.trim(valores[1]);

    valores2 = $.trim(camposArticuloSelect[2]).split(":");
    existencia = $.trim(valores2[1]);
    datosJson = {
        "opcion": opcion,
        "id_stock": id_stock,
        "motivo": $("#txtMotivoMal").val(),
        "cantidad": $("#txtCantidadMal").val(),
        "operacion": $("#cmbOperacion").val(),
        "observacion": $("#txtObs").val(),
        "id": $("#txtId").val()
    };
    if (validarCampos()) {
        alert("Complete los campos correspondientes");
    } else {
        $.ajax({
            async: false,
            cache: false,
            url: "MalogradoControl",
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
        $("#tblMalogrados").DataTable().destroy();
        cargarDatos(1, "cuerpoMalogrados");
    }
}

function limpiarCampos() {
    $("[name='camposForm']").val("");
}

function validarCampos() {
    if ($("#txtCantidadAjuste").val() == "")
        return true;
    if ($("#txtArtAjustes").val() == "")
        return true;
    if ($("#txtMotivoMal").val() == "")
        return true;
    return false;
}

function abrirFormulario(opcion, id) {
    //alert(id);
    switch (opcion) {
        case "modificar":
            cargarDatos(4, "", id);
            $("#modalFormTittle").text("Modificar Registro / Malogrado");
            $("#btnModificar").show();
            $("[name='camposForm']").prop("disabled", false);
            $("#btnInsertar").hide();
            $("#btnBorrar").hide();
            break;
        case "eliminar":
            cargarDatos(4, "", id);
            $("#modalFormTittle").text("Eliminar Registro / Malogrado");
            $("#btnBorrar").show();
            $("[name='camposForm']").prop("disabled", true);
            $("#btnModificar").hide();
            $("#btnInsertar").hide();
            break;
        case "insertar":
            $("#modalFormTittle").text("Agregar un Nuevo Registro / Malogrado");
            $("#btnInsertar").show();
            $("[name='camposForm']").prop("disabled", false);
            $("#btnBorrar").hide();
            $("#btnModificar").hide();
            break;
    }
}

function aprobar(id) {
    $.ajax({
        async: false,
        cache: false,
        url: "MalogradoControl",
        type: 'POST',
        data: {
            opcion : 4,
            id : id
        },
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
    $("#tblMalogrados").DataTable().destroy();
    cargarDatos(1, "cuerpoMalogrados");
}