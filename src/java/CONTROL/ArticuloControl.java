 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.ArticuloDAO;
import DTO.ArticuloDTO;
import genericos.Conexion;
import genericos.FechaActual;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
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
public class ArticuloControl extends HttpServlet {

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
        String id_marca = request.getParameter("id_marca");
        String id_impuesto = request.getParameter("id_impuesto");
        String id_medida = request.getParameter("id_medida");
        String id_grupo = request.getParameter("id_grupo");
        String articulo_descripcion = request.getParameter("articulo_descripcion");
        String codigo_barra = request.getParameter("codigo_barra");
        String fecha_vencimiento = request.getParameter("fecha_vencimiento") == "" ? "01/01/2020" : request.getParameter("fecha_vencimiento") ;

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        ArticuloDTO articuloDto = new ArticuloDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        ArticuloDAO articuloDao = auditorFac.crearObjetoArticulo();
        articuloDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    articuloDto.setId_impuesto(Integer.parseInt(id_impuesto));
                    articuloDto.setId_marca(Integer.parseInt(id_marca));
                    articuloDto.setId_medida(Integer.parseInt(id_medida));
                    articuloDto.setId_grupo(Integer.parseInt(id_grupo));
                    articuloDto.setCodigo_barra(codigo_barra);
                    articuloDto.setArticulo_descripcion(articulo_descripcion);
                    articuloDto.setFecha_vencimiento(Date.valueOf(fecha.convertirDDMMYYYYaYYYYMMDD(fecha_vencimiento)));
                    articuloDto.setUsu_alta(usuario);

                    error = articuloDao.insertar(articuloDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ArticuloControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    articuloDto.setId_marca(Integer.parseInt(id_marca));
                    articuloDto.setId_medida(Integer.parseInt(id_medida));
                    articuloDto.setId_grupo(Integer.parseInt(id_grupo));
                    articuloDto.setCodigo_barra(codigo_barra);
                    articuloDto.setArticulo_descripcion(articulo_descripcion);
                    articuloDto.setFecha_vencimiento(Date.valueOf(fecha.convertirDDMMYYYYaYYYYMMDD(fecha_vencimiento)));
                    articuloDto.setId_impuesto(Integer.parseInt(id_impuesto));
                    articuloDto.setUsu_modi(usuario);
                    articuloDto.setId(Integer.parseInt(id));

                    error = articuloDao.modificar(articuloDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ArticuloControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = articuloDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ArticuloControl.java : " + error);
                }
                break;
            case 4:
                System.out.println("ACTUALIZAR COSTO ARTICULO");
                try {
                    
                    articuloDto.setUsu_modi(usuario);
                    articuloDto.setId(Integer.parseInt(id));
                    
                    error = articuloDao.actualizarCostoArticulo(articuloDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ArticuloControl.java : " + error);
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
