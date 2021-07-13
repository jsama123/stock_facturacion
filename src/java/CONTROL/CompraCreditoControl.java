/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.CompraCreditoDAO;
import DTO.CompraCreditoDTO;
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
public class CompraCreditoControl extends HttpServlet {

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
        String id_compra = request.getParameter("id_compra");
        String fecha_pago_cuota = request.getParameter("fecha_pago_cuota");
        String nro_comprobante_pago_cuota = request.getParameter("nro_comprobante_pago_cuota");
        String monto_pagado_cuota = request.getParameter("monto_pagado_cuota");
        String id_tipo_comprobante = request.getParameter("id_tipo_comprobante");

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";
        
        FechaActual fecha = new FechaActual();

        CompraCreditoDTO compraCreditoDto = new CompraCreditoDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        CompraCreditoDAO compraCreditoDao = auditorFac.crearObjetoCompraCredito();
        compraCreditoDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    compraCreditoDto.setId_compra(Integer.parseInt(id_compra));
                    compraCreditoDto.setFecha_pago_cuota(Date.valueOf(fecha.convertirDDMMYYYYaYYYYMMDD(fecha_pago_cuota)));
                    compraCreditoDto.setNro_comprobante_pago_cuota(nro_comprobante_pago_cuota);
                    compraCreditoDto.setMonto_pagado_cuota(Double.valueOf(monto_pagado_cuota));
                    compraCreditoDto.setId_tipo_comprobante(Integer.parseInt(id_tipo_comprobante));
                    compraCreditoDto.setUsu_alta(usuario);

                    error = compraCreditoDao.insertar(compraCreditoDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("CompraCreditoControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    compraCreditoDto.setId(Integer.parseInt(id));
                    compraCreditoDto.setFecha_pago_cuota(Date.valueOf(fecha.convertirDDMMYYYYaYYYYMMDD(fecha_pago_cuota)));
                    compraCreditoDto.setNro_comprobante_pago_cuota(nro_comprobante_pago_cuota);
                    compraCreditoDto.setMonto_pagado_cuota(Double.valueOf(monto_pagado_cuota));
                    compraCreditoDto.setId_tipo_comprobante(Integer.parseInt(id_tipo_comprobante));
                    compraCreditoDto.setUsu_modi(usuario);

                    error = compraCreditoDao.modificar(compraCreditoDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("CompraCreditoControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = compraCreditoDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("CompraCreditoControl.java : " + error);
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
