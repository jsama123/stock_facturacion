<%-- 
    Document   : Logout
    Created on : 16/05/2016, 10:12:30 AM
    Author     : Jose Samaniego
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Session</title>
    </head>
    <body>
        <h2>La session se ha cerrado</h2>
        <%
        session.setAttribute("loginUsuario", "");
        //session.setAttribute("perfil", "");
        session.invalidate();
        %>
        
        <form name="p0" method="post" action="index.jsp">
            <script type="text/javascript">
                document.p0.submit();
            </script>
        </form>
    </body>
</html>
