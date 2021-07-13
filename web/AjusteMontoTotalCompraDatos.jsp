 <%@page import="java.text.DecimalFormat"%>
<%-- 
    Document   : CajaDatos
    Created on : 3/07/2020, 09:19:38 PM
    Author     : Jose Samaniego
--%>

<%@page import="genericos.fuenteDatos"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="genericos.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Conexion cn = new Conexion();
    HttpSession sesion = (HttpSession) request.getSession();
    String usuario = (String) sesion.getAttribute("loginUsuario");
    ResultSet rs = null;
    ResultSet rs1 = null;
    StringBuilder htmlDatos = new StringBuilder();
    fuenteDatos dataSource = new fuenteDatos();
    dataSource.setConexion(cn.getConexion());

    DecimalFormat formatea = new DecimalFormat("###,###.##");
    
    String opcion = request.getParameter("opcion");
    String id = request.getParameter("id");
    String nombre_empresa = "";
    rs1 = dataSource.obtenerDato("SELECT nombre_empresa FROM usuarios WHERE login_usuario = '" + usuario + "'");
    if (rs1.next()) {
        nombre_empresa = rs1.getString("nombre_empresa");
    }
    switch(Integer.parseInt(opcion)){
        case 1:
            rs = dataSource.obtenerDato("SELECT id_compra, to_char(fecha_compra, 'DD/MM/YYYY') as fecha, nro_factura_compra, "
                    + "ci_ruc_proveedor||' - '||razon_social_proveedor as prov, COALESCE(monto_total_compra::int, 0) as montoCompra"
                    + " FROM stock_facturacion.compras c "
                    + "LEFT JOIN usuarios u on u.login_usuario = c.usu_alta "
                    + "LEFT JOIN stock_facturacion.proveedores p on p.id_proveedor = c.id_proveedor "
                    + "WHERE nombre_empresa = '"+nombre_empresa+"' "
                    + "ORDER BY id_compra desc;");
            while(rs.next()){
                htmlDatos.append("<tr>"
                        + "<td>"+rs.getString("id_compra") +"</td>"
                        + "<td>"+rs.getString("fecha") +"</td>"
                        + "<td>"+rs.getString("prov") +"</td>"
                        + "<td>"+rs.getString("nro_factura_compra") +"</td>"
                        + "<td>"+formatea.format(Double.valueOf(rs.getString("montoCompra"))) +"</td>"
                        + "<td><img src='imagenes/edit.png' style='cursor:pointer' onclick=\"abrirFormulario('modificar', "+rs.getString("id_compra")+")\" "
                        + "data-toggle='modal' data-target='#modalForm'></td>"
                        /*+ "<td><img src='imagenes/delete.png' style='cursor:pointer' onclick=\"abrirFormulario('eliminar', "+rs.getString("id_compra")+")\" "
                        + "data-toggle='modal' data-target='#modalForm'></td>"*/
                        + "</tr>");
            }
            break;
        case 2:
            rs = dataSource.obtenerDato("SELECT id_compra||','||COALESCE(monto_total_compra::int, 0) as datos FROM stock_facturacion.compras WHERE id_compra = "+id);
            if(rs.next()){
                htmlDatos.append(rs.getString("datos"));
            }
            break;
    }
    out.print(htmlDatos.toString());
    cn.desConectarBD();
%>

