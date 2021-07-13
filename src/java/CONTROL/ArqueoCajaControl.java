/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.ArqueoCajaDAO;
import DTO.ArqueoCajaDTO;
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
public class ArqueoCajaControl extends HttpServlet {

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
        String id_cajero = request.getParameter("id_cajero");
        String id_caja = request.getParameter("id_caja");
        String saldo_inicial_arqueo_caja = request.getParameter("saldo_inicial_arqueo_caja");
        String resultado_arqueo_caja = request.getParameter("resultado_arqueo_caja");
        String observacion_arqueo_caja = request.getParameter("observacion_arqueo_caja");
        String total_arqueo_caja = request.getParameter("total_arqueo_caja");
        
        Date fecha = new Date();
        DateFormat dato = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String fecha_inicio = dato.format(fecha);
        String fecha_fin = dato.format(fecha);
        System.out.println(fecha_inicio);

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        ArqueoCajaDTO arqueoCajaDto = new ArqueoCajaDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        ArqueoCajaDAO arqueoCajaDao = auditorFac.crearObjetoArqueoCaja();
        arqueoCajaDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    arqueoCajaDto.setId_cajero(Integer.parseInt(id_cajero));
                    arqueoCajaDto.setId_caja(Integer.parseInt(id_caja));
                    arqueoCajaDto.setFecha_inicio(Timestamp.valueOf(fecha_inicio));
                    arqueoCajaDto.setSaldo_inicial_arqueo_caja(Double.valueOf(saldo_inicial_arqueo_caja));
                    arqueoCajaDto.setEstado_arqueo_caja(0);
                    arqueoCajaDto.setUsu_alta(usuario);

                    error = arqueoCajaDao.insertar(arqueoCajaDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ArqueoCajaControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    arqueoCajaDto.setId_cajero(Integer.parseInt(id_cajero));
                    arqueoCajaDto.setId_caja(Integer.parseInt(id_caja));
                    arqueoCajaDto.setSaldo_inicial_arqueo_caja(Double.valueOf(saldo_inicial_arqueo_caja));
                    arqueoCajaDto.setUsu_modi(usuario);
                    arqueoCajaDto.setId(Integer.parseInt(id));

                    error = arqueoCajaDao.modificar(arqueoCajaDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ArqueoCajaControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = arqueoCajaDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ArqueoCajaControl.java : " + error);
                }
                break;
            case 4:
                try {
                    System.out.println("CERRAR CAJA");

                    arqueoCajaDto.setFecha_fin(Timestamp.valueOf(fecha_fin));
                    arqueoCajaDto.setEstado_arqueo_caja(1);
                    arqueoCajaDto.setResultado_arqueo_caja(Double.valueOf(resultado_arqueo_caja));
                    arqueoCajaDto.setObservacion_arqueo_caja(observacion_arqueo_caja);
                    arqueoCajaDto.setUsu_modi(usuario);
                    arqueoCajaDto.setTotal_arqueo_caja(Double.valueOf(total_arqueo_caja));
                    arqueoCajaDto.setId(Integer.parseInt(id));

                    error = arqueoCajaDao.cerrarCaja(arqueoCajaDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ArqueoCajaControl.java : " + error);
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
