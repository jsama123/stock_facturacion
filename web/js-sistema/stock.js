/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function () {
    cargarDatos(1, "cmbDeposito");
    cargarDatos($("#cmbArticulos").val(), "cuerpoArticulos");
    $('#tblArticulos').DataTable();
    $('.dataTables_length').addClass('bs-select');
    $("[name='numeros']").on({
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
    $('#cmbDeposito').on('change', function () {
        $('#tblArticulos').DataTable().destroy();
        cargarDatos($("#cmbArticulos").val(), "cuerpoArticulos");
    });
    $('#cmbArticulos').on('change', function () {
        $('#tblArticulos').DataTable().destroy();
        cargarDatos($(this).val(), "cuerpoArticulos");
        if ($(this).val() == "2") {
            $("#btnInsert").hide();
            $("#btnUpdate").show();
            $("#btnDelete").show();
        } else {
            $("#btnUpdate").hide();
            $("#btnDelete").hide();
            $("#btnInsert").show();
        }
    });

    if ($("#cmbArticulos").val() == "2") {
        $("#btnUpdate").show();
        $("#btnDelete").show();
    } else {
        $("#btnInsert").hide();
    }
});

function checkear(solapa) {
    $("#chkSeleccion" + solapa).on("click", function () {
        $("[name='chk" + solapa + "']").prop("checked", this.checked);
    });
    $("[name='chk" + solapa + "']").on("click", function () {
        if ($("[name='chk" + solapa + "']").length == $("[name='chk" + solapa + ":checked']").length) {
            $("#chkSeleccion" + solapa).prop("checked", true);
        } else {
            $("#chkSeleccion" + solapa).prop("checked", false);
        }
    });
}

function cargarDatos(opcion, objeto, id) {
    $("#cargando").show();
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'StockDatos.jsp',
        type: 'POST',
        data: {
            opcion: opcion,
            id: id,
            id_deposito: $("#cmbDeposito").val()
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

function buscar(solapa) {
    $("#filtro" + solapa).keyup(function () {
        _this = this;
        $.each($("#tbl" + solapa + " tbody tr"), function () {
            if ($(this).text().toLowerCase().indexOf($(_this).val().toLowerCase()) === -1)
                $(this).hide();
            else
                $(this).show();
        });
        contarCheck(solapa);
    });
}

function obtenerValorAsignado() {
    var idsArticulos = "";
    if ($("#cmbArticulos").val() == "2") {
        $("#tblArticulos>tbody>tr:visible").each(function () {
            if ($(this).find("input").is(":checked")) {
                idsArticulos += $(this).find("td").eq(1).html() + ";" + //id 
                        $(this).find("td").eq(3).find("input").val() + ";" + //minimo
                        $(this).find("td").eq(4).find("input").val() + ","; //maximo
            }
        });
    } else {
        $("#tblArticulos>tbody>tr:visible").each(function () {
            if ($(this).find("input").is(":checked")) {
                var campos, id_articulo, id_arti_costo;
                campos = $.trim($(this).find("td").eq(0).find("input").val()).split("-");
                id_articulo = campos[0];
                id_arti_costo = campos[1]
                idsArticulos += id_articulo + ";" + //id_articulo
                        id_arti_costo + ";" + //id_articulo_costo
                        $(this).find("td").eq(3).find("input").val() + ";" + //minimo
                        $(this).find("td").eq(4).find("input").val() + ","; //maximo
            }
        });
    }
    return idsArticulos.substring(0, idsArticulos.lastIndexOf(','));
}

function procesarAccion(proceso) {
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: "StockControl",
        type: "POST",
        data: {
            ids_concatenados: obtenerValorAsignado(),
            opcion: proceso,
            id_deposito: $("#cmbDeposito").val()
        },
        dataType: "html"
    });
    resultado.done(function (datos) {
        if ($.trim(datos) == "bien") {
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
    });
    resultado.fail(function (jqXHR, textStatus) {
        alert("RESPUESTA DEL SERVIDOR: " + textStatus);
    });
    $("#tblArticulos").DataTable().destroy();
    cargarDatos($("#cmbArticulos").val(), "cuerpoArticulos");
}