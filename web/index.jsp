<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <link href="css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <link href="css/login.css" rel="stylesheet">
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link rel="shortcut icon" type="image/png" href="imagenes/imagenIcono.png"/>

    <%
        HttpSession sesion = request.getSession(true);
        String perfil = (String) sesion.getAttribute("perfilUsuario");
    %>
    <!------ Include the above in your HEAD tag ---------->

    <body>
        <div id="login">
            <h3 class="text-center text-white pt-5">SISTEMA DE FACTURACION Y CONTROL DE STOCK</h3>
            <h5 class="text-center text-white pt-5">Credenciales de acceso al sistema : Usuario : <i>demoStock</i>; Password: <i>demoSt0ck</i></h5>
            <div class="container">
                <div id="login-row" class="row justify-content-center align-items-center">
                    <div id="login-column" class="col-md-6">
                        <div id="login-box" class="col-md-12">
                            <form id="login-form" class="form">
                                <h3 class="text-center text-info">SISTEMA PUNTO CLEAN / ACCESO</h3>
                                <div class="form-group">
                                    <label for="username" class="text-info">Usuario:</label><br>
                                    <input type="text" name="username" id="username" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label for="password" class="text-info">Password:</label><br>
                                    <input type="password" name="password" id="password" class="form-control">
                                </div>
                                <div class="form-group">
                                    <input type="button" onclick="loginControl()" class="btn btn-info btn-md" value="Ingresar">
                                    <div id="msjAlert" class="alert alert-danger" style="text-align: center; display: none">

                                    </div>
                                </div>
                                <label id="lblAccess" style="font-weight: bold; display: none">Accediendo...</label>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            function loginControl() {
                //alert("LLEGA");
                $("#lblAccess").show();
                var resultado = $.ajax({
                    async: false,
                    cache: false,
                    url: 'LoginControl.jsp',
                    type: 'POST',
                    data: {
                        usuario: $("#username").val(),
                        contraseña: $("#password").val()
                    },
                    dataType: 'html',
                    success: function(datos) {
                        var valor = [];
                        valor = $.trim(datos).split("/");
                        var result = valor[0];
                        var perfil = valor[1];
                        console.log(result+"-"+perfil);
                        if ($.trim(result) === 'bien') {
                            console.log("LLGA AL BIEN");
                            if ($.trim(perfil) === 'Operador') {
                                console.log("PRIN OPERADOR");
                                document.location.href = "principalOperador.jsp";
                            } else {
                                console.log("PRIN ADMIN");
                                document.location.href = "principal.jsp";
                            }
                        } else {
                            $("#lblAccess").hide();
                            $("#msjAlert").text($.trim(datos));
                            $("#msjAlert").show();
                            $("#login").val("");
                            $("#password").val("");
                            $("#username").focus();
                            $("#username").select();
                            setTimeout(function() {
                                $("#msjAlert").fadeOut(1500);
                            }, 1000);
                        }
                    },
                    error: function() {
                        alert("ERROR INTERNO : Comuníquese con soporte técnico.-");
                    }
                });
            }
        </script>
    </body>
</html>
