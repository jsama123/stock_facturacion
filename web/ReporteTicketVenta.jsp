<%-- 
    Document   : ReporteListadoProductos
    Created on : 16/09/2017, 08:41:54 PM
    Author     : Jose Samaniego
--%>

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
    //cn.getConexion();

    File archivo = new File(application.getRealPath("reportes/rpt_ticket_venta2.jasper"));
    Map parametros = new HashMap();
    String idVenta = request.getParameter("id_venta");
    File rutaSubReport = new File(application.getRealPath("reportes/"));
    
    parametros.put("idVenta", idVenta);
    parametros.put("SUBREPORT_DIR", rutaSubReport.getPath());

    byte[] bytes = JasperRunManager.runReportToPdf(archivo.getPath (), parametros, cn.getConexion());
  
    response.setContentType("application/pdf");
    response.setContentLength(bytes.length);
    ServletOutputStream outputStream = response.getOutputStream();
    outputStream.write(bytes, 0, bytes.length);
    outputStream.flush();
    outputStream.close();
    
    cn.desConectarBD();
%>
