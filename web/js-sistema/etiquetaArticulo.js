/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    cargarDatos(1, "cuerpoArticulos");
    $("#chkSeleccionArticulos").change(function () {
        if ($("#chkSeleccionArticulos").is(":checked")) {
            $('[name="chkArticulos"]').prop("checked", true);
        } else {
            $('[name="chkArticulos"]').prop("checked", false);
        }
        $("#txtMarcadosArticulos").val($('[name="chkArticulos"]:checked:visible').length);
    });
});

function verificarEstadoCheck() {
    if ($('[name="chkArticulos"]').prop('checked')) {
        imprimirCodBarra();
    } else {
        alert("Por favor marque por lo menos un registro !!");
    }
}

function soloNumeros(exis, id)
{
    var entrada = $("#" + id).val();
    if ($.isNumeric(entrada)) {
        if (!(parseInt(entrada) > 0 && parseInt(entrada) <= parseInt(exis))) {
            alert("La cantidad debe ser entre 1 a " + exis);
            $("#" + id).focus();
            $("#" + id).val(exis);
            $("#" + id).select();
        }
    } else {
        alert("La cantidad debe ser entre 1 a " + exis);
        $("#" + id).focus();
        $("#" + id).val(exis);
        $("#" + id).select();
    }
}

function imprimirCodBarra()
{
    window.location.href = "ReporteCodigoBarraArticulo.jsp?ids_art_cant=" + obtenerValorAsignado("Articulos");
}

function obtenerValorAsignado(solapa) {
    var idsCantidades = "";
    $("#tbl" + solapa + ">tbody>tr:visible").each(function () {
        if ($(this).find("input").is(":checked")) {
            idsCantidades += $(this).find("td").eq(2).html() + ";" + $(this).find("td").eq(4).find("input").val() + ",";
        }
    });
    return idsCantidades.substring(0, idsCantidades.lastIndexOf(','));

}

function cargarDatos(opcion, objeto, id) {
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'EtiquetaArticuloDatos.jsp',
        type: 'POST',
        data: {
            opcion: opcion,
            id: id
        },
        dataType: 'html',
        success: function (datos) {
            $("#" + objeto).html($.trim(datos));
            $("#cargando").hide();
        },
        error: function () {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    $('#tblArticulos').DataTable();
    $('.dataTables_length').addClass('bs-select');
}