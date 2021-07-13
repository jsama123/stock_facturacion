/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.CompraDetalleDAO;
import DTO.CompraDetalleDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class CompraDetalleDAOImp implements CompraDetalleDAO {

    Connection cn;
    private String nombre_fichero = "[CompraDetalleDAOImp.java]";

    @Override
    public String insertar(CompraDetalleDTO compraDetalleDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.compras_detalles(\n"
                    + "            id_compra, cantidad_compra, costo_unitario, \n"
                    + "            usu_alta, fec_alta, id_stock, iva_aplicado)\n"
                    + "    VALUES (?, ?, ?,\n"
                    + "            ?, now(), ?, ?);";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, compraDetalleDto.getId_compra());
            ps.setObject(2, compraDetalleDto.getCantidad_compra());
            ps.setObject(3, compraDetalleDto.getPrecio_unitario());
            ps.setObject(4, compraDetalleDto.getUsu_alta());
            ps.setObject(5, compraDetalleDto.getId_stock());
            ps.setObject(6, compraDetalleDto.getIva_aplicado());

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
    public String modificar(CompraDetalleDTO compraDetalleDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.compras_detalles\n"
                    + "   SET cantidad_compra=?, costo_unitario=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_compra_detalle=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, compraDetalleDto.getCantidad_compra());
            ps.setObject(2, compraDetalleDto.getPrecio_unitario());
            ps.setObject(3, compraDetalleDto.getUsu_modi());
            ps.setObject(4, compraDetalleDto.getId_compra_detalle());

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
            String sql = " DELETE FROM stock_facturacion.compras_detalles\n"
                    + " WHERE id_compra_detalle = ?";
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
