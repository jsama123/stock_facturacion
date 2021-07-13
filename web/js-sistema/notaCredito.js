/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
    cargarDatos(1, "cuerpoNotaCredito");
    cargarDatos(2, "clientesNota");
    $("#btnModificar").hide();
    $("#btnBorrar").hide();

    $("#txtVenta").change(function () {
        var camposNotaVentas, valores = [];
        var id_venta;
        var montoTotalNota = 0;
        camposNotaVentas = $.trim($(this).val()).split("|");
        valores = $.trim(camposNotaVentas[0]).split(":");
        id_venta = $.trim(valores[1]);

        cargarDatos(5, "cuerpoImtesVentas", id_venta);

        $("#tblItemsVentas>tbody>tr:visible").each(function () {
            if ($(this).find("td").eq(0).find("input").is(":checked")) {
                montoTotalNota += parseFloat($(this).find("td").eq(4).text());
            }
        });
        $("#txtMontoTotalCredito").val(montoTotalNota);
    });
});

function cargarDatos(opcion, objeto, id) {
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'NotaCreditoDatos.jsp',
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
                $("#txtIdNota").val(valor[0]);
                $("#cmbConceptoNC").val(valor[2]);
                $("#txtClienteNota").val(valor[1]);
            } else {
                $("#" + objeto).html($.trim(datos));
                $("#cargando").hide();
            }
        },
        error: function () {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    if (opcion == 5) {
        if ($("#txtConceptoNota").val() == 'ANULACION DE VENTA') {
            $("input[name='inputArtNota']").prop('disabled', true);
            $("input[name='chkArticulosNota']").prop('disabled', true);
            $("input[name='chkArticulosNota']").prop('checked', true);

        }
    }
    $('#tblNotaCredito').DataTable();
    $('.dataTables_length').addClass('bs-select');
}

function obtenerUltimoNroNC() {
    var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'NotaCreditoDatos.jsp',
        type: 'POST',
        data: {
            opcion: 7
        },
        dataType: 'html',
        success: function (datos) {
            retorno = $.trim(datos);
        },
        error: function () {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    return retorno;
}

function obtenerIdVentaAnular(id_nota) {
    var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'NotaCreditoDatos.jsp',
        type: 'POST',
        data: {
            opcion: 8,
            id: id_nota
        },
        dataType: 'html',
        success: function (datos) {
            retorno = $.trim(datos);
        },
        error: function () {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
        }
    });
    return retorno;
}

