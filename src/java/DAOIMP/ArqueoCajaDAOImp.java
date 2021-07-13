/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.ArqueoCajaDAO;
import DTO.ArqueoCajaDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class ArqueoCajaDAOImp implements ArqueoCajaDAO {

    Connection cn;
    private String nombre_fichero = "[ArqueoCajaDAOImp.java]";

    @Override
    public String insertar(ArqueoCajaDTO arqueoCajaDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.arqueo_caja(\n"
                    + "            id_cajero, id_caja, fecha_inicio_arqueo_caja, \n"
                    + "            saldo_inicial_arqueo_caja, estado_arqueo_caja, usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, ?, \n"
                    + "            ?, ?, ?, now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, arqueoCajaDto.getId_cajero());
            ps.setObject(2, arqueoCajaDto.getId_caja());
            ps.setObject(3, arqueoCajaDto.getFecha_inicio());
            ps.setObject(4, arqueoCajaDto.getSaldo_inicial_arqueo_caja());
            ps.setObject(5, arqueoCajaDto.getEstado_arqueo_caja());
            ps.setObject(6, arqueoCajaDto.getUsu_alta());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(ArqueoCajaDTO arqueoCajaDTO) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.arqueo_caja\n"
                    + "   SET id_cajero=?, saldo_inicial_arqueo_caja=?, id_caja=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_arqueo_caja=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, arqueoCajaDTO.getId_cajero());
            ps.setObject(2, arqueoCajaDTO.getSaldo_inicial_arqueo_caja());
            ps.setObject(3, arqueoCajaDTO.getId_caja());
            ps.setObject(4, arqueoCajaDTO.getUsu_modi());
            ps.setObject(5, arqueoCajaDTO.getId());

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
            String sql = " DELETE FROM stock_facturacion.arqueo_caja\n"
                    + " WHERE id_arqueo_caja = ?;";
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

    @Override
    public String cerrarCaja(ArqueoCajaDTO arqueoCajaDTO) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.arqueo_caja\n"
                    + "   SET fecha_fin_arqueo_caja=?, estado_arqueo_caja=?, \n"
                    + "       resultado_arqueo_caja=?, observacion_arqueo_caja=?, usu_modi=?, fec_modi=now(), total_arqueo_caja=?\n"
                    + " WHERE id_arqueo_caja=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, arqueoCajaDTO.getFecha_fin());
            ps.setObject(2, arqueoCajaDTO.getEstado_arqueo_caja());
            ps.setObject(3, arqueoCajaDTO.getResultado_arqueo_caja());
            ps.setObject(4, arqueoCajaDTO.getObservacion_arqueo_caja());
            ps.setObject(5, arqueoCajaDTO.getUsu_modi());
            ps.setObject(6, arqueoCajaDTO.getTotal_arqueo_caja());
            ps.setObject(7, arqueoCajaDTO.getId());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

}
