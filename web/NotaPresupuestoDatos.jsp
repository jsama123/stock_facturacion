<%-- 
    Document   : MarcaDatos
    Created on : 3/06/2020, 10:08:25 PM
    Author     : Jose Samaniego
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
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

    Date fecha = new Date();
    DateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
    String fecha_actual = formato.format(fecha);

    DecimalFormat formatea = new DecimalFormat("###,###.##");

    String opcion = request.getParameter("opcion");
    String id = request.getParameter("id");
    String id_deposito = request.getParameter("id_deposito");
    String id_caja = request.getParameter("id_caja");
    String nombre_empresa = "";
    rs1 = dataSource.obtenerDato("SELECT nombre_empresa FROM usuarios WHERE login_usuario = '" + usuario + "'");
    if (rs1.next()) {
        nombre_empresa = rs1.getString("nombre_empresa");
    }
    switch (Integer.parseInt(opcion)) {
        case 1: //OBTIENE DATOS PARA LA GRILLA
            rs = dataSource.obtenerDato("SELECT "
                    + "id_nota_presupuesto, "
                    + "ci_ruc_cliente||'-'||razon_social_cliente as client,"
                    + " to_char(fecha_presupuesto, 'DD/MM/YYYY') as fecha, "
                    + "nro_nota_presupuesto "
                    + "FROM stock_facturacion.nota_presupuesto n "
                    + "LEFT JOIN stock_facturacion.clientes c on c.id_cliente = n.id_cliente "
                    + "LEFT JOIN usuarios u on u.login_usuario = n.usu_alta "
                    + "WHERE nombre_empresa = '" + nombre_empresa + "' "
                    + "ORDER BY 1 desc;");
            while (rs.next()) {
                htmlDatos.append("<tr>"
                        + "<td>" + rs.getString("fecha") + "</td>"
                        + "<td>" + rs.getString("nro_nota_presupuesto") + "</td>"
                        + "<td>" + rs.getString("client") + "</td>");
                htmlDatos.append("<td><img src='imagenes/edit.png' style='cursor:pointer' onclick=\"abrirFormulario('modificar', " + rs.getString("id_nota_presupuesto") + ")\" "
                        + "data-toggle='modal' data-target='#modalForm'></td>"
                        + "<td><img src='imagenes/delete.png' style='cursor:pointer' onclick=\"abrirFormulario('eliminar', " + rs.getString("id_nota_presupuesto") + ")\" "
                        + "data-toggle='modal' data-target='#modalForm'></td>"
                        + "<td><img src='imagenes/money.png' style='cursor:pointer' onclick=\"abrirDetalle(" + rs.getString("id_nota_presupuesto") + ")\" "
                        + "data-toggle='modal' data-target='#modalDetalleNotaPresupuesto'></td>");
                htmlDatos.append("<td><img src='imagenes/print.png' style='cursor:pointer' onclick=\"imprimir(" + rs.getString("id_nota_presupuesto") + ")\" "
                        + "data-toggle='modal' data-target='#'></td>"
                        + "</tr>");
            }
            break;
        case 2: //OBTIENE DATOS PARA EL CAMPO DINAMICO DE CLIENTES
            rs = dataSource.obtenerDato("SELECT id_cliente||'/'||ci_ruc_cliente||'-'||razon_social_cliente as cliente FROM stock_facturacion.clientes;");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("cliente") + "'>"
                        + rs.getString("cliente")
                        + "</option>");
            }
            break;
        case 3: //OBTIENE DATOS PARA EL COMBO DE CAJAS
            String retorno1;
            rs = dataSource.obtenerDato("SELECT "
                    + "COALESCE(max(nro_nota_presupuesto), 0)+1 as nroNota "
                    + "FROM stock_facturacion.nota_presupuesto");
            if (rs.next()) {
                htmlDatos.append(rs.getString("nroNota"));
            }
            break;
        case 4:
            rs = dataSource.obtenerDato("SELECT c.id_cliente||'/'||ci_ruc_cliente||'-'||razon_social_cliente||','||to_char(fecha_presupuesto, 'DD/MM/YYYY')||','||observacion_presupuesto as datos "
                    + "FROM stock_facturacion.nota_presupuesto n "
                    + "LEFT JOIN stock_facturacion.clientes c on c.id_cliente = n.id_cliente "
                    + "WHERE id_nota_presupuesto = " + id);
            if (rs.next()) {
                htmlDatos.append(rs.getString("datos"));
            }
            break;
        case 5:
            rs = dataSource.obtenerDato("SELECT "
                    + "'Cod:'||id_articulo||' |Art :'||articulo_descripcion||' |Precio:'||precio_venta::int||' |Impuesto :'||porcentaje_impuesto as articulo "
                    + "FROM stock_facturacion.articulos a "
                    + "LEFT JOIN stock_facturacion.impuestos i on i.id_impuesto = a.id_impuesto "
                    + "LEFT JOIN usuarios u on u.login_usuario = a.usu_alta "
                    + "WHERE id_articulo NOT IN ( SELECT id_articulo "
                    + "FROM stock_facturacion.nota_presupuesto_detalle "
                    + "WHERE id_nota_presupuesto = " + id + ") AND nombre_empresa = '" + nombre_empresa + "' ");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("articulo") + "'>"
                        + rs.getString("articulo")
                        + "</option>");
            }
            break;
        case 6:
            rs = dataSource.obtenerDato("SELECT porcentaje_lista_precio, descripcion_lista_precio "
                    + "FROM stock_facturacion.lista_precios;");
            while (rs.next()) {
                htmlDatos.append("<option value='" + rs.getString("porcentaje_lista_precio") + "'>"
                        + rs.getString("descripcion_lista_precio") + " - Desc : " + rs.getString("porcentaje_lista_precio") + " %"
                        + "</option>");
            }
            break;
        case 7:
            rs = dataSource.obtenerDato("SELECT "
                    + "id_nota_presupuesto_detalle, "
                    + "articulo_descripcion, "
                    + "cantidad, "
                    + "precio_aplicado-(precio_aplicado::int*desc_aplicado/100)::int as precio_venta, "
                    + "cantidad*(precio_aplicado-(precio_aplicado::int*desc_aplicado/100))::int as sub_total "
                    + "FROM stock_facturacion.nota_presupuesto_detalle v "
                    + "LEFT JOIN stock_facturacion.articulos a on a.id_articulo = v.id_articulo "
                    + "WHERE v.id_nota_presupuesto =" + id);
            while (rs.next()) {
                htmlDatos.append("<tr>"
                        + "<td>" + rs.getString("articulo_descripcion") + "</td>"
                        + "<td>" + rs.getString("cantidad") + "</td>"
                        + "<td>" + formatea.format(Double.valueOf(rs.getString("precio_venta"))) + "</td>"
                        + "<td>" + formatea.format(Double.valueOf(rs.getString("sub_total"))) + "</td>"
                        + "<td><img class='imgGrid' src='imagenes/delete.png' style='cursor:pointer' "
                        + "onclick=\"accionProcesoDetalleNotaPresupuesto(3, " + rs.getString("id_nota_presupuesto_detalle") + ")\"></td>"
                        + "</tr>");
            }
            break;
    }
    out.print(htmlDatos.toString());
    cn.desConectarBD();
%>