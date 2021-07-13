<%-- 
    Document   : ChequearSesion
    Created on : 16/05/2016, 10:00:43 AM
    Author     : Jose Samaniego
--%>

<%
String usr_login = (String) session.getAttribute("loginUsuario");

if(usr_login==null){
    response.sendRedirect("FinSesion.jsp");
    return;
}
%>