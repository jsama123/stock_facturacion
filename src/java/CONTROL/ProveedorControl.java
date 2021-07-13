/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.ProveedorDAO;
import DTO.ProveedorDTO;
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
public class ProveedorControl extends HttpServlet {

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
        String ci_ruc_proveedor = request.getParameter("ci_ruc_proveedor");
        String razon_social_proveedor = request.getParameter("razon_social_proveedor");
         String nro_telefono_proveedor = request.getParameter("nro_telefono_proveedor") == null ? "" : request.getParameter("nro_telefono_proveedor") ;
        String direccion_proveedor = request.getParameter("direccion_proveedor") == null ? "" : request.getParameter("direccion_proveedor") ;
        String email_proveedor = request.getParameter("email_proveedor") == null ? "" : request.getParameter("email_proveedor");

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        ProveedorDTO proveedorDto = new ProveedorDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        ProveedorDAO proveedorDao = auditorFac.crearObjetoProveedor();
        proveedorDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    proveedorDto.setCi_ruc_proveedor(ci_ruc_proveedor);
                    proveedorDto.setRazon_social_proveedor(razon_social_proveedor);
                    proveedorDto.setNro_telefono_provedor(nro_telefono_proveedor);
                    proveedorDto.setDireccion_proveedor(direccion_proveedor);
                    proveedorDto.setEmail_proveedor(email_proveedor);
                    proveedorDto.setUsu_alta(usuario);

                    error = proveedorDao.insertar(proveedorDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ProveedorControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    proveedorDto.setCi_ruc_proveedor(ci_ruc_proveedor);
                    proveedorDto.setRazon_social_proveedor(razon_social_proveedor);
                    proveedorDto.setNro_telefono_provedor(nro_telefono_proveedor);
                    proveedorDto.setDireccion_proveedor(direccion_proveedor);
                    proveedorDto.setEmail_proveedor(email_proveedor);
                    proveedorDto.setUsu_modi(usuario);
                    proveedorDto.setId(Integer.parseInt(id));

                    error = proveedorDao.modificar(proveedorDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ProveedorControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = proveedorDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ProveedorControl.java : " + error);
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
