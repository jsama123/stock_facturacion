<%-- 
    Document   : LoginControl
    Created on : 25/01/2017, 01:43:11 PM
    Author     : Jose Samaniego
--%>

<%@page import="genericos.Conexion"%>
<%@page import="genericos.ValidarUsuario"%>
<%
    Conexion cn = new Conexion();
    cn.getConexion();

    ValidarUsuario usuValid = new ValidarUsuario();
    usuValid.setConexion(cn.getConexion());
    String msjError = "";
    boolean error = false;
    HttpSession sesion = request.getSession(true);

    String usuario = request.getParameter("usuario");
    String contrase�a = request.getParameter("contrase�a");
    System.out.println(usuario + contrase�a);
    String bandera = usuValid.obtenerLoginUsuario(usuario, contrase�a);
    System.out.println(usuario + contrase�a+bandera);
    if (Integer.parseInt(bandera) == 1) {
        out.print("error;" + usuario);
    } else if (usuValid.verificarUsuarioExiste(usuario, contrase�a).equals("n")) {
        msjError = "Usuario y/o Contrase�a Incorrectos";
        error = true;
        System.out.println("ERROR USUARIO SE�A");
    } else if (usuValid.verificarUsuarioExiste(usuario, contrase�a).equals("vacio")) {
        msjError = "Usuario no Existe";
        error = true;
        System.out.println("ERROR USUARIO EXISTENCIA");
    }
    if (error) {
        sesion.invalidate();
        out.println(msjError);
    } else {
        //sesion.setAttribute("perfilUsuario", usuValid.obtenerPerfilUsuario(usuario, contrase�a));
        sesion.setAttribute("loginUsuario", usuario);
        sesion.setAttribute("perfilUsuario", usuValid.obtenerPerfilUsuario(usuario, contrase�a));
        sesion.setAttribute("gestionActiva", usuValid.obtenerGestionActiva());
        sesion.setAttribute("perfil", usuValid.obtenerPerfilUsuario(usuario, contrase�a));
        sesion.setAttribute("bandera", usuValid.obtenerLoginUsuario(usuario, contrase�a));
        sesion.setAttribute("objeto", "0");
        out.println("bien/"+usuValid.obtenerPerfilUsuario(usuario, contrase�a));
    }

    cn.desConectarBD();
%>
