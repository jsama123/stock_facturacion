/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package CONTROL;

import DAO.NotaPresupuestoDetalleDAO;
import DTO.NotaPresupuestoDetalleDTO;
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
 * @author jose-samaniego
 */
public class NotaPresupuestoDetalleControl extends HttpServlet {

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
        String id_nota_presu = request.getParameter("id_nota_presu");
        String id_articulo = request.getParameter("id_articulo");
        String cantidad_venta = request.getParameter("cantidad_venta");
        String precio_unitario = request.getParameter("precio_unitario");
        String iva_aplicado = request.getParameter("iva_aplicado");
        String descuenta_venta = request.getParameter("descuenta_venta");

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        NotaPresupuestoDetalleDTO notaPresuDetalleDto = new NotaPresupuestoDetalleDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        NotaPresupuestoDetalleDAO notaPresuDetalleDao = auditorFac.crearObjetoNotaPresupuestoDetalle();
        notaPresuDetalleDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    notaPresuDetalleDto.setId_nota_presupuesto(Integer.parseInt(id_nota_presu));
                    notaPresuDetalleDto.setCantidad(Integer.parseInt(cantidad_venta));
                    notaPresuDetalleDto.setPrecio_aplicado(Double.valueOf(precio_unitario));
                    notaPresuDetalleDto.setId_articulo(Integer.parseInt(id_articulo));
                    notaPresuDetalleDto.setIva_aplicado(Integer.parseInt(iva_aplicado));
                    notaPresuDetalleDto.setDesc_aplicado(Integer.parseInt(descuenta_venta));

                    error = notaPresuDetalleDao.insertar(notaPresuDetalleDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("NotaPresupuestoDetalleControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    notaPresuDetalleDto.setId_nota_presupuesto(Integer.parseInt(id_nota_presu));
                    notaPresuDetalleDto.setCantidad(Integer.parseInt(cantidad_venta));
                    notaPresuDetalleDto.setPrecio_aplicado(Double.valueOf(precio_unitario));
                    notaPresuDetalleDto.setId_articulo(Integer.parseInt(id_articulo));
                    notaPresuDetalleDto.setIva_aplicado(Integer.parseInt(iva_aplicado));
                    notaPresuDetalleDto.setDesc_aplicado(Integer.parseInt(descuenta_venta));

                    error = notaPresuDetalleDao.modificar(notaPresuDetalleDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("NotaPresupuestoDetalleControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = notaPresuDetalleDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("NotaPresupuestoDetalleControl.java : " + error);
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
