/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.EmpresaDAO;
import DTO.EmpresaDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class EmpresaDAOImp implements EmpresaDAO {

    public EmpresaDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[EmpresaDAOImp.java]";

    @Override
    public String insertar(EmpresaDTO empresaDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.empresas(\n"
                    + "            actividad_economica, ci_ruc_empresa, razon_social_empresa, nro_telefono_empresa, \n"
                    + "            direccion_empresa, email_empresa, usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, ?, ?, \n"
                    + "            ?, ?, ?, now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, empresaDto.getActividad_economica().toUpperCase());
            ps.setObject(2, empresaDto.getCi_ruc_empresa());
            ps.setObject(3, empresaDto.getRazon_social_empresa().toUpperCase());
            ps.setObject(4, empresaDto.getNro_telefono_provedor());
            ps.setObject(5, empresaDto.getDireccion_empresa().toUpperCase());
            ps.setObject(6, empresaDto.getEmail_empresa().toUpperCase());
            ps.setObject(7, empresaDto.getUsu_alta());
            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(EmpresaDTO empresaDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.empresas\n"
                    + "   SET actividad_economica=?, ci_ruc_empresa=?, razon_social_empresa=?, nro_telefono_empresa=?, \n"
                    + "       direccion_empresa=?, email_empresa=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_empresa = ?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, empresaDto.getActividad_economica().toUpperCase());
            ps.setObject(2, empresaDto.getCi_ruc_empresa());
            ps.setObject(3, empresaDto.getRazon_social_empresa().toUpperCase());
            ps.setObject(4, empresaDto.getNro_telefono_provedor().toUpperCase());
            ps.setObject(5, empresaDto.getDireccion_empresa());
            ps.setObject(6, empresaDto.getEmail_empresa().toUpperCase());
            ps.setObject(7, empresaDto.getUsu_modi());
            ps.setObject(8, empresaDto.getId());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String eliminar(Integer id) {
        String error = "";
        try {
            String sql = " DELETE FROM stock_facturacion.empresas\n"
                    + " WHERE id_empresa = ?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, id);

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public void crearConexion(Connection cn) {
        this.cn = cn;
    }

}
