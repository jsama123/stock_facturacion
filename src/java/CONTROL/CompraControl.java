/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.CompraDAO;
import DTO.CompraDTO;
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
public class CompraControl extends HttpServlet {

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
        String id_proveedor = request.getParameter("id_proveedor");
        String id_cajero = request.getParameter("id_cajero");
        String id_caja = request.getParameter("id_caja");
        String fecha_compra = request.getParameter("fecha_compra");
        String numero_factura_compra = request.getParameter("numero_factura_compra") == null ? "--" : request.getParameter("numero_factura_compra");
        String tipo_compra = request.getParameter("tipo_compra") == "" ? "--" : request.getParameter("tipo_compra");
        String timbrado_compra = request.getParameter("timbrado_compra") == "" ? "--" : request.getParameter("timbrado_compra");
        String monto_entregado_compra = request.getParameter("monto_entregado_compra") == "" ? "0" : request.getParameter("monto_entregado_compra");
        String monto_total_compra = request.getParameter("monto_total_compra") == "" ? "0" : request.getParameter("monto_total_compra");
        String fecha_vencimiento_cuota_compra = request.getParameter("fecha_vencimiento_cuota_compra") == "" ? "--" : request.getParameter("fecha_vencimiento_cuota_compra");
        String cantidad_cuota_compra = request.getParameter("cantidad_cuota_compra") == "" ? "0" : request.getParameter("cantidad_cuota_compra");
        String id_deposito = request.getParameter("id_deposito") == "" ? "0" : request.getParameter("id_deposito");
        //String descuento_compra = request.getParameter("descuento_compra") == null ? "0" : request.getParameter("descuento_compra");

        HttpSession sesion = request.getSession();
        FechaActual fecha = new FechaActual();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        CompraDTO compraDto = new CompraDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        CompraDAO compraDao = auditorFac.crearObjetoCompra();
        compraDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    compraDto.setId_proveedor(Integer.parseInt(id_proveedor));
                    compraDto.setId_cajero(Integer.parseInt(id_cajero));
                    compraDto.setId_caja(Integer.parseInt(id_caja));
                    compraDto.setFecha_compra(Date.valueOf(fecha.convertirDDMMYYYYaYYYYMMDD(fecha_compra)));
                    compraDto.setUsu_alta(usuario);
                    compraDto.setNumero_factura_compra(numero_factura_compra);
                    compraDto.setTipo_compra(tipo_compra);
                    compraDto.setMonto_entregado_compra(Double.valueOf(monto_entregado_compra));
                    compraDto.setFecha_vencimiento_cuota_compra(fecha_vencimiento_cuota_compra);
                    compraDto.setCantidad_cuota_compra(Integer.parseInt(cantidad_cuota_compra));
                    compraDto.setId_deposito(Integer.parseInt(id_deposito));
                    compraDto.setTimbrado_compra(timbrado_compra);

                    error = compraDao.insertar(compraDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("CompraControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    compraDto.setId_proveedor(Integer.parseInt(id_proveedor));
                    compraDto.setId_cajero(Integer.parseInt(id_cajero));
                    compraDto.setId_caja(Integer.parseInt(id_caja));
                    compraDto.setFecha_compra(Date.valueOf(fecha.convertirDDMMYYYYaYYYYMMDD(fecha_compra)));
                    compraDto.setNumero_factura_compra(numero_factura_compra);
                    compraDto.setUsu_modi(usuario);
                    compraDto.setId(Integer.parseInt(id));
                    compraDto.setTipo_compra(tipo_compra);
                    compraDto.setMonto_entregado_compra(Double.valueOf(monto_entregado_compra));
                    compraDto.setFecha_vencimiento_cuota_compra(fecha_vencimiento_cuota_compra);
                    compraDto.setCantidad_cuota_compra(Integer.parseInt(cantidad_cuota_compra));
                    compraDto.setId_deposito(Integer.parseInt(id_deposito));
                    compraDto.setTimbrado_compra(timbrado_compra);

                    error = compraDao.modificar(compraDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("CompraControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = compraDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("CompraControl.java : " + error);
                }
                break;
            case 5:
                System.out.println("FINIQUITAR COMPRA");
                try {
                    compraDto.setId(Integer.parseInt(id));
                    compraDto.setUsu_modi(usuario);

                    error = compraDao.finiquitar(compraDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("CompraControl.java : " + error);
                }
                break;

            case 6:
                System.out.println("ANULAR COMPRA");
                try {
                    compraDto.setId(Integer.parseInt(id));
                    compraDto.setUsu_modi(usuario);

                    error = compraDao.anular(compraDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("CompraControl.java : " + error);
                }
                break;
            case 7:
                System.out.println("AJUSTE MONTO TOTAL sCOMPRA");
                try {
                    compraDto.setId(Integer.parseInt(id));
                    compraDto.setMonto_total_compra(Double.valueOf(monto_total_compra));
                    compraDto.setUsu_modi(usuario);

                    error = compraDao.ajustarMontoTotalCompra(compraDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("CompraControl.java : " + error);
                }
                break;
            /* case 6:
             System.out.println("APLICAR DESCUENTO");
             try {

             compraDto.setDescuento_compra(Integer.parseInt(descuento_compra));
             compraDto.setId(Integer.parseInt(id));
             compraDto.setUsu_modi(usuario);

             error = compraDao.aplicarDescuentoCompra(compraDto);
             } catch (Exception e) { 
             error = "Error : " + e.getMessage();
             System.out.println("CompraControl.java : " + error);
             }
             break;*/
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