function accionProceso(opcion, conceptoNota) {
    //alert(conceptoNota);
    var id;
    if (opcion == 4) {
        id = $("#txtIdNotaCabecera").val();
    } else {
        id = $("#txtIdNota").val();
    }
    var campos;
    campos = $.trim($("#txtClienteNota").val()).split("/");
    var id_cliente = campos[0];
    datosJson = {
        "opcion": opcion,
        "concepto_nota_credito": $("#cmbConceptoNC").val(),
        "id_cliente": id_cliente,
        "observacion_nota_credito": $("#txtObservacionNC").val(),
        "accion_nota_credito": $("#cmbAccionNC").val(),
        "numero_nota_credito": obtenerUltimoNroNC(),
        "id": id
    };
    $.ajax({
        async: false,
        cache: false,
        url: "NotaCreditoControl",
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
                if (opcion == 4 && $.trim(conceptoNota) =='ANULACION DE VENTA') {
                    anularVenta(parseInt(obtenerIdVentaAnular(id)));
                }
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
    if (opcion == 4) {
        $("#btnCancelNotaCreditoDetalle").trigger("click");
        $("#tblNotaCredito").DataTable().destroy();
        cargarDatos(1, "cuerpoNotaCredito");
    } else {
        $("#btnCancelarNota").trigger("click");
        $("#tblNotaCredito").DataTable().destroy();
        cargarDatos(1, "cuerpoNotaCredito");
    }
}

function anularVenta(id) {
    $.ajax({
        async: false,
        cache: false,
        url: "VentaControl",
        type: 'POST',
        data: {
            opcion: 7,
            id: id
        },
        dataType: 'html',
        success: function (data, textStatus, jqXHR) {
            if ($.trim(data) == "bien") {
                toastr.success("Venta Anulada", "Notificación", {
                    "progressBar": true,
                    "positionClass": "toast-top-center",
                    "timeOut": "2000"
                });
            } else {
                toastr.error("No se pudo anular la venta", "Notificación", {
                    "progressBar": true,
                    "positionClass": "toast-top-center",
                    "timeOut": "2000"
                });
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {

        }
    });
}

function limpiarDetalleNota() {
    $("#txtVenta").val("");
    $("#tblItemsVentas > tbody > tr").remove();
    $("#txtMontoTotalCredito").val("");
}

function validarCampos() {
    if ($("#txtSaldo").val() == "")
        return true;
    return false;
}

function abrirFormulario(opcion, id) {
    cargarDatos(3, "", id);
    switch (opcion) {
        case "modificar":
            $("#modalFormTittle").text("Modificar Registro / Nota de Credito");
            $("#btnModificar").show();
            $("[name='cmb']").prop("disabled", false);
            $("#txtSaldo").prop("disabled", false);
            $("#btnInsertar").hide();
            $("#btnBorrar").hide();
            break;
        case "eliminar":
            $("#modalFormTittle").text("Eliminar Registro / Nota de Credito");
            $("#btnBorrar").show();
            $("#txtSaldo").prop("disabled", true);
            $("[name='cmb']").prop("disabled", true);
            $("#btnModificar").hide();
            $("#btnInsertar").hide();
            break;
        case "insertar":
            $("#modalFormTittle").text("Agregar un Nuevo Registro / Nota de Credito");
            $("#btnInsertar").show();
            $("#txtSaldo").prop("disabled", false);
            $("[name='cmb']").prop("disabled", false);
            $("#btnBorrar").hide();
            $("#btnModificar").hide();
            break;
    }
}

// A PARTIR DE ACA CORRESPONDE AL DETALLE

function abrirDetalleNota(id, concepto) {
    $("#txtIdNotaCabecera").val(id);
    limpiarDetalleNota();
    if ($.trim(concepto) !== 'ANULACION DE VENTA') {
        $("#rowMontoTotalNota").hide();
    } else {
        $("#rowMontoTotalNota").show();
    }
    $("#txtConceptoNota").val($.trim(concepto));
    cargarDatos(6, "cuerpoDetalleNotaCreditoDetalle", id);
    mostrarTotalNotaCreditoDetalle();
    cargarDatos(4, "ventasList", id);
}

function mostrarTotalNotaCreditoDetalle(id) {
    $("#txtidNotaCreditoDetalle").val(id);
    var total = 0;
    $("#tblDetalleNotaCreditoDetalle tbody").find('tr').each(function (i) {
        total += parseFloat($(this).find('td').eq(3).text());
    });
    $("#thTotal").text(total);
}

function obtenerValorAsignadoNota() {
    var idsArticulos = "";
    $("#tblItemsVentas>tbody>tr:visible").each(function () {
        if ($(this).find("input").is(":checked")) {
            idsArticulos += $(this).find("td").eq(0).find("input").val() + ";" + //id 
                    $(this).find("td").eq(2).find("input").val() + ";" + //cantidad
                    $(this).find("td").eq(3).html() + ","; //precio
        }
    });
    return idsArticulos.substring(0, idsArticulos.lastIndexOf(','));
}

function idVentaRetorno(){
    var valoresInputVenta, valoresInput = [];
    var id_venta;
    valoresInputVenta = $.trim($("#txtVenta").val()).split("|");
    valoresInput = $.trim(valoresInputVenta[0]).split(":");
    id_venta = $.trim(valoresInput[1]);
    return id_venta;
}

function validarFechaGarantiaVentas(){
    var fecha_venta, retorno, diasParametro;
    var valoresInput, valoresInput1 = [];
    valoresInput = $.trim($("#txtVenta").val()).split("|");
    valoresInput1 = $.trim(valoresInput[3]).split(":");
    fecha_venta = $.trim(valoresInput1[1]);
    
   var fecha_nota = obtenerFechaGarantia($("#txtIdNotaCabecera").val());
   //alert(fecha_venta+"-"+fecha_nota);
   var fechaNotaArray = fecha_nota.split("/");
   var fechaVentaArray = fecha_venta.split("/");
   var fecha1 = Date.UTC(fechaNotaArray[2], fechaNotaArray[1]-1, fechaNotaArray[0]);
   var fecha2 = Date.UTC(fechaVentaArray[2], fechaVentaArray[1]-1, fechaVentaArray[0]);
   var dif= fecha1 - fecha2;
   var dias = Math.floor(dif / (1000*60*60*24));
   
   diasParametro = obtenerDiasParametro();
   
   if(parseInt(dias)>parseInt(diasParametro)){
       retorno = "s";
   }else{
       retorno = "n";
   }
    return retorno;
}

function obtenerFechaGarantia(id){
     var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'NotaCreditoDatos.jsp',
        type: 'POST',
        data: {
            opcion: 9,
            id: id
        },
        dataType: 'html',
        success: function (datos) {
            retorno = $.trim(datos);
        },
        error: function () {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
         }
    });
    return retorno;
}

function obtenerDiasParametro()  {
     var retorno;
    var resultado = $.ajax({
        async: false,
        cache: false,
        url: 'NotaCreditoDatos.jsp',
        type: 'POST',
        data: {
            opcion: 10
        },
        dataType: 'html',
        success: function (datos) {
            retorno = $.trim(datos);
        },
        error: function () {
            alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
         }
    });
    return retorno;
}

function accionProcesoDetalleNota(opcion, id) {
    var valoresInputVenta, valoresInput = [];
    var id_venta;
    valoresInputVenta = $.trim($("#txtVenta").val()).split("|");
    valoresInput = $.trim(valoresInputVenta[0]).split(":");
    id_venta = $.trim(valoresInput[1]);
    datosJson = {
        "opcion": opcion,
        "ids_concatenados": obtenerValorAsignadoNota(),
        "id_venta": id_venta,
        "id_nota_credito": $("#txtIdNotaCabecera").val(),
        "id": id
    };
    $.ajax({
        async: false,
        cache: false,
        url: "NotaCreditoDetalleControl",
        type: 'POST',
        data: datosJson,
        dataType: 'html',
        success: function (data, textStatus, jqXHR) {
            if ($.trim(data) == "bien") {
                $("#sucess").show("slow");
                setTimeout(function () {
                    $("#sucess").fadeOut(1500);
                }, 3000);
            } else {
                $("#error").show("slow");
                setTimeout(function () {
                    $("#sucess").fadeOut(1500);
                }, 3000);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {

        }
    });
    limpiarDetalleNota();
    cargarDatos(6, "cuerpoDetalleNotaCreditoDetalle", $("#txtIdNotaCabecera").val());
    mostrarTotalNotaCreditoDetalle($("#txtidNotaCreditoDetalle").val());
}

function imprimir(id) {
    window.open("ReporteNotaCredito.jsp?id_arqueo=" + id, "_blank");
}