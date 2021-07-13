/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.NotaCreditoDAO;
import DTO.NotaCreditoDTO;
import genericos.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Jose Samaniego
 */
public class NotaCreditoControl extends HttpServlet {

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
        String id_cliente = request.getParameter("id_cliente");
        String concepto_nota_credito = request.getParameter("concepto_nota_credito");
        String fecha_nota_credito = request.getParameter("fecha_nota_credito");
        String numero_nota_credito = request.getParameter("numero_nota_credito");
        String observacion_nota_credito = request.getParameter("observacion_nota_credito");
        String accion_nota_credito = request.getParameter("accion_nota_credito");
        String nota_credito_utilizada = request.getParameter("nota_credito_utilizada");

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";
        
        java.util.Date fecha1 = new java.util.Date();
        DateFormat dato = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String fecha_nota = dato.format(fecha1);

        NotaCreditoDTO notaCreditoDto = new NotaCreditoDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        NotaCreditoDAO notaCreditoDao = auditorFac.crearObjetoNotaCredito();
        notaCreditoDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    notaCreditoDto.setId_cliente(Integer.parseInt(id_cliente));
                    notaCreditoDto.setConcepto_nota_credito(concepto_nota_credito);
                    notaCreditoDto.setFecha_nota_credito(Timestamp.valueOf(fecha_nota));
                    notaCreditoDto.setUsu_alta(usuario);

                    error = notaCreditoDao.insertar(notaCreditoDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("NotaCreditoControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    notaCreditoDto.setId_cliente(Integer.parseInt(id_cliente));
                    notaCreditoDto.setConcepto_nota_credito(concepto_nota_credito);
                    notaCreditoDto.setUsu_modi(usuario);
                    notaCreditoDto.setId(Integer.parseInt(id));

                    error = notaCreditoDao.modificar(notaCreditoDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("NotaCreditoControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = notaCreditoDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("NotaCreditoControl.java : " + error);
                }
                break;
            case 4:
                try {
                    System.out.println("PROCESAR");

                    notaCreditoDto.setNumero_nota_credito(Integer.parseInt(numero_nota_credito)+1);
                    notaCreditoDto.setObservacion_nota_credito(observacion_nota_credito);
                    notaCreditoDto.setAccion_nota_credito(Integer.parseInt(accion_nota_credito));
                    notaCreditoDto.setEstado(1);
                    notaCreditoDto.setUsu_modi(usuario);
                    notaCreditoDto.setId(Integer.parseInt(id));

                    error = notaCreditoDao.procesar(notaCreditoDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("NotaCreditoControl.java : " + error);
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
