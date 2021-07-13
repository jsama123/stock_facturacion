<%-- 
    Document   : CambiarPass
    Created on : 8/07/2020, 12:00:33 AM
    Author     : Jose Samaniego
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="ChequearSesion.jsp" %>
        <style>
            body {
                padding-top: 50px;
                padding-left: 10px
            }
        </style>   
        <title>CambiarPass</title>
    </head>
    <body>
        <h4 class="text-center">Cambiar Contraseña</h4><hr>
        <div class="container text-center" style="width: 100%">
            <div class="form-group row">
                <label class="col-sm-3 col-form-label">Ingrese su contraseña actual :</label>
                <div class="col-sm-4">  
                    <input type="password" name="pass" class="form-control form-control-sm" id="txtPassActual">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-3 col-form-label">Ingrese la contraseña nueva :</label>
                <div class="col-sm-4">
                    <input type="password" name="pass" class="form-control form-control-sm" id="txtPassNew">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-3 col-form-label">Repita la contraseña nueva :</label>
                <div class="col-sm-4">
                    <input type="password" name="pass" class="form-control form-control-sm" id="txtPassNewRepeat">
                </div>
            </div>
            <div class="form-group form-check">
                <input type="checkbox" class="form-check-input" id="mostrar_contrasena">
                <label class="form-check-label" for="exampleCheck1">Mostrar Contraseñas</label>
            </div>
            <div class="form-group">
                <input type="button" name="btnCampos" class="btn btn-sm btn-primary" id="btnActualizar" onclick="cambiarPass()" value="Cambiar Contraseña"/>
                <input type="button" name="btnCampos"  id="btnLimpiar" class="btn btn-sm btn-primary" value="Limpiar"/>
            </div>
        </div><hr>
        <script src="js/jquery-3.4.1.min.js"></script>
        <script src="js/jquery.md5.js"></script>
        <script type="text/javascript">
                    $(document).ready(function () {
                        $('#mostrar_contrasena').click(function () {
                            if ($('#mostrar_contrasena').is(':checked')) {
                                $("[name='pass']").prop('type', 'text');
                            } else {
                                $("[name='pass']").prop('type', 'password');
                            }
                        });

                        $("#btnLimpiar").click(function () {
                            $("[name='pass']").val("");
                        });
                    });

                    function cambiarPass() {
                        if (validarPassActual() == "2") {
                            if ($("#txtPassNew").val() === $("#txtPassNewRepeat").val()) {
                                procesarAccion(1);
                            } else {
                                alert("Las contraseñas no coinciden !!");
                            }
                        } else {
                            alert("Su contraseña actual ingresada es incorrecta !!");
                        }
                    }

                    function procesarAccion(accion) {
                        var resultado = $.ajax({
                            async: false,
                            cache: false,
                            url: "UsuarioControl",
                            type: 'POST',
                            data: {
                                pass: $.md5($("#txtPassNew").val()),
                                opcion : accion
                            },
                            dataType: 'html',
                            success: function (data, textStatus, jqXHR) {
                                alert($.trim(data));
                                window.location.href = "Logout.jsp";
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert("ERROR SISTEMA"+jqXHR);
                            }
                        });
                    }

                    function validarPassActual() {
                        var retorno = "s";
                        var resultado = $.ajax({
                            async: false,
                            cache: false,
                            url: 'ValidarPassActualControl',
                            type: 'POST',
                            data: {
                                contraseña: $("#txtPassActual").val()
                            },
                            dataType: 'html',
                            success: function (data, textStatus, jqXHR) {
                                retorno = $.trim(data);
                            },
                            error: function (jqXHR, textStatus, errorThrown) {

                            }
                        });
                        return retorno;
                    }
        </script>
    </body>
</html>
