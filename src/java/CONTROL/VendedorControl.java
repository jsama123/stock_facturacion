/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.VendedorDAO;
import DTO.VendedorDTO;
import genericos.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Jose Samaniego
 */
public class VendedorControl extends HttpServlet {

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
        String nombre_apellido_vendedor = request.getParameter("nombre_apellido_vendedor");
        String ci_vendedor = request.getParameter("ci_vendedor");
        String observaciones_vendedor = request.getParameter("observaciones_vendedor");

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        VendedorDTO vendedorDto = new VendedorDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        VendedorDAO vendedorDao = auditorFac.crearObjetoVendedor();
        vendedorDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    vendedorDto.setNombre_apellido_vendedor(nombre_apellido_vendedor);
                    vendedorDto.setCi_vendedor(ci_vendedor);
                    vendedorDto.setObservaciones_vendedor(observaciones_vendedor);
                    vendedorDto.setUsu_alta(usuario);

                    error = vendedorDao.insertar(vendedorDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("VendedorControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    vendedorDto.setNombre_apellido_vendedor(nombre_apellido_vendedor);
                    vendedorDto.setCi_vendedor(ci_vendedor);
                    vendedorDto.setObservaciones_vendedor(observaciones_vendedor);
                    vendedorDto.setUsu_modi(usuario);
                    vendedorDto.setId(Integer.parseInt(id));

                    error = vendedorDao.modificar(vendedorDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("VendedorControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = vendedorDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("VendedorControl.java : " + error);
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
