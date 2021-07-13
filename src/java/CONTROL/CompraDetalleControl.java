/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.CompraDetalleDAO;
import DTO.CompraDetalleDTO;
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
public class CompraDetalleControl extends HttpServlet {

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
        String id_compra = request.getParameter("id_compra");
        String id_articulo = request.getParameter("id_articulo");
        String cantidad_compra = request.getParameter("cantidad_compra");
        String costo_unitario = request.getParameter("costo_unitario");
        String id_stock = request.getParameter("id_stock");
        String iva_aplicado = request.getParameter("iva_aplicado");

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        CompraDetalleDTO compraDetalleDto = new CompraDetalleDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        CompraDetalleDAO compraDetalleDao = auditorFac.crearObjetoCompraDetalle();
        compraDetalleDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    compraDetalleDto.setId_compra(Integer.parseInt(id_compra));
                    compraDetalleDto.setCantidad_compra(Integer.parseInt(cantidad_compra));
                    compraDetalleDto.setPrecio_unitario(Double.valueOf(costo_unitario));
                    compraDetalleDto.setId_stock(Integer.parseInt(id_stock));
                    compraDetalleDto.setIva_aplicado(Integer.parseInt(iva_aplicado));
                    compraDetalleDto.setUsu_alta(usuario);

                    error = compraDetalleDao.insertar(compraDetalleDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("CompraDetalleControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    compraDetalleDto.setCantidad_compra(Integer.parseInt(cantidad_compra));
                    compraDetalleDto.setPrecio_unitario(Double.valueOf(costo_unitario));
                    compraDetalleDto.setUsu_modi(usuario);
                    compraDetalleDto.setId_compra_detalle(Integer.parseInt(id));

                    error = compraDetalleDao.modificar(compraDetalleDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("CompraDetalleControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = compraDetalleDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("CompraDetalleControl.java : " + error);
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
