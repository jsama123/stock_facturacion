/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.AjustesStockDAO;
import DTO.AjustesStockDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author jose-samaniego
 */
public class AjustesStockDAOImp implements AjustesStockDAO {

    Connection cn;
    private String nombre_fichero = "[AjustesStockDAOImp.java]";

    @Override
    public String insertar(AjustesStockDTO ajustesDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.ajustes_stock(\n"
                    + "            id_stock, existencia, observacion, operacion, \n"
                    + "            cantidad, estado, usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, ?, ?, ?, ?, ?, \n"
                    + "            now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, ajustesDto.getId_stock());
            ps.setObject(2, ajustesDto.getExistencia());
            ps.setObject(3, ajustesDto.getObservacion());
            ps.setObject(4, ajustesDto.getOperacion());
            ps.setObject(5, ajustesDto.getCantidad());
            ps.setObject(6, ajustesDto.getEstado());
            ps.setObject(7, ajustesDto.getUsu_alta());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(AjustesStockDTO ajustesDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.ajustes_stock\n"
                    + "   SET id_stock=?, existencia=?, observacion=?, operacion=?, \n"
                    + "       cantidad=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_ajuste_stock=?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, ajustesDto.getId_stock());
            ps.setObject(2, ajustesDto.getExistencia());
            ps.setObject(3, ajustesDto.getObservacion());
            ps.setObject(4, ajustesDto.getOperacion());
            ps.setObject(5, ajustesDto.getCantidad());
            ps.setObject(6, ajustesDto.getUsu_modi());
            ps.setObject(7, ajustesDto.getId());

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
            String sql = "DELETE FROM stock_facturacion.ajustes_stock\n"
                    + " WHERE id_ajuste_stock = ?";
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
    public String procesar(AjustesStockDTO ajustesDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.ajustes_stock\n"
                    + "   SET estado=1, usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_ajuste_stock=?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, ajustesDto.getUsu_modi());
            ps.setObject(2, ajustesDto.getId());

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

    @Override
    public String anular(AjustesStockDTO ajustesStockDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.ajustes_stock\n"
                    + "   SET estado=2, usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_ajuste_stock=?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, ajustesStockDto.getUsu_modi());
            ps.setObject(2, ajustesStockDto.getId());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

}
