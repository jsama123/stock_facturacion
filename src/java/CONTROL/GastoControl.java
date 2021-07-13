/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.GastoDAO;
import DTO.GastoDTO;
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
public class GastoControl extends HttpServlet {

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
        FechaActual fecha = new FechaActual();

        String id = request.getParameter("id");
        String id_proveedor = request.getParameter("id_proveedor") == "" ? "0" : request.getParameter("id_proveedor");
        String concepto_gasto = request.getParameter("concepto_gasto");
        String nro_comprobante_gasto = request.getParameter("nro_comprobante_gasto") != null ? request.getParameter("nro_comprobante_gasto") : "0";
        String monto_gasto = request.getParameter("monto_gasto");
        String tipo_gasto = request.getParameter("tipo_gasto") != null ? request.getParameter("tipo_gasto") : "--";
        String timbrado_gasto = request.getParameter("timbrado_gasto") != null ? request.getParameter("timbrado_gasto") : "--";
        String cantidad_cuota_gasto = request.getParameter("cantidad_cuota_gasto") != null ? request.getParameter("cantidad_cuota_gasto") : "0" ;
        String iva = request.getParameter("iva");
        String fecha_gasto = request.getParameter("fecha_gasto") == "" ? "01/01/2020" : request.getParameter("fecha_gasto") ;

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        GastoDTO gastoDto = new GastoDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        GastoDAO gastoDao = auditorFac.crearObjetoGasto();
        gastoDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    gastoDto.setId_proveedor(Integer.parseInt(id_proveedor));
                    gastoDto.setConcepto_gasto(concepto_gasto);
                    gastoDto.setNro_comprobante_gasto(nro_comprobante_gasto);
                    gastoDto.setMonto_gasto(Double.valueOf(monto_gasto));
                    gastoDto.setTipo_gasto(tipo_gasto);
                    gastoDto.setIva(Integer.parseInt(iva));
                    gastoDto.setCantidad_cuota_gasto(Integer.parseInt(cantidad_cuota_gasto));
                    gastoDto.setUsu_alta(usuario);
                    gastoDto.setFecha_gasto(Date.valueOf(fecha.convertirDDMMYYYYaYYYYMMDD(fecha_gasto)));
                    gastoDto.setTimbrado_gasto(timbrado_gasto);

                    error = gastoDao.insertar(gastoDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("GastoControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    gastoDto.setId_proveedor(Integer.parseInt(id_proveedor));
                    gastoDto.setConcepto_gasto(concepto_gasto);
                    gastoDto.setNro_comprobante_gasto(nro_comprobante_gasto);
                    gastoDto.setMonto_gasto(Double.valueOf(monto_gasto));
                    gastoDto.setTipo_gasto(tipo_gasto);
                    gastoDto.setIva(Integer.parseInt(iva));
                    gastoDto.setCantidad_cuota_gasto(Integer.parseInt(cantidad_cuota_gasto));
                    gastoDto.setUsu_modi(usuario);
                    gastoDto.setFecha_gasto(Date.valueOf(fecha.convertirDDMMYYYYaYYYYMMDD(fecha_gasto)));
                    gastoDto.setId(Integer.parseInt(id));
                    gastoDto.setTimbrado_gasto(timbrado_gasto);

                    error = gastoDao.modificar(gastoDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("GastoControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = gastoDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("GastoControl.java : " + error);
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
