/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.ClienteDAO;
import DTO.ClienteDTO;
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
public class ClienteControl extends HttpServlet {

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
        String ci_ruc_cliente = request.getParameter("ci_ruc_cliente");
        String razon_social_cliente = request.getParameter("razon_social_cliente");
        String nro_telefono_cliente = request.getParameter("nro_telefono_cliente") == null ? "" : request.getParameter("nro_telefono_cliente") ;
        String direccion_cliente = request.getParameter("direccion_cliente") == null ? "" : request.getParameter("direccion_cliente") ;
        String email_cliente = request.getParameter("email_cliente") == null ? "" : request.getParameter("email_cliente");

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        ClienteDTO clienteDto = new ClienteDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        ClienteDAO clienteDao = auditorFac.crearObjetoCliente();
        clienteDao.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    clienteDto.setCi_ruc_cliente(ci_ruc_cliente);
                    clienteDto.setRazon_social_cliente(razon_social_cliente);
                    clienteDto.setNro_telefono_cliente(nro_telefono_cliente);
                    clienteDto.setDireccion_cliente(direccion_cliente);
                    clienteDto.setEmail_cliente(email_cliente);
                    clienteDto.setUsu_alta(usuario);

                    error = clienteDao.insertar(clienteDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ClienteControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    clienteDto.setCi_ruc_cliente(ci_ruc_cliente);
                    clienteDto.setRazon_social_cliente(razon_social_cliente);
                    clienteDto.setNro_telefono_cliente(nro_telefono_cliente);
                    clienteDto.setDireccion_cliente(direccion_cliente);
                    clienteDto.setEmail_cliente(email_cliente);
                    clienteDto.setUsu_modi(usuario);
                    clienteDto.setId(Integer.parseInt(id));

                    error = clienteDao.modificar(clienteDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ClienteControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = clienteDao.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ClienteControl.java : " + error);
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
