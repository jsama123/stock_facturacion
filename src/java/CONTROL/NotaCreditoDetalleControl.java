/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.NotaCreditoDetalleDAO;
import DTO.NotaCreditoDetalleDTO;
import genericos.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Jose Samaniego
 */
public class NotaCreditoDetalleControl extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String accion = request.getParameter("opcion");
        Conexion cn = new Conexion();

        String ids_concatenados = request.getParameter("ids_concatenados");
        String id_venta = request.getParameter("id_venta");
        String id = request.getParameter("id");
        String id_nota_credito = request.getParameter("id_nota_credito");
        String codigos_articulos[] = ids_concatenados.split(",");
        String codigos_articulos_valores[];

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        NotaCreditoDetalleDTO notaCreditoDetalleDto = new NotaCreditoDetalleDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        NotaCreditoDetalleDAO notaCreditoDetalleDao = auditorFac.crearObjetoNotaCreditoDetalle();
        notaCreditoDetalleDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                System.out.println("INSERTAR");
                try {
                    cn.getConexion().setAutoCommit(false);
                    for (int indice = 0; indice < codigos_articulos.length; indice++) {
                        codigos_articulos_valores = codigos_articulos[indice].split(";");

                        notaCreditoDetalleDto.setId_stock(Integer.parseInt(codigos_articulos_valores[0]));
                        notaCreditoDetalleDto.setId_venta(Integer.parseInt(id_venta));
                        notaCreditoDetalleDto.setId_nota_credito(Integer.parseInt(id_nota_credito));
                        notaCreditoDetalleDto.setCantidad_nota_credito(Integer.parseInt(codigos_articulos_valores[1]));
                        notaCreditoDetalleDto.setMonto_nota_credito(Double.valueOf(codigos_articulos_valores[2]));
                        notaCreditoDetalleDto.setUsu_alta(usuario);

                        error = notaCreditoDetalleDao.insertar(notaCreditoDetalleDto);
                    }
                    cn.getConexion().commit();
                } catch (SQLException e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("NotaCreditoDetalleControl : " + error);
                    cn.getConexion().rollback();
                } catch (Exception e) {
                    error = "Error : No se selecciono ningun registro" + e.toString();
                    System.out.println("NotaCreditoDetalleControl : " + error);
                } finally {
                    cn.getConexion().setAutoCommit(true);
                }
                break;
           /* case 2:
                System.out.println("MODIFICAR");
                try {
                    cn.getConexion().setAutoCommit(false);
                    for (int indice = 0; indice < codigos_articulos.length; indice++) {
                        codigos_articulos_valores = codigos_articulos[indice].split(";");

                        notaCreditoDetalleDto.setId(Integer.parseInt(codigos_articulos_valores[0]));
                        notaCreditoDetalleDto.setMinimo(Double.valueOf(codigos_articulos_valores[1]));
                        notaCreditoDetalleDto.setMaximo(Double.valueOf(codigos_articulos_valores[2]));
                        notaCreditoDetalleDto.setUsu_modi(usuario);

                        error = notaCreditoDetalleDao.modificar(notaCreditoDetalleDto);
                    }
                    cn.getConexion().commit();
                } catch (SQLException e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("NotaCreditoDetalleControl : " + error);
                    cn.getConexion().rollback();
                } catch (Exception e) {
                    error = "Error : No se selecciono ningun registro" + e.toString();
                    System.out.println("NotaCreditoDetalleControl : " + error);
                } finally {
                    cn.getConexion().setAutoCommit(true);
                }
                break;*/
            case 3:
                System.out.println("BORRAR");
                try {
                    error = notaCreditoDetalleDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("NotaCreditoDetalleControl.java : " + error);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(NotaCreditoDetalleControl.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(NotaCreditoDetalleControl.class.getName()).log(Level.SEVERE, null, ex);
        }
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
