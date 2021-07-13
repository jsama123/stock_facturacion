/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.ProveedorDAO;
import DTO.ProveedorDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class ProveedorDAOImp implements ProveedorDAO {

    public ProveedorDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[ProveedorDAOImp.java]";

    @Override
    public String insertar(ProveedorDTO proveedorDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.proveedores(\n"
                    + "            ci_ruc_proveedor, razon_social_proveedor, nro_telefono_proveedor, \n"
                    + "            direccion_proveedor, email_proveedor, usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, ?, \n"
                    + "            ?, ?, ?, now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, proveedorDto.getCi_ruc_proveedor());
            ps.setObject(2, proveedorDto.getRazon_social_proveedor().toUpperCase());
            ps.setObject(3, proveedorDto.getNro_telefono_provedor());
            ps.setObject(4, proveedorDto.getDireccion_proveedor().toUpperCase());
            ps.setObject(5, proveedorDto.getEmail_proveedor().toUpperCase());
            ps.setObject(6, proveedorDto.getUsu_alta());
            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(ProveedorDTO proveedorDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.proveedores\n"
                    + "   SET ci_ruc_proveedor=?, razon_social_proveedor=?, nro_telefono_proveedor=?, \n"
                    + "       direccion_proveedor=?, email_proveedor=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_proveedor = ?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, proveedorDto.getCi_ruc_proveedor());
            ps.setObject(2, proveedorDto.getRazon_social_proveedor().toUpperCase());
            ps.setObject(3, proveedorDto.getNro_telefono_provedor().toUpperCase());
            ps.setObject(4, proveedorDto.getDireccion_proveedor());
            ps.setObject(5, proveedorDto.getEmail_proveedor().toUpperCase());
            ps.setObject(6, proveedorDto.getUsu_modi());
            ps.setObject(7, proveedorDto.getId());

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
            String sql = " DELETE FROM stock_facturacion.proveedores\n"
                    + " WHERE id_proveedor = ?;";
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
