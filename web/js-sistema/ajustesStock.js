/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function() {
    cargarDatos(1, "cuerpoAjustesStocks");
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
        url: 'AjustesStockDatos.jsp',
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
                $("#cmbDepoAjus").val(valor[5]);
                $("#txtArtAjustes").val(valor[6]);
                $("#txtCantidadAjuste").val(valor[4]);
                $("#cmbOperacion").val(valor[3]);
                $("#txtObsAjustes").val(valor[2]);
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
    $('#tblAjustesStocks').DataTable();
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
        "existencia": existencia,
        "observacion": $("#txtObsAjustes").val(),
        "operacion": $("#cmbOperacion").val(),
        "cantidad": $("#txtCantidadAjuste").val(),
        "id": $("#txtId").val()
    };
    if (validarCampos()) {
        alert("Complete los campos correspondientes");
    } else if ($("#cmbOperacion").val() == 'R' && parseInt(existencia) < parseInt($("#txtCantidadAjuste").val())) {
        alert("La cantidad a restar no puede ser menor a la existencia !");
    } else {
        $.ajax({
            async: false,
            cache: false,
            url: "AjustesStockControl",
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
        $("#tblAjustesStocks").DataTable().destroy();
        cargarDatos(1, "cuerpoAjustesStocks");
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
    return false;
}

function abrirFormulario(opcion, id) {
    //alert(id);
    cargarDatos(4, "", id);
    switch (opcion) {
        case "modificar":
            $("#modalFormTittle").text("Modificar Registro / AjustesStock");
            $("#btnModificar").show();
            $("[name='camposForm']").prop("disabled", false);
            $("#btnInsertar").hide();
            $("#btnBorrar").hide();
            break;
        case "eliminar":
            $("#modalFormTittle").text("Eliminar Registro / AjustesStock");
            $("#btnBorrar").show();
            $("[name='camposForm']").prop("disabled", true);
            $("#btnModificar").hide();
            $("#btnInsertar").hide();
            break;
        case "insertar":
            $("#modalFormTittle").text("Agregar un Nuevo Registro / AjustesStock");
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
        url: "AjustesStockControl",
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
    $("#tblAjustesStocks").DataTable().destroy();
    cargarDatos(1, "cuerpoAjustesStocks");
}