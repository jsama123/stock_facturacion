/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.ArqueoCajaDetalleDAO;
import DTO.ArqueoCajaDetalleDTO;
import genericos.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Jose Samaniego
 */
public class ArqueoCajaDetalleControl extends HttpServlet {

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
        String id_arqueo_caja = request.getParameter("id_arqueo_caja");
        String cantidad = request.getParameter("cantidad");
        String denominacion = request.getParameter("denominacion");
        
        Date fecha = new Date();
        DateFormat dato = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String fecha_inicio = dato.format(fecha);
        System.out.println(fecha_inicio);

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        ArqueoCajaDetalleDTO arqueoCajaDetalleDto = new ArqueoCajaDetalleDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        ArqueoCajaDetalleDAO arqueoCajaDetalleDao = auditorFac.crearObjetoArqueoCajaDetalle();
        arqueoCajaDetalleDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    arqueoCajaDetalleDto.setId_arqueo_caja(Integer.parseInt(id_arqueo_caja));
                    arqueoCajaDetalleDto.setCantidad(Integer.parseInt(cantidad));
                    arqueoCajaDetalleDto.setDenominacion(Double.valueOf(denominacion));
                    arqueoCajaDetalleDto.setUsu_alta(usuario);

                    error = arqueoCajaDetalleDao.insertar(arqueoCajaDetalleDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ArqueoCajaDetalleControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    arqueoCajaDetalleDto.setId(Integer.parseInt(id));
                    arqueoCajaDetalleDto.setCantidad(Integer.parseInt(cantidad));
                    arqueoCajaDetalleDto.setDenominacion(Double.valueOf(denominacion));
                    arqueoCajaDetalleDto.setUsu_modi(usuario);

                    error = arqueoCajaDetalleDao.modificar(arqueoCajaDetalleDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ArqueoCajaDetalleControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = arqueoCajaDetalleDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ArqueoCajaDetalleControl.java : " + error);
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
