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
    String contraseña = request.getParameter("contraseña");
    System.out.println(usuario + contraseña);
    String bandera = usuValid.obtenerLoginUsuario(usuario, contraseña);
    System.out.println(usuario + contraseña+bandera);
    if (Integer.parseInt(bandera) == 1) {
        out.print("error;" + usuario);
    } else if (usuValid.verificarUsuarioExiste(usuario, contraseña).equals("n")) {
        msjError = "Usuario y/o Contraseña Incorrectos";
        error = true;
        System.out.println("ERROR USUARIO SEÑA");
    } else if (usuValid.verificarUsuarioExiste(usuario, contraseña).equals("vacio")) {
        msjError = "Usuario no Existe";
        error = true;
        System.out.println("ERROR USUARIO EXISTENCIA");
    }
    if (error) {
        sesion.invalidate();
        out.println(msjError);
    } else {
        //sesion.setAttribute("perfilUsuario", usuValid.obtenerPerfilUsuario(usuario, contraseña));
        sesion.setAttribute("loginUsuario", usuario);
        sesion.setAttribute("perfilUsuario", usuValid.obtenerPerfilUsuario(usuario, contraseña));
        sesion.setAttribute("gestionActiva", usuValid.obtenerGestionActiva());
        sesion.setAttribute("perfil", usuValid.obtenerPerfilUsuario(usuario, contraseña));
        sesion.setAttribute("bandera", usuValid.obtenerLoginUsuario(usuario, contraseña));
        sesion.setAttribute("objeto", "0");
        out.println("bien/"+usuValid.obtenerPerfilUsuario(usuario, contraseña));
    }

    cn.desConectarBD();
%>
