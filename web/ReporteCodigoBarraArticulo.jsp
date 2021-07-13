<%-- 
    Document   : ReporteListadoProductos
    Created on : 16/09/2017, 08:41:54 PM
    Author     : Jose Samaniego
--%>

<%@page import="genericos.fuenteDatos"%>
<%@page import="genericos.Conexion"%>
<%@ page language="java" import="java.sql.*, javax.naming.*" %>

<%//To iReport%>
<%@ page import="net.sf.jasperreports.engine.*" %>
<%@ page import="net.sf.jasperreports.engine.util.JRLoader" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.lang.Object" %>
<%@ page import="java.io.*" %>

<jsp:useBean id="conexion" class="genericos.Conexion" scope="page" />



<%@ include file="ChequearSesion.jsp" %>
<%    Conexion cn = new Conexion();
    fuenteDatos dataSource = new fuenteDatos();
    dataSource.setConexion(cn.getConexion());
    ResultSet consultaDatos = null;
    cn.getConexion();

    String ids_concatenados = request.getParameter("ids_art_cant");
    String codigos_recibidos[] = ids_concatenados.split(",");
    String cantidades[] = null;
    StringBuilder selectSql = new StringBuilder();
    for (int i = 0; i < codigos_recibidos.length; i++) {
        cantidades = codigos_recibidos[i].split(";");
        for (int j = 0; j < Integer.parseInt(cantidades[1]); j++) {
            selectSql.append(" SELECT ");
            selectSql.append(j);
            selectSql.append(" as item, \n"
                    + " trim(to_char(id_articulo,'000000000000')) as id_articulo, \n"
                    + " articulo_descripcion \n"
                    + " FROM stock_facturacion.articulos \n"
                    + " WHERE id_articulo=");
            selectSql.append(cantidades[0]);
            if (Integer.parseInt(cantidades[1]) > 0) {
                if (Integer.parseInt(cantidades[1]) != (j + 1)) {
                    selectSql.append(" \n UNION ");
                }
            }
        }
        if (codigos_recibidos.length > 0) {
            if ((i + 1) != codigos_recibidos.length) {
                selectSql.append(" \n UNION ");
            } else if ((i + 1) == codigos_recibidos.length) {
                selectSql.append(" \n ORDER BY 3,1 ");
            }
        }
    }
    consultaDatos = dataSource.obtenerDato(selectSql.toString());
    JRResultSetDataSource parametroConsulta = new JRResultSetDataSource(consultaDatos);

    File archivo = new File(application.getRealPath("reportes/etiqueta_codigo_barra_articulos.jasper"));
    Map parametros = new HashMap();

    byte[] bytes = JasperRunManager.runReportToPdf(archivo.getPath(), parametros, parametroConsulta);

    response.setContentType("application/pdf");
    response.setContentLength(bytes.length);
    ServletOutputStream outputStream = response.getOutputStream();
    outputStream.write(bytes, 0, bytes.length);
    outputStream.flush();
    outputStream.close();

    cn.desConectarBD();
%>

