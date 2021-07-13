/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.EmpresaDAO;
import DTO.EmpresaDTO;
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
public class EmpresaControl extends HttpServlet {

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
        String ci_ruc_empresa = request.getParameter("ci_ruc_empresa");
        String razon_social_empresa = request.getParameter("razon_social_empresa");
        String nro_telefono_empresa = request.getParameter("nro_telefono_empresa");
        String direccion_empresa = request.getParameter("direccion_empresa");
        String email_empresa = request.getParameter("email_empresa");
        String actividad_economica = request.getParameter("actividad_economica");

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        EmpresaDTO empresaDto = new EmpresaDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        EmpresaDAO empresaDao = auditorFac.crearObjetoEmpresa();
        empresaDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    empresaDto.setActividad_economica(actividad_economica);
                    empresaDto.setCi_ruc_empresa(ci_ruc_empresa);
                    empresaDto.setRazon_social_empresa(razon_social_empresa);
                    empresaDto.setNro_telefono_provedor(nro_telefono_empresa);
                    empresaDto.setDireccion_empresa(direccion_empresa);
                    empresaDto.setEmail_empresa(email_empresa);
                    empresaDto.setUsu_alta(usuario);

                    error = empresaDao.insertar(empresaDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("EmpresaControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    empresaDto.setActividad_economica(actividad_economica); 
                    empresaDto.setCi_ruc_empresa(ci_ruc_empresa);
                    empresaDto.setRazon_social_empresa(razon_social_empresa);
                    empresaDto.setNro_telefono_provedor(nro_telefono_empresa);
                    empresaDto.setDireccion_empresa(direccion_empresa);
                    empresaDto.setEmail_empresa(email_empresa);
                    empresaDto.setUsu_modi(usuario);
                    empresaDto.setId(Integer.parseInt(id));

                    error = empresaDao.modificar(empresaDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("EmpresaControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = empresaDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("EmpresaControl.java : " + error);
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
