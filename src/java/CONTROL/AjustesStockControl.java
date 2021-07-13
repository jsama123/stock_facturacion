/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.AjustesStockDAO;
import DTO.AjustesStockDTO;
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
public class AjustesStockControl extends HttpServlet {

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
        String id_stock = request.getParameter("id_stock");
        String existencia = request.getParameter("existencia");
        String observacion = request.getParameter("observacion") == null ? "" : request.getParameter("observacion");
        String operacion = request.getParameter("operacion") == null ? "" : request.getParameter("operacion");
        String cantidad = request.getParameter("cantidad") == null ? "" : request.getParameter("cantidad");

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        AjustesStockDTO ajustesStockDto = new AjustesStockDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        AjustesStockDAO ajustesStockDao = auditorFac.crearObjetoAjustesStock();
        ajustesStockDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    ajustesStockDto.setId_stock(Integer.parseInt(id_stock));
                    ajustesStockDto.setExistencia(Double.valueOf(existencia));
                    ajustesStockDto.setObservacion(observacion);
                    ajustesStockDto.setCantidad(Integer.parseInt(cantidad));
                    ajustesStockDto.setOperacion(operacion);
                    ajustesStockDto.setEstado(0);
                    ajustesStockDto.setUsu_alta(usuario);

                    error = ajustesStockDao.insertar(ajustesStockDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("AjustesStockControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    ajustesStockDto.setId_stock(Integer.parseInt(id_stock));
                    ajustesStockDto.setExistencia(Double.valueOf(existencia));
                    ajustesStockDto.setObservacion(observacion);
                    ajustesStockDto.setCantidad(Integer.parseInt(cantidad));
                    ajustesStockDto.setOperacion(operacion);
                    ajustesStockDto.setUsu_modi(usuario);
                    ajustesStockDto.setId(Integer.parseInt(id));

                    error = ajustesStockDao.modificar(ajustesStockDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("AjustesStockControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = ajustesStockDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("AjustesStockControl.java : " + error);
                }
                break;
            case 4:
                try {
                    System.out.println("PROCESAR");

                    ajustesStockDto.setUsu_modi(usuario);
                    ajustesStockDto.setId(Integer.parseInt(id));

                    error = ajustesStockDao.procesar(ajustesStockDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("AjustesStockControl.java : " + error);
                }
                break;
            case 5:
                try {
                    System.out.println("ANULAR");

                    ajustesStockDto.setUsu_modi(usuario);
                    ajustesStockDto.setId(Integer.parseInt(id));

                    error = ajustesStockDao.anular(ajustesStockDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("AjustesStockControl.java : " + error);
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
