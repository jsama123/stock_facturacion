/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.CajeroDAO;
import DTO.CajeroDTO;
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
public class CajeroControl extends HttpServlet {

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
        String nro_caja = request.getParameter("nro_caja");
        String nombre_apellido_cajero = request.getParameter("nombre_apellido_cajero");
        String ci_cajero = request.getParameter("ci_cajero");
        String observaciones_cajero = request.getParameter("observaciones_cajero");

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        CajeroDTO cajeroDto = new CajeroDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        CajeroDAO cajeroDao = auditorFac.crearObjetoCajero();
        cajeroDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    cajeroDto.setNombre_apellido_cajero(nombre_apellido_cajero);
                    cajeroDto.setCi_cajero(ci_cajero);
                    cajeroDto.setObservaciones_cajero(observaciones_cajero);
                    cajeroDto.setUsu_alta(usuario);

                    error = cajeroDao.insertar(cajeroDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("CajeroControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    cajeroDto.setNombre_apellido_cajero(nombre_apellido_cajero);
                    cajeroDto.setCi_cajero(ci_cajero);
                    cajeroDto.setObservaciones_cajero(observaciones_cajero);
                    cajeroDto.setUsu_modi(usuario);
                    cajeroDto.setId(Integer.parseInt(id));

                    error = cajeroDao.modificar(cajeroDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("CajeroControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = cajeroDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("CajeroControl.java : " + error);
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
