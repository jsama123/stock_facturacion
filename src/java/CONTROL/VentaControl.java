/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.VentaDAO;
import DTO.VentaDTO;
import genericos.Conexion;
import genericos.FechaActual;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Jose Samaniego
 */
public class VentaControl extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String accion = request.getParameter("opcion");
        Conexion cn = new Conexion();
        
        String id = request.getParameter("id");
        String id_cliente = request.getParameter("id_cliente")== null ? "0" : request.getParameter("id_cliente");
        String id_timbrado = request.getParameter("id_timbrado");
        String id_cajero = request.getParameter("id_cajero");
        String id_caja = request.getParameter("id_caja");
        //String fecha_venta = request.getParameter("fecha_venta");
        String numero_factura_venta = request.getParameter("numero_factura_venta")== "" ? "0" : request.getParameter("numero_factura_venta");
        String numero_ticket_venta = request.getParameter("numero_ticket_venta") == "" ? "0" : request.getParameter("numero_ticket_venta");
        String id_tipo_pago = request.getParameter("id_tipo_pago")== "" ? "0" : request.getParameter("id_tipo_pago");
        String descuento_venta = request.getParameter("descuento_venta") == "" ? "0" : request.getParameter("descuento_venta");
        String monto_pago = request.getParameter("monto_pago")== "" ? "0" : request.getParameter("monto_pago");
        String nro_boleta_tarjeta = request.getParameter("nro_boleta_tarjeta") == "" ? "--" : request.getParameter("nro_boleta_tarjeta");
        String tipo_venta = request.getParameter("tipo_venta") == "" ? "CON" : request.getParameter("tipo_venta");
        String fecha_venc_cuota = request.getParameter("fecha_venc_cuota") == "" ? "01/01/2000" : request.getParameter("fecha_venc_cuota");
        String cant_cuota = request.getParameter("cant_cuota") == "" ? "0" : request.getParameter("cant_cuota");
        System.out.println("VALORES : "+id_cliente+id_timbrado+id_cajero+id_caja+numero_factura_venta+numero_ticket_venta+tipo_venta+fecha_venc_cuota+cant_cuota);
        
        HttpSession sesion = request.getSession();
        FechaActual fecha = new FechaActual();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";
        
        java.util.Date fecha1 = new java.util.Date();
        DateFormat dato = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String fecha_venta1 = dato.format(fecha1);
        
        VentaDTO ventaDto = new VentaDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        VentaDAO ventaDao = auditorFac.crearObjetoVenta();
        ventaDao.crearConexion(cn.getConexion());
        
        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");
                    
                    ventaDto.setId_cliente(Integer.parseInt(id_cliente));
                    ventaDto.setId_timbrado(id_timbrado);
                    ventaDto.setId_cajero(Integer.parseInt(id_cajero));
                    ventaDto.setId_caja(Integer.parseInt(id_caja));
                    ventaDto.setFecha_venta(Timestamp.valueOf(fecha_venta1));
                    ventaDto.setTipo_venta(tipo_venta);
                    ventaDto.setCantidad_cuotas_ventas(Integer.parseInt(cant_cuota));
                    ventaDto.setFecha_vencimiento_primer_cuota_venta(Date.valueOf(fecha.convertirDDMMYYYYaYYYYMMDD(fecha_venc_cuota)));
                    ventaDto.setUsu_alta(usuario);
                    
                    error = ventaDao.insertar(ventaDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("VentaControl.java : " + error+"VALORES : "+id_cliente+id_timbrado+id_cajero+id_caja+fecha_venta1+tipo_venta+tipo_venta+cant_cuota+fecha_venc_cuota);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");
                    
                    ventaDto.setId_cliente(Integer.parseInt(id_cliente));
                    ventaDto.setId_cajero(Integer.parseInt(id_cajero));
                    ventaDto.setId_caja(Integer.parseInt(id_caja));
                    ventaDto.setUsu_modi(usuario);
                    ventaDto.setId_timbrado(id_timbrado);
                    ventaDto.setId(Integer.parseInt(id));
                    ventaDto.setTipo_venta(tipo_venta);
                    ventaDto.setCantidad_cuotas_ventas(Integer.parseInt(cant_cuota));
                    ventaDto.setFecha_vencimiento_primer_cuota_venta(Date.valueOf(fecha.convertirDDMMYYYYaYYYYMMDD(fecha_venc_cuota)));
                    
                    error = ventaDao.modificar(ventaDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("VentaControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = ventaDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("VentaControl.java : " + error);
                }
                break;
            case 4:
                System.out.println("REGISTRAR PAGO VENTA");
                try {
                    
                    ventaDto.setId_tipo_pago(Integer.parseInt(id_tipo_pago));
                    ventaDto.setMonto_pago(Double.valueOf(monto_pago));
                    ventaDto.setId(Integer.parseInt(id));
                    ventaDto.setUsu_modi(usuario);
                    ventaDto.setNro_boleta_tarjeta(nro_boleta_tarjeta);
                    
                    error = ventaDao.registrarPagoVenta(ventaDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("VentaControl.java : " + error);
                }
                break;
            case 5:
                System.out.println("FINIQUITAR VENTA");
                try {
                    ventaDto.setId(Integer.parseInt(id));
                    ventaDto.setUsu_modi(usuario);
                    ventaDto.setNumero_ticket_venta(Integer.parseInt(numero_ticket_venta));
                    
                    error = ventaDao.finiquitar(ventaDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("VentaControl.java : " + error);
                }
                break;
            case 6:
                System.out.println("APLICAR DESCUENTO");
                try {
                    
                    ventaDto.setDescuento_venta(Integer.parseInt(descuento_venta));
                    ventaDto.setId(Integer.parseInt(id));
                    ventaDto.setUsu_modi(usuario);
                    
                    error = ventaDao.aplicarDescuentoVenta(ventaDto);
                } catch (Exception e) {                    
                    error = "Error : " + e.getMessage();
                    System.out.println("VentaControl.java : " + error);
                }
                break;
            case 7:
                try {
                    System.out.println("ANULAR VENTA");
                    
                    ventaDto.setId(Integer.parseInt(id));
                    ventaDto.setUsu_modi(usuario);
                    
                    error = ventaDao.anular(ventaDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("VentaControl.java : " + error);
                }
                break;
            case 8:
                try {
                    System.out.println("ACTUALIZAR NRO FACTURA VENTA");
                    
                    ventaDto.setId(Integer.parseInt(id));
                    ventaDto.setNumero_factura_venta(numero_factura_venta);
                    ventaDto.setUsu_modi(usuario);
                    
                    error = ventaDao.actualizarNroFacturaVenta(ventaDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("VentaControl.java : " + error);
                }
                break;
        }
        cn.desConectarBD();
        if (!error.equals("")) {
            out.print("error");
        } else {
            out.print("bien");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
