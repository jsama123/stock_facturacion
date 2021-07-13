 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.ParametroSistemaDAO;
import DTO.ParametrosSistemaDTO;
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
public class ParametroSistemaControl extends HttpServlet {

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
        String garantia_venta = request.getParameter("garantia_venta") == "" ? "0" : request.getParameter("garantia_venta");
        String interes_moratorio_venta = request.getParameter("interes_moratorio_venta") == "" ? "0" : request.getParameter("interes_moratorio_venta");
        String timbrado_venta_manual = request.getParameter("timbrado_venta_manual");

        HttpSession sesion = request.getSession();
        String usuario = (String) sesion.getAttribute("loginUsuario");
        String error = "";

        ParametrosSistemaDTO parametroSystemDto = new ParametrosSistemaDTO();
        factoryControlObjetos auditorFac = new factoryControlObjetos();
        ParametroSistemaDAO parametroSystemDAO = auditorFac.crearObjetoParametroSistema();
        parametroSystemDAO.crearConexion(cn.getConexion());

        switch (Integer.parseInt(accion)) {
            case 1:
                try {
                    System.out.println("INSERTAR");

                    parametroSystemDto.setGarantia_venta(Integer.parseInt(garantia_venta));
                    parametroSystemDto.setInteres_moratorio_venta(Integer.parseInt(interes_moratorio_venta));
                    parametroSystemDto.setTimbrado_venta_manual(timbrado_venta_manual);
                    parametroSystemDto.setUsu_alta(usuario);

                    error = parametroSystemDAO.insertar(parametroSystemDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ParametroSistemaControl.java : " + error);
                }
                break;
            case 2:
                try {
                    System.out.println("MODIFICAR");

                    parametroSystemDto.setGarantia_venta(Integer.parseInt(garantia_venta));
                    parametroSystemDto.setInteres_moratorio_venta(Integer.parseInt(interes_moratorio_venta));
                    parametroSystemDto.setTimbrado_venta_manual(timbrado_venta_manual);
                    parametroSystemDto.setUsu_modi(usuario);
                    parametroSystemDto.setId(Integer.parseInt(id));

                    error = parametroSystemDAO.modificar(parametroSystemDto);
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ParametroSistemaControl.java : " + error);
                }
                break;
            case 3:
                System.out.println("BORRAR");
                try {
                    error = parametroSystemDAO.eliminar(Integer.parseInt(id));
                } catch (Exception e) {
                    error = "Error : " + e.getMessage();
                    System.out.println("ParametroSistemaControl.java : " + error);
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
