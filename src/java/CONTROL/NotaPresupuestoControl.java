/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package CONTROL;

import DAO.NotaPresupuestoDAO;
import DTO.NotaPresupuestoDTO;
import genericos.Conexion;
import genericos.FechaActual;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author jose-samaniego
 */
public class NotaPresupuestoControl extends HttpServlet {

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

        String id_cliente = request.getParameter("id_cliente");
        String fecha_presupuesto = request.getParameter("fecha_presupuesto");
        String nro_nota_presupuesto = request.getParameter("nro_nota_presupuesto");
        String observacion_presupuesto = request.getParameter("observacion_presupuesto");
        String id = request.getParameter("id");

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";
        
        FechaActual fecha = new FechaActual();

        NotaPresupuestoDTO notaPresupuestoDto = new NotaPresupuestoDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        NotaPresupuestoDAO notaPresuDetalleDao = auditorFac.crearObjetoNotaPresupuesto();
        notaPresuDetalleDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    notaPresupuestoDto.setId_cliente(Integer.parseInt(id_cliente));
                    notaPresupuestoDto.setFecha_presupuesto(Date.valueOf(fecha.convertirDDMMYYYYaYYYYMMDD(fecha_presupuesto)));
                    notaPresupuestoDto.setUsu_alta(usuario);
                    notaPresupuestoDto.setNro_nota_presupuesto(Integer.parseInt(nro_nota_presupuesto));
                    notaPresupuestoDto.setObservacion_presupuesto(observacion_presupuesto);

                    error = notaPresuDetalleDao.insertar(notaPresupuestoDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("NotaPresupuestoControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    notaPresupuestoDto.setId_cliente(Integer.parseInt(id_cliente));
                    notaPresupuestoDto.setFecha_presupuesto(Date.valueOf(fecha.convertirDDMMYYYYaYYYYMMDD(fecha_presupuesto)));
                    notaPresupuestoDto.setUsu_alta(usuario);
                    notaPresupuestoDto.setObservacion_presupuesto(observacion_presupuesto);
                    notaPresupuestoDto.setId(Integer.parseInt(id));

                    error = notaPresuDetalleDao.modificar(notaPresupuestoDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("NotaPresupuestoControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = notaPresuDetalleDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("NotaPresupuestoControl.java : " + error);
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
