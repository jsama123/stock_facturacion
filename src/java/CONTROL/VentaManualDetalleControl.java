/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.VentaManualDetalleDAO;
import DTO.VentaManualDetalleDTO;
import genericos.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Jose Samaniego
 */
public class VentaManualDetalleControl extends HttpServlet {

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
        String id_venta = request.getParameter("id_venta");
        String id_articulo = request.getParameter("id_articulo");
        String cantidad_venta = request.getParameter("cantidad_venta");
        String precio_unitario = request.getParameter("precio_unitario");
        String id_stock = request.getParameter("id_stock");
        String iva_aplicado = request.getParameter("iva_aplicado");
        String descuenta_venta = request.getParameter("descuenta_venta");
        String descuento_gs_venta = request.getParameter("descuento_gs_venta");
        String es_desc_gs_venta = request.getParameter("es_desc_gs_venta");

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        VentaManualDetalleDTO ventaDetalleDto = new VentaManualDetalleDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        VentaManualDetalleDAO ventaDetalleDao = auditorFac.crearObjetoVentaManualDetalle();
        ventaDetalleDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    ventaDetalleDto.setId_venta(Integer.parseInt(id_venta));
                    ventaDetalleDto.setCantidad_venta(Integer.parseInt(cantidad_venta));
                    ventaDetalleDto.setPrecio_unitario(Double.valueOf(precio_unitario));
                    ventaDetalleDto.setId_stock(Integer.parseInt(id_stock));
                    ventaDetalleDto.setIva_aplicado(Integer.parseInt(iva_aplicado));
                    ventaDetalleDto.setUsu_alta(usuario);
                    ventaDetalleDto.setEs_desc_gs_venta(Boolean.parseBoolean(es_desc_gs_venta));
                    ventaDetalleDto.setDescuento_gs_venta(Integer.parseInt(descuento_gs_venta));
                    ventaDetalleDto.setDescuenta_venta(Integer.parseInt(descuenta_venta));

                    error = ventaDetalleDao.insertar(ventaDetalleDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("VentaManualDetalleControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    ventaDetalleDto.setCantidad_venta(Integer.parseInt(cantidad_venta));
                    ventaDetalleDto.setPrecio_unitario(Double.valueOf(precio_unitario));
                    ventaDetalleDto.setUsu_modi(usuario);
                    ventaDetalleDto.setId_venta_detalle(Integer.parseInt(id));

                    error = ventaDetalleDao.modificar(ventaDetalleDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("VentaManualDetalleControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = ventaDetalleDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("VentaManualDetalleControl.java : " + error);
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
