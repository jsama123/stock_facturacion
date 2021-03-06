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
    String contraseņa = request.getParameter("contraseņa");
    System.out.println(usuario + contraseņa);
    String bandera = usuValid.obtenerLoginUsuario(usuario, contraseņa);
    System.out.println(usuario + contraseņa+bandera);
    if (Integer.parseInt(bandera) == 1) {
        out.print("error;" + usuario);
    } else if (usuValid.verificarUsuarioExiste(usuario, contraseņa).equals("n")) {
        msjError = "Usuario y/o Contraseņa Incorrectos";
        error = true;
        System.out.println("ERROR USUARIO SEŅA");
    } else if (usuValid.verificarUsuarioExiste(usuario, contraseņa).equals("vacio")) {
        msjError = "Usuario no Existe";
        error = true;
        System.out.println("ERROR USUARIO EXISTENCIA");
    }
    if (error) {
        sesion.invalidate();
        out.println(msjError);
    } else {
        //sesion.setAttribute("perfilUsuario", usuValid.obtenerPerfilUsuario(usuario, contraseņa));
        sesion.setAttribute("loginUsuario", usuario);
        sesion.setAttribute("perfilUsuario", usuValid.obtenerPerfilUsuario(usuario, contraseņa));
        sesion.setAttribute("gestionActiva", usuValid.obtenerGestionActiva());
        sesion.setAttribute("perfil", usuValid.obtenerPerfilUsuario(usuario, contraseņa));
        sesion.setAttribute("bandera", usuValid.obtenerLoginUsuario(usuario, contraseņa));
        sesion.setAttribute("objeto", "0");
        out.println("bien/"+usuValid.obtenerPerfilUsuario(usuario, contraseņa));
    }

    cn.desConectarBD();
%>
