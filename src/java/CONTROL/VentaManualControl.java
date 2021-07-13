/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.VentaManualDAO;
import DTO.VentaManualDTO;
import genericos.Conexion;
import genericos.FechaActual;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Jose Samaniego
 */
public class VentaManualControl extends HttpServlet {

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
        String id_cliente = request.getParameter("id_cliente");
        String id_cajero = request.getParameter("id_cajero");
        String id_caja = request.getParameter("id_caja");
        String fecha_venta = request.getParameter("fecha_venta");
        String numero_factura_venta = request.getParameter("numero_factura_venta") == null ? "--" : request.getParameter("numero_factura_venta");
        String id_tipo_pago = request.getParameter("id_tipo_pago") == null ? "0" : request.getParameter("id_tipo_pago");
        String descuento_venta = request.getParameter("descuento_venta") == null ? "0" : request.getParameter("descuento_venta");
        String monto_pago = request.getParameter("monto_pago") == null ? "0" : request.getParameter("monto_pago") ;

        HttpSession sesion = request.getSession();
        FechaActual fecha = new FechaActual();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        VentaManualDTO ventaDto = new VentaManualDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        VentaManualDAO ventaDao = auditorFac.crearObjetoVentaManual();
        ventaDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    ventaDto.setId_cliente(Integer.parseInt(id_cliente));
                    ventaDto.setId_cajero(Integer.parseInt(id_cajero));
                    ventaDto.setId_caja(Integer.parseInt(id_caja));
                    ventaDto.setFecha_venta(Date.valueOf(fecha.convertirDDMMYYYYaYYYYMMDD(fecha_venta)));
                    ventaDto.setUsu_alta(usuario);
                    ventaDto.setNumero_factura_venta(numero_factura_venta);

                    error = ventaDao.insertar(ventaDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("VentaManualControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    ventaDto.setId_cliente(Integer.parseInt(id_cliente));
                    ventaDto.setId_cajero(Integer.parseInt(id_cajero));
                    ventaDto.setId_caja(Integer.parseInt(id_caja));
                    ventaDto.setFecha_venta(Date.valueOf(fecha.convertirDDMMYYYYaYYYYMMDD(fecha_venta)));
                    ventaDto.setNumero_factura_venta(numero_factura_venta);
                    ventaDto.setUsu_modi(usuario);
                    ventaDto.setId(Integer.parseInt(id));

                    error = ventaDao.modificar(ventaDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("VentaManualControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = ventaDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("VentaManualControl.java : " + error);
                }
                break;
            case 4:
                System.out.println("REGISTRAR PAGO VENTA");
                try {

                    ventaDto.setId_tipo_pago(Integer.parseInt(id_tipo_pago));
                    ventaDto.setMonto_pago(Double.valueOf(monto_pago));
                    ventaDto.setId(Integer.parseInt(id));
                    ventaDto.setUsu_modi(usuario);

                    error = ventaDao.registrarPagoVentaManual(ventaDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("VentaManualControl.java : " + error);
                }
                break;
            case 5:
                System.out.println("FINIQUITAR VENTA");
                try {
                    ventaDto.setId(Integer.parseInt(id));
                    ventaDto.setUsu_modi(usuario);

                    error = ventaDao.finiquitar(ventaDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("VentaManualControl.java : " + error);
                }
                break;
            case 6:
                System.out.println("APLICAR DESCUENTO");
                try {

                    ventaDto.setDescuento_venta(Integer.parseInt(descuento_venta));
                    ventaDto.setId(Integer.parseInt(id));
                    ventaDto.setUsu_modi(usuario);

                    error = ventaDao.aplicarDescuentoVentaManual(ventaDto);
                } catch (Exception e) { 
                    error = "Error : " + e.getMessage();
                    System.out.println("VentaManualControl.java : " + error);
                }
                break;
            case 7:
                System.out.println("ANULAR VENTA MANUAL");
                try {
                    ventaDto.setId(Integer.parseInt(id));
                    ventaDto.setUsu_modi(usuario);

                    error = ventaDao.anular(ventaDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("VentaManualControl.java : " + error);
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
