/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package CONTROL;

import DAO.TraspasoDAO;
import DTO.TraspasoDTO;
import genericos.Conexion;
import genericos.FechaActual;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author jose-samaniego
 */
public class TraspasoControl extends HttpServlet {

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
        String id_deposito_destino = request.getParameter("id_deposito_destino");
        String id_deposito_origen = request.getParameter("id_deposito_origen");
        String fecha = request.getParameter("fecha");
        String observacion = request.getParameter("observacion");
        int estado = 0;

        HttpSession sesion = request.getSession();
        FechaActual fechaUtil = new FechaActual();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        TraspasoDTO traspasoDto = new TraspasoDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        TraspasoDAO traspasoDao = auditorFac.crearObjetoTraspaso();
        traspasoDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    traspasoDto.setId_deposito_destino(Integer.parseInt(id_deposito_destino));
                    traspasoDto.setId_deposito_origen(Integer.parseInt(id_deposito_origen));
                    traspasoDto.setFecha(Date.valueOf(fechaUtil.convertirDDMMYYYYaYYYYMMDD(fecha)));
                    traspasoDto.setObservacion(observacion);
                    traspasoDto.setEstado(estado);
                    traspasoDto.setUsu_alta(usuario);

                    error = traspasoDao.insertar(traspasoDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("TraspasoControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    traspasoDto.setId_deposito_destino(Integer.parseInt(id_deposito_destino));
                    traspasoDto.setId_deposito_origen(Integer.parseInt(id_deposito_origen));
                    traspasoDto.setFecha(Date.valueOf(fechaUtil.convertirDDMMYYYYaYYYYMMDD(fecha)));
                    traspasoDto.setObservacion(observacion);
                    traspasoDto.setUsu_modi(usuario);
                    traspasoDto.setId(Integer.parseInt(id));

                    error = traspasoDao.modificar(traspasoDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("TraspasoControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = traspasoDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("TraspasoControl.java : " + error);
                }
                break;
          /*  case 4:
                try {
                    System.out.println("ACTUALIZAR ESTADO");

                    traspasoDto.setEstado(1);
                    traspasoDto.setUsu_modi(usuario);

                    error = traspasoDao.actualizarEstado(traspasoDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("TraspasoControl.java : " + error);
                }
                break;
            case 5:
                try {
                    System.out.println("ACTUALIZAR NRO FACTURA TIMBRADO VIGENTE");

                    traspasoDto.setUltimo_nro_factura(Integer.parseInt(ultimo_nro_factura));
                    traspasoDto.setUsu_modi(usuario);

                    error = traspasoDao.actualizarNroFacturaTraspasoVigennte(traspasoDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("TraspasoControl.java : " + error);
                }
                break;
            case 6:
                try {
                    System.out.println("ACTUALIZAR NRO FACTURA TIMBRADO VIGENTE");

                    traspasoDto.setUltimo_nro_factura(Integer.parseInt(ultimo_nro_factura) - 1);
                    traspasoDto.setUsu_modi(usuario);

                    error = traspasoDao.actualizarNroFacturaTraspasoVigennte(traspasoDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("TraspasoControl.java : " + error);
                }
                break; */
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
