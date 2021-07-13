/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package CONTROL;

import DAO.ArticuloCostoDAO;
import DTO.ArticuloCostoDTO;
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
public class ArticuloCostoControl extends HttpServlet {

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
        String costo_compra = request.getParameter("costo_compra");
        String costo_venta = request.getParameter("costo_venta");
        String id_articulo = request.getParameter("id_articulo");

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        ArticuloCostoDTO articuloCostoDto = new ArticuloCostoDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        ArticuloCostoDAO articuloCostoDao = auditorFac.crearObjetoArticuloCosto();
        articuloCostoDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    articuloCostoDto.setCosto_compra(Double.valueOf(costo_compra));
                    articuloCostoDto.setCosto_venta(Double.valueOf(costo_venta));
                    articuloCostoDto.setId_articulo(Integer.parseInt(id_articulo));
                    articuloCostoDto.setUsu_alta(usuario);

                    error = articuloCostoDao.insertar(articuloCostoDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ArticuloCostoControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    articuloCostoDto.setCosto_compra(Double.valueOf(costo_compra));
                    articuloCostoDto.setCosto_venta(Double.valueOf(costo_venta));
                    articuloCostoDto.setId_articulo(Integer.parseInt(id_articulo));
                    articuloCostoDto.setUsu_modi(usuario);
                    articuloCostoDto.setId(Integer.parseInt(id));

                    error = articuloCostoDao.modificar(articuloCostoDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ArticuloCostoControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = articuloCostoDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ArticuloCostoControl.java : " + error);
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
