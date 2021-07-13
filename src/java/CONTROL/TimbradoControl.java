/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.TimbradoDAO;
import DTO.TimbradoDTO;
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
 * @author Jose Samaniego
 */
public class TimbradoControl extends HttpServlet {

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
        String fecha_inicio = request.getParameter("fecha_inicio");
        String fecha_fin = request.getParameter("fecha_fin");
        String numero = request.getParameter("numero");
        String ultimo_nro_factura = request.getParameter("ultimoNroFactura");
        int estado = 0;

        HttpSession sesion = request.getSession();
        FechaActual fechaUtil = new FechaActual();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        TimbradoDTO timbradoDto = new TimbradoDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        TimbradoDAO timbradoDao = auditorFac.crearObjetoTimbrado();
        timbradoDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    timbradoDto.setNumero_timbrado(Double.parseDouble(numero));
                    timbradoDto.setFecha_inicio_timbrado(Date.valueOf(fechaUtil.convertirDDMMYYYYaYYYYMMDD(fecha_inicio)));
                    timbradoDto.setFecha_fin_timbrado(Date.valueOf(fechaUtil.convertirDDMMYYYYaYYYYMMDD(fecha_fin)));
                    timbradoDto.setEstado(estado);
                    timbradoDto.setUsu_alta(usuario);

                    error = timbradoDao.insertar(timbradoDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("TimbradoControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    timbradoDto.setNumero_timbrado(Double.parseDouble(numero));
                    timbradoDto.setFecha_inicio_timbrado(Date.valueOf(fechaUtil.convertirDDMMYYYYaYYYYMMDD(fecha_inicio)));
                    timbradoDto.setFecha_fin_timbrado(Date.valueOf(fechaUtil.convertirDDMMYYYYaYYYYMMDD(fecha_fin)));
                    timbradoDto.setEstado(estado);
                    timbradoDto.setUsu_modi(usuario);
                    timbradoDto.setId(Integer.parseInt(id));

                    error = timbradoDao.modificar(timbradoDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("TimbradoControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = timbradoDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("TimbradoControl.java : " + error);
                }
                break;
            case 4:
                try {
                    System.out.println("ACTUALIZAR ESTADO");

                    timbradoDto.setEstado(1);
                    timbradoDto.setUsu_modi(usuario);

                    error = timbradoDao.actualizarEstado(timbradoDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("TimbradoControl.java : " + error);
                }
                break;
            case 5:
                try {
                    System.out.println("ACTUALIZAR NRO FACTURA TIMBRADO VIGENTE");

                    timbradoDto.setUltimo_nro_factura(Integer.parseInt(ultimo_nro_factura));
                    timbradoDto.setUsu_modi(usuario);

                    error = timbradoDao.actualizarNroFacturaTimbradoVigennte(timbradoDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("TimbradoControl.java : " + error);
                }
                break;
            case 6:
                try {
                    System.out.println("ACTUALIZAR NRO FACTURA TIMBRADO VIGENTE");

                    timbradoDto.setUltimo_nro_factura(Integer.parseInt(ultimo_nro_factura) - 1);
                    timbradoDto.setUsu_modi(usuario);

                    error = timbradoDao.actualizarNroFacturaTimbradoVigennte(timbradoDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("TimbradoControl.java : " + error);
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
