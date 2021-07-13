/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.StockDAO;
import DAO.TraspasoDAO;
import DTO.StockDTO;
import DTO.TraspasoDTO;
import genericos.Conexion;
import genericos.fuenteDatos;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
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
 * @author jose-samaniego
 */
public class TraspasoAprobacionControl extends HttpServlet {

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
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String accion = request.getParameter("opcion");
        Conexion cn = new Conexion();

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        String id = request.getParameter("id");

        TraspasoDTO traspasoDto = new TraspasoDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        TraspasoDAO traspasoDao = auditorFac.crearObjetoTraspaso();
        traspasoDao.crearConexion(cn.getConexion());

        StockDTO stockDto = new StockDTO();
        StockDAO stockDao = auditorFac.crearObjetoStock();
        stockDao.crearConexion(cn.getConexion());

        ResultSet rs = null;
        ResultSet rs1 = null;
        fuenteDatos dataSource = new fuenteDatos();
        dataSource.setConexion(cn.getConexion());

        rs = dataSource.obtenerDato(""
                + " SELECT "
                + " td.id_traspaso_detalle, "//1
                + " td.id_stock, "//2
                + " s.id_articulo, "//3
                + " td.cantidad, "//4
                + " t.id_deposito_origen, "//5
                + " t.id_deposito_destino "//6
                + " FROM stock_facturacion.traspasos_detalles td  "
                + " LEFT JOIN stock_facturacion.traspasos t on t.id_traspaso = td.id_traspaso "
                + " LEFT JOIN stock_facturacion.stocks s on s.id_stock = td.id_stock "
                + " WHERE t.id_traspaso = " + id);

        try {
            System.out.println("APROBANDO TRASPASO");
            cn.getConexion().setAutoCommit(false);

            traspasoDto.setId(Integer.parseInt(id));
            traspasoDto.setUsu_modi(usuario);

            error = traspasoDao.aprobar(traspasoDto);
            System.out.println("TRASPASO APROBADO");
            while (rs.next()) {
                //ACTUALIZAR DEPOSITO ORIGEN
                stockDto.setId(Integer.parseInt(rs.getString(2)));
                stockDto.setExistencia(Double.valueOf(rs.getString(4)));
                stockDto.setUsu_modi(usuario);
                error = stockDao.actualizarStockOrigenTraspasoOrigen(stockDto);
                System.out.println("ACTUALIZADO STOCK TRASPASO ORIGEN");

                //ACTUALIZAR/INSERTAR DEPOSITO DESTINO
                rs1 = dataSource.obtenerDato(""
                        + " SELECT "
                        + " s.id_stock "
                        + " FROM "
                        + " stock_facturacion.stocks s  "
                        + " WHERE "
                        + " s.id_articulo = " + rs.getString(3) + " AND "
                        + " s.id_deposito_sucursal=" + rs.getString(6));
                if (rs1.next()) {
                    stockDto.setId(Integer.parseInt(rs1.getString(1)));
                    stockDto.setExistencia(Double.valueOf(rs.getString(4)));
                    stockDto.setUsu_modi(usuario);
                    error = stockDao.actualizarStockOrigenTraspasoDestino(stockDto);
                    System.out.println("ACTUALIZADO STOCK TRASPASO DESTINO");
                } else {
                    stockDto.setId_articulo(Integer.parseInt(rs.getString(3)));
                    stockDto.setId_deposito_sucursal(Integer.parseInt(rs.getString(6)));
                    stockDto.setExistencia(Double.valueOf(rs.getString(4)));
                    stockDto.setUsu_alta(usuario);
                    error = stockDao.insertarStockTraspasoDestino(stockDto);
                    System.out.println("INSERTADO STOCK TRASPASO DESTINO");
                }
            }
            cn.getConexion().commit();
        } catch (SQLException sqlExc) {
            error = "Error: " + sqlExc.getMessage();
            System.out.print("TraspasoAprobacionControl" + " - " + error);
            cn.getConexion().rollback();
        } catch (Exception e) {
            error = "Error: No se selecciono ningun registro " + e.toString();
            System.out.print("TraspasoAprobacionControl" + " - " + error);
        } finally {
            cn.getConexion().setAutoCommit(true);
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
        } catch (Exception ex) {
            Logger.getLogger(TraspasoAprobacionControl.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (Exception ex) {
            Logger.getLogger(TraspasoAprobacionControl.class.getName()).log(Level.SEVERE, null, ex);
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
