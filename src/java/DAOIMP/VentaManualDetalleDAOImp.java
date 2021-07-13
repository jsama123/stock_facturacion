/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.VentaManualDetalleDAO;
import DTO.VentaManualDetalleDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class VentaManualDetalleDAOImp implements VentaManualDetalleDAO {

    Connection cn;
    private String nombre_fichero = "[VentaManualDetalleDAOImp.java]";

    @Override
    public String insertar(VentaManualDetalleDTO ventaDetalleDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.ventas_manual_detalles(\n"
                    + "            id_venta_manual, cantidad_venta, precio_unitario, \n"
                    + "            usu_alta, fec_alta, id_stock, iva_aplicado, descuento_venta, es_desc_gs, descuento_gs_venta)\n"
                    + "    VALUES (?, ?, ?,\n"
                    + "            ?, now(), ?, ?, ?, ?, ?);";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, ventaDetalleDto.getId_venta());
            ps.setObject(2, ventaDetalleDto.getCantidad_venta());
            ps.setObject(3, ventaDetalleDto.getPrecio_unitario());
            ps.setObject(4, ventaDetalleDto.getUsu_alta());
            ps.setObject(5, ventaDetalleDto.getId_stock());
            ps.setObject(6, ventaDetalleDto.getIva_aplicado());
            ps.setObject(7, ventaDetalleDto.getDescuenta_venta());
            ps.setObject(8, ventaDetalleDto.isEs_desc_gs_venta());
            ps.setObject(9, ventaDetalleDto.getDescuento_gs_venta());

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
    public String modificar(VentaManualDetalleDTO ventaDetalleDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.ventas_manual_detalles\n"
                    + "   SET cantidad_venta=?, precio_unitario=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_venta_manual_detalle=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, ventaDetalleDto.getCantidad_venta());
            ps.setObject(2, ventaDetalleDto.getPrecio_unitario());
            ps.setObject(3, ventaDetalleDto.getUsu_modi());
            ps.setObject(4, ventaDetalleDto.getId_venta_detalle());

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
            String sql = " DELETE FROM stock_facturacion.ventas_manual_detalles\n"
                    + " WHERE id_venta_manual_detalle = ?";
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
