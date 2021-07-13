/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package CONTROL;

import DAO.TraspasoDetalleDAO;
import DTO.TraspasoDetalleDTO;
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
public class TraspasoDetalleControl extends HttpServlet {

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
        String id_traspaso = request.getParameter("id_traspaso");
        String id_stock = request.getParameter("id_stock");
        String cantidad = request.getParameter("cantidad_traspaso");

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        TraspasoDetalleDTO traspasoDetalleDto = new TraspasoDetalleDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        TraspasoDetalleDAO traspasoDetalleDao = auditorFac.crearObjetoTraspasoDetalle();
        traspasoDetalleDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    traspasoDetalleDto.setId_traspaso(Integer.parseInt(id_traspaso));
                    traspasoDetalleDto.setId_stock(Integer.parseInt(id_stock));
                    traspasoDetalleDto.setCantidad(Integer.parseInt(cantidad));
                    traspasoDetalleDto.setId_stock(Integer.parseInt(id_stock));
                    traspasoDetalleDto.setUsu_alta(usuario);

                    error = traspasoDetalleDao.insertar(traspasoDetalleDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("TraspasoDetalleControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    traspasoDetalleDto.setId(Integer.parseInt(id));
                    traspasoDetalleDto.setId_stock(Integer.parseInt(id_stock));
                    traspasoDetalleDto.setCantidad(Integer.parseInt(cantidad));
                    traspasoDetalleDto.setUsu_modi(usuario);

                    error = traspasoDetalleDao.modificar(traspasoDetalleDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("TraspasoDetalleControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = traspasoDetalleDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("TraspasoDetalleControl.java : " + error);
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
