/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.CajaDAO;
import DTO.CajaDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class CajaDAOImp implements CajaDAO {

    public CajaDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[CajaDAOImp.java]";

    @Override
    public String insertar(CajaDTO cajaDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.cajas(\n"
                    + "            nro_caja, descripcion_caja, usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, ?, now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, cajaDto.getNro_caja());
            ps.setObject(2, cajaDto.getDescripcion_caja().toUpperCase());
            ps.setObject(3, cajaDto.getUsu_alta());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(CajaDTO cajaDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.cajas\n"
                    + "   SET nro_caja = ?, descripcion_caja=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_caja = ?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, cajaDto.getNro_caja());
            ps.setObject(2, cajaDto.getDescripcion_caja().toUpperCase());
            ps.setObject(3, cajaDto.getUsu_modi());
            ps.setObject(4, cajaDto.getId());
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
            String sql = " DELETE FROM stock_facturacion.cajas\n"
                    + " WHERE id_caja = ?;";
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
