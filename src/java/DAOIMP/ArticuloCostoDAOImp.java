/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.ArticuloCostoDAO;
import DTO.ArticuloCostoDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author jose-samaniego
 */
public class ArticuloCostoDAOImp implements ArticuloCostoDAO {

    Connection cn;
    private String nombre_fichero = "[ArticuloCostoDAOImp.java]";

    public ArticuloCostoDAOImp() {
    }

    @Override
    public String insertar(ArticuloCostoDTO articuloCostoDto) {
        String error = "";
        try {
            String sql = "INSERT INTO stock_facturacion.articulo_costos(\n"
                    + "            id_articulo, costo_compra, costo_venta, usu_alta, \n"
                    + "            fec_alta)\n"
                    + "    VALUES (?, ?, ?, ?, \n"
                    + "            now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, articuloCostoDto.getId_articulo());
            ps.setObject(2, articuloCostoDto.getCosto_compra());
            ps.setObject(3, articuloCostoDto.getCosto_venta());
            ps.setObject(4, articuloCostoDto.getUsu_alta());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(ArticuloCostoDTO articuloCostoDTO) {
        String error = "";
        try {
            String sql = "UPDATE stock_facturacion.articulo_costos\n"
                    + "   SET costo_compra=?, costo_venta=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_articulo_costo=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, articuloCostoDTO.getCosto_compra());
            ps.setObject(2, articuloCostoDTO.getCosto_venta());
            ps.setObject(3, articuloCostoDTO.getUsu_modi());
            ps.setObject(4, articuloCostoDTO.getId());

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
            String sql = "DELETE FROM stock_facturacion.articulo_costos\n"
                    + " WHERE id_articulo_costo = ?";
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
