/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.ParametroCuotaVentaDAO;
import DTO.ParametroCuotaVentaDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class ParametroCuotaVentaDAOImp implements ParametroCuotaVentaDAO {

    Connection cn;
    private String nombre_fichero = "[ParametroCuotaVentaDAOImp.java]";

    @Override
    public String insertar(ParametroCuotaVentaDTO parametroSystemDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.parametros_cuotas_ventas(\n"
                    + "            cantidad_cuota, interes_mensual, usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, ?, now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, parametroSystemDto.getCantidad_cuota());
            ps.setObject(2, parametroSystemDto.getInteres_mensual());
            ps.setObject(3, parametroSystemDto.getUsu_alta());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(ParametroCuotaVentaDTO parametroSystemDto) {
        String error = "";
        try {
            String sql = "UPDATE stock_facturacion.parametros_cuotas_ventas\n"
                    + "   SET cantidad_cuota=?, interes_mensual=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_parametro_cuota_venta=?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, parametroSystemDto.getCantidad_cuota());
            ps.setObject(2, parametroSystemDto.getInteres_mensual());
            ps.setObject(3, parametroSystemDto.getUsu_modi());
            ps.setObject(4, parametroSystemDto.getId());

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
            String sql = "DELETE FROM stock_facturacion.parametros_cuotas_ventas\n"
                    + " WHERE id_parametro_cuota_venta = ?";
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
