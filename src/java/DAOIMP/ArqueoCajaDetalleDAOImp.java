/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.ArqueoCajaDetalleDAO;
import DTO.ArqueoCajaDetalleDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class ArqueoCajaDetalleDAOImp implements ArqueoCajaDetalleDAO {

    Connection cn;
    private String nombre_fichero = "[ArqueoCajaDetalleDetalleDAOImp.java]";

    @Override
    public String insertar(ArqueoCajaDetalleDTO arqueoCajaDetalleDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.arqueo_caja_detalle(\n"
                    + "            id_arqueo_caja, cantidad, denominacion, \n"
                    + "            usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, ?, ?, \n"
                    + "            now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, arqueoCajaDetalleDto.getId_arqueo_caja());
            ps.setObject(2, arqueoCajaDetalleDto.getCantidad());
            ps.setObject(3, arqueoCajaDetalleDto.getDenominacion());
            ps.setObject(4, arqueoCajaDetalleDto.getUsu_alta());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(ArqueoCajaDetalleDTO arqueoCajaDetalleDTO) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.arqueo_caja_detalle\n"
                    + "   SET  cantidad=?, denominacion=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_arqueo_caja_detalle=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, arqueoCajaDetalleDTO.getCantidad());
            ps.setObject(2, arqueoCajaDetalleDTO.getDenominacion());
            ps.setObject(3, arqueoCajaDetalleDTO.getUsu_modi());
            ps.setObject(4, arqueoCajaDetalleDTO.getId());

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
            String sql = " DELETE FROM stock_facturacion.arqueo_caja_detalle\n"
                    + " WHERE id_arqueo_caja_detalle = ?";
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
