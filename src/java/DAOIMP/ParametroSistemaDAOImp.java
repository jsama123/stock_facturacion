/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.ParametroSistemaDAO;
import DTO.ParametrosSistemaDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class ParametroSistemaDAOImp implements ParametroSistemaDAO {

    Connection cn;
    private String nombre_fichero = "[ParametroSistemaDAOImp.java]";

    @Override
    public String insertar(ParametrosSistemaDTO parametroSystemDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.parametros_sistema(\n"
                    + "            garantia_venta, interes_moratorio_venta, timbrado_venta_manual, usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, ?, ?, now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, parametroSystemDto.getGarantia_venta());
            ps.setObject(2, parametroSystemDto.getInteres_moratorio_venta());
            ps.setObject(3, parametroSystemDto.getTimbrado_venta_manual());
            ps.setObject(4, parametroSystemDto.getUsu_alta());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(ParametrosSistemaDTO parametroSystemDto) {
        String error = "";
        try {
            String sql = "UPDATE stock_facturacion.parametros_sistema\n"
                    + "   SET garantia_venta=?, interes_moratorio_venta=?, timbrado_venta_manual=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_parametro_sistema=?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, parametroSystemDto.getGarantia_venta());
            ps.setObject(2, parametroSystemDto.getInteres_moratorio_venta());
            ps.setObject(3, parametroSystemDto.getTimbrado_venta_manual());
            ps.setObject(4, parametroSystemDto.getUsu_modi());
            ps.setObject(5, parametroSystemDto.getId());

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
            String sql = "DELETE FROM stock_facturacion.parametros_sistema\n"
                    + " WHERE id_parametro_sistema = ?";
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
