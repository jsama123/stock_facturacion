/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function() {
    cargarDatos(1, "cuerpoArticulos");
    cargarDatos(2, "cmbMarca", 0);
    cargarDatos(3, "cmbGrupo", 0);
    cargarDatos(4, "cmbMedida", 0);
    cargarDatos(6, "cmbImpuesto", 0);

    $("#txtFecha").datepicker();
    $("#btnModificar").hide();
    $("#btnBorrar").hide();
});

function cargarDatos(opcion, objeto, id) {
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'ArticuloDatos.jsp',
        type: 'POST',
        data: {
            opcion: opcion,
            id: id
        },
        dataType: 'html',
        success: function(datos) {
            if (opcion == 5) {
                var valor = [];
                valor = $.trim(datos).split(",");
                $("#txtId").val(id);
                $("#cmbMarca").val(valor[0]);
                $("#cmbMedida").val(valor[1]);
                $("#cmbGrupo").val(valor[2]);
                $("#txtCodigoBarra").val(valor[3]);
                $("#txtDescripcion").val(valor[4]);
                $("#txtFecha").val(valor[5]);
                $("#cmbImpuesto").val(valor[7]);
            } else {
                $("#" + objeto).html($.trim(datos));
                $("#cargando").hide();
            }
        },
        error: function() {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    $('#tblArticulos').DataTable();
    $('.dataTables_length').addClass('bs-select');
}

function abrirDetalleCostos(descripcion, id) {
    $("#spDescriArt").text($.trim(descripcion));
    limpiarCampoDetalle();
    $("#idArt").val(id);
    cargarDatos(7, "cuerpoArticuloCosto", id);
}

function accionProceso(opcion) {
    datosJson = {
        "opcion": opcion,
        "id_impuesto": $("#cmbImpuesto").val(),
        "id_marca": $("#cmbMarca").val(),
        "id_medida": $("#cmbMedida").val(),
        "id_grupo": $("#cmbGrupo").val(),
        "articulo_descripcion": $("#txtDescripcion").val(),
        "codigo_barra": $("#txtCodigoBarra").val(),
        "minimo": $("#txtMinimo").val(),
        "fecha_vencimiento": $("#txtFecha").val(),
        "id": $("#txtId").val()
    };
    if (validarCampos()) {
        alert("Complete los campos correspondientes");
    } else {
        $.ajax({
            async: false,
            cache: false,
            url: "ArticuloControl",
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
        $("#tblArticulos").DataTable().destroy();
        cargarDatos(1, "cuerpoArticulos");
    }
}

function accionProcesoDetalleArticulo(opcion, id) {
    datosJson = {
        "opcion": opcion,
        "costo_compra": $("#costoCompra").val(),
        "costo_venta": $("#costoVenta").val(),
        "id_articulo": $("#idArt").val(),
        "id": id
    };
    $.ajax({
        async: false,
        cache: false,
        url: "ArticuloCostoControl",
        type: 'POST',
        data: datosJson,
        dataType: 'html',
        success: function(data, textStatus, jqXHR) {
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
        error: function(jqXHR, textStatus, errorThrown) {

        }
    });
    cargarDatos(7, "cuerpoArticuloCosto", $("#idArt").val());
    limpiarCampoDetalle();
}

function rellenarCamposCostos(costoCom, id, costoVent){
    $("#costoCompra").val(costoCom);
    $("#costoVenta").val(costoVent);
    $("#idArtCosto").val(id);
    $("#btnModArt").show();
    $("#btnInsertArt").hide();
}

function limpiarCampoDetalle() {
    $("[name='camposFormDetalle']").val("");
    $("#btnModArt").hide();
    $("#btnInsertArt").show();
}

function limpiarCampos() {
    $("[name='camposForm']").val("");
}

function validarCampos() {
    if ($("#txtDescripcion").val() == "")
        return true;
    return false;
}

function abrirFormulario(opcion, id) {
    //alert(id);
    cargarDatos(5, "", id);
    switch (opcion) {
        case "modificar":
            $("#modalFormTittle").text("Modificar Registro / Articulo");
            $("#btnModificar").show();
            $("[name='camposForm']").prop("disabled", false);
            $("[name='cmb']").prop("disabled", false);
            $("#btnInsertar").hide();
            $("#btnBorrar").hide();
            break;
        case "eliminar":
            $("#modalFormTittle").text("Eliminar Registro / Articulo");
            $("#btnBorrar").show();
            $("[name='camposForm']").prop("disabled", true);
            $("[name='cmb']").prop("disabled", true);
            $("#btnModificar").hide();
            $("#btnInsertar").hide();
            break;
        case "insertar":
            $("#modalFormTittle").text("Agregar un Nuevo Registro / Articulo");
            $("#btnInsertar").show();
            $("[name='camposForm']").prop("disabled", false);
            $("[name='cmb']").prop("disabled", false);
            $("#btnBorrar").hide();
            $("#btnModificar").hide();
            break;
    }
}

function completar(id, descripcion) {
    alert(id);
    $("#spArt").text($.trim(descripcion));
    $("#txtIdArt").val(id);
}