/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.CompraCreditoDAO;
import DTO.CompraCreditoDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class CompraCreditoDAOImp implements CompraCreditoDAO {

    Connection cn;
    private String nombre_fichero = "[CompraCreditoDAOImp.java]";

    @Override
    public String insertar(CompraCreditoDTO compraCreditoDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.cuotas_compras_credito(\n"
                    + "            id_compra, fecha_pago_cuota, nro_comprobante_pago_cuota, monto_pagado_cuota, \n"
                    + "            id_tipo_comprobante, usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, ?, ?, \n"
                    + "            ?, ?, now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, compraCreditoDto.getId_compra());
            ps.setObject(2, compraCreditoDto.getFecha_pago_cuota());
            ps.setObject(3, compraCreditoDto.getNro_comprobante_pago_cuota());
            ps.setObject(4, compraCreditoDto.getMonto_pagado_cuota());
            ps.setObject(5, compraCreditoDto.getId_tipo_comprobante());
            ps.setObject(6, compraCreditoDto.getUsu_alta());

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
    public String modificar(CompraCreditoDTO compraCreditoDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.cuotas_compras_credito\n"
                    + "   SET fecha_pago_cuota=?, nro_comprobante_pago_cuota=?, monto_pagado_cuota=?, \n"
                    + "       id_tipo_comprobante=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_cuota_compra_credito=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, compraCreditoDto.getFecha_pago_cuota());
            ps.setObject(2, compraCreditoDto.getNro_comprobante_pago_cuota());
            ps.setObject(3, compraCreditoDto.getMonto_pagado_cuota());
            ps.setObject(4, compraCreditoDto.getId_tipo_comprobante());
            ps.setObject(5, compraCreditoDto.getUsu_modi());
            ps.setObject(6, compraCreditoDto.getId());

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
    public String eliminar(Integer id) {
        String error = "";
        try {
            String sql = " DELETE FROM stock_facturacion.cuotas_compras_credito\n"
                    + " WHERE id_cuota_compra_credito = ? ";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, id);

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
    public void crearConexion(Connection cn) {
        this.cn = cn;
    }

}
