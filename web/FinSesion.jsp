<%-- 
    Document   : FinSesion
    Created on : 16/05/2016, 10:05:51 AM
    Author     : Jose Samaniego
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Fin Sesion</title>
    </head>
    <body>
        <%
            session.setAttribute("loginUsuario", "");
            //session.setAttribute("perfil", "");
            session.invalidate();
        %>
        <h1>ATENCION !!</h1>
        <h2>Por seguridad, el sistema ha cerrado su sesion<br/>
            Debe loguearse nuevamente para seguir usando el sistema.<br/>
            Muchas Gracias!!<br/></h2>
        <a href="index.jsp">Click aqui</a> para loguearse nuevamente
    </body>
</html>
