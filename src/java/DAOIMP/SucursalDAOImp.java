/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.SucursalDAO;
import DTO.SucursalDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class SucursalDAOImp implements SucursalDAO {

    public SucursalDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[SucursalDAOImp.java]";

    @Override
    public String insertar(SucursalDTO sucursalDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.sucursales(\n"
                    + "            nro_sucursal, descripcion_sucursal, direccion_sucursal, telefono_sucursal, \n"
                    + "            usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, ?, ?, \n"
                    + "            ?, now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, sucursalDto.getNro_sucursal());
            ps.setObject(2, sucursalDto.getDescripcion_sucursal().toUpperCase());
            ps.setObject(3, sucursalDto.getDireccion_sucursal().toUpperCase());
            ps.setObject(4, sucursalDto.getTelefono_sucursal());
            ps.setObject(5, sucursalDto.getUsu_alta());

            int resultado = ps.executeUpdate();
            //System.out.println(ps.toString());
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(SucursalDTO sucursalDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.sucursales\n"
                    + "   SET nro_sucursal=?, descripcion_sucursal=?, direccion_sucursal=?, \n"
                    + "       telefono_sucursal=?,  usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_sucursal=?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, sucursalDto.getNro_sucursal());
            ps.setObject(2, sucursalDto.getDescripcion_sucursal().toUpperCase());
            ps.setObject(3, sucursalDto.getDireccion_sucursal().toUpperCase());
            ps.setObject(4, sucursalDto.getTelefono_sucursal());
            ps.setObject(5, sucursalDto.getUsu_modi());
            ps.setObject(6, sucursalDto.getId());

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
            String sql = " DELETE FROM stock_facturacion.sucursales\n"
                    + " WHERE id_sucursal = ?;";
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
