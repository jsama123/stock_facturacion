/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.TraspasoDetalleDAO;
import DTO.TraspasoDetalleDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author jose-samaniego
 */
public class TraspasoDetalleDAOImp implements TraspasoDetalleDAO {

    Connection cn;
    private String nombre_fichero = "[TraspasoDetalleDAOImp.java]";

    @Override
    public String insertar(TraspasoDetalleDTO traspasoDetalleDto) {
        String error = "";
        try {
            String sql = "INSERT INTO stock_facturacion.traspasos_detalles(\n"
                    + "            id_traspaso, id_stock, cantidad, usu_alta, \n"
                    + "            fec_alta)\n"
                    + "    VALUES (?, ?, ?, ?, \n"
                    + "            now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, traspasoDetalleDto.getId_traspaso());
            ps.setObject(2, traspasoDetalleDto.getId_stock());
            ps.setObject(3, traspasoDetalleDto.getCantidad());
            ps.setObject(4, traspasoDetalleDto.getUsu_alta());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(TraspasoDetalleDTO traspasoDetalleDto) {
        String error = "";
        try {
            String sql = "UPDATE stock_facturacion.traspasos_detalles\n"
                    + "   SET id_stock=?, cantidad=?, usu_modi=?, fec_modi=?\n"
                    + " WHERE id_traspaso_detalle=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, traspasoDetalleDto.getId_stock());
            ps.setObject(2, traspasoDetalleDto.getCantidad());
            ps.setObject(3, traspasoDetalleDto.getUsu_modi());
            ps.setObject(4, traspasoDetalleDto.getId());

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
            String sql = "DELETE FROM stock_facturacion.traspasos_detalles\n"
                    + " WHERE id_traspaso_detalle = ?";
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
