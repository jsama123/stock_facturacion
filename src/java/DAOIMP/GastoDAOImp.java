/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.GastoDAO;
import DTO.GastoDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class GastoDAOImp implements GastoDAO {

    public GastoDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[GastoDAOImp.java]";

    @Override
    public String insertar(GastoDTO gastoDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.gastos(\n"
                    + "            id_proveedor, concepto_gasto, nro_comprobante_gasto, \n"
                    + "            monto_gasto, tipo_gasto, iva_aplicado, cantidad_cuota_gasto, usu_alta, fecha_gasto,"
                    + " timbrado_gasto, fec_alta)\n"
                    + "    VALUES (?, ?, ?, \n"
                    + "            ?, ?, ?, ?, ?, ?, ?, now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, gastoDto.getId_proveedor());
            ps.setObject(2, gastoDto.getConcepto_gasto().toUpperCase());
            ps.setObject(3, gastoDto.getNro_comprobante_gasto());
            ps.setObject(4, gastoDto.getMonto_gasto());
            ps.setObject(5, gastoDto.getTipo_gasto());
            ps.setObject(6, gastoDto.getIva());
            ps.setObject(7, gastoDto.getCantidad_cuota_gasto());
            ps.setObject(8, gastoDto.getUsu_alta());
            ps.setObject(9, gastoDto.getFecha_gasto());
            ps.setObject(10, gastoDto.getTimbrado_gasto());
            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(GastoDTO gastoDTO) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.gastos\n"
                    + "   SET id_proveedor=?, concepto_gasto=?, nro_comprobante_gasto=?, \n"
                    + "       monto_gasto=?, tipo_gasto=?, iva_aplicado=?, cantidad_cuota_gasto=?, usu_modi=?, fecha_gasto=?,"
                    + " timbrado_gasto=?, fec_modi=now()\n"
                    + " WHERE id_gasto=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, gastoDTO.getId_proveedor());
            ps.setObject(2, gastoDTO.getConcepto_gasto().toUpperCase());
            ps.setObject(3, gastoDTO.getNro_comprobante_gasto());
            ps.setObject(4, gastoDTO.getMonto_gasto());
            ps.setObject(5, gastoDTO.getTipo_gasto());
            ps.setObject(6, gastoDTO.getIva());
            ps.setObject(7, gastoDTO.getCantidad_cuota_gasto());
            ps.setObject(8, gastoDTO.getUsu_modi());
            ps.setObject(9, gastoDTO.getFecha_gasto());
            ps.setObject(10, gastoDTO.getTimbrado_gasto());
            ps.setObject(11, gastoDTO.getId());
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
            String sql = " DELETE FROM stock_facturacion.gastos\n"
                    + " WHERE id_gasto = ? ";
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
