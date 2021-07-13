<%-- 
    Document   : MarcaDatos
    Created on : 3/06/2020, 10:08:25 PM
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

    String opcion = request.getParameter("opcion");
    String id = request.getParameter("id");
    String nombre_empresa = "";
    rs1 = dataSource.obtenerDato("SELECT nombre_empresa FROM usuarios WHERE login_usuario = '" + usuario + "'");
    if (rs1.next()) {
        nombre_empresa = rs1.getString("nombre_empresa");
    }
    switch(Integer.parseInt(opcion)){
        case 1:
            rs = dataSource.obtenerDato("SELECT id_gasto, "
                    + "CASE WHEN g.id_proveedor = 0 THEN '--' ELSE ci_ruc_proveedor||'-'||razon_social_proveedor END as proveedor, concepto_gasto, nro_comprobante_gasto, "
                    + "monto_gasto, "
                    + "COALESCE(to_char(fecha_gasto, 'DD/MM/YYYY'), '--') as fecha, tipo_gasto, cantidad_cuota_gasto, iva_aplicado "
                    + "FROM stock_facturacion.gastos g  "
                    + "LEFT JOIN stock_facturacion.proveedores p on p.id_proveedor = g.id_proveedor "
                    + "LEFT JOIN usuarios u on u.login_usuario = g.usu_alta "
                    + "WHERE nombre_empresa = '"+nombre_empresa+"'"
                    + "ORDER BY 1 asc;");
            while(rs.next()){
                htmlDatos.append("<tr>"
                        + "<td>"+rs.getString("proveedor") +"</td>"
                        + "<td>"+rs.getString("fecha") +"</td>"
                        + "<td>"+rs.getString("concepto_gasto") +"</td>"
                        + "<td>"+rs.getString("nro_comprobante_gasto") +"</td>"
                        + "<td>"+rs.getString("monto_gasto") +"</td>"
                        + "<td><img src='imagenes/edit.png' style='cursor:pointer' onclick=\"abrirFormulario('modificar', "+rs.getString("id_gasto")+")\" "
                        + "data-toggle='modal' data-target='#modalForm'></td>"
                        + "<td><img src='imagenes/delete.png' style='cursor:pointer' onclick=\"abrirFormulario('eliminar', "+rs.getString("id_gasto")+")\" "
                        + "data-toggle='modal' data-target='#modalForm'></td>"
                        + "</tr>");
            }
            break;
        case 2: //OBTIENE DATOS PARA EL CAMPO DINAMICO DE CLIENTES
            rs = dataSource.obtenerDato("SELECT id_proveedor||'/'||ci_ruc_proveedor||'-'||razon_social_proveedor as proveedor FROM stock_facturacion.proveedores;");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("proveedor") + "'>"
                        + rs.getString("proveedor")
                        + "</option>");
            }
            break;
        case 3:
            rs = dataSource.obtenerDato("SELECT "
                    + "CASE WHEN g.id_proveedor = 0 THEN '0/--' ELSE g.id_proveedor||'/'||ci_ruc_proveedor||'-'||razon_social_proveedor END||','||COALESCE(concepto_gasto, '--')||','|| "
                    + "COALESCE(nro_comprobante_gasto, '--')||','||COALESCE(monto_gasto, 0)||','||COALESCE(to_char(fecha_gasto, 'DD/MM/YYYY'), '01/01/2000')"
                    + "||','||COALESCE(timbrado_gasto, '--')||','||COALESCE(cantidad_cuota_gasto, 0)||','||COALESCE(tipo_gasto, '---') as datos "
                    + "FROM stock_facturacion.gastos g  "
                    + "LEFT JOIN stock_facturacion.proveedores p on p.id_proveedor = g.id_proveedor "
                    + "WHERE id_gasto ="+id);
            if(rs.next()){
                htmlDatos.append(rs.getString("datos"));
            }
            break;
    }
    out.print(htmlDatos.toString());
    cn.desConectarBD();
%>
