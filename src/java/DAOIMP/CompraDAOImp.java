/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.CompraDAO;
import DTO.CompraDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class CompraDAOImp implements CompraDAO {

    Connection cn;
    private String nombre_fichero = "[CompraDAOImp.java]";

    @Override
    public String insertar(CompraDTO compraDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.compras(\n"
                    + "            id_proveedor, id_cajero, id_caja, fecha_compra, \n"
                    + "            usu_alta, fec_alta, nro_factura_compra,  estado_compra, tipo_compra, monto_entregado_compra, "
                    + "             fecha_vencimiento_cuota_compra, cantidad_cuota_compra, id_deposito, timbrado_compra)\n"
                    + "    VALUES (?, ?, ?, \n"
                    + "            ?, ?, now(), ?, 0, ?, ?, ?, ?, ?, ?);";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, compraDto.getId_proveedor());
            ps.setObject(2, compraDto.getId_cajero());
            ps.setObject(3, compraDto.getId_caja());
            ps.setObject(4, compraDto.getFecha_compra());
            ps.setObject(5, compraDto.getUsu_alta());
            ps.setObject(6, compraDto.getNumero_factura_compra());
            ps.setObject(7, compraDto.getTipo_compra());
            ps.setObject(8, compraDto.getMonto_entregado_compra());
            ps.setObject(9, compraDto.getFecha_vencimiento_cuota_compra());
            ps.setObject(10, compraDto.getCantidad_cuota_compra());
            ps.setObject(11, compraDto.getId_deposito());
            ps.setObject(12, compraDto.getTimbrado_compra());

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
    public String modificar(CompraDTO compraDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.compras\n"
                    + "   SET id_proveedor=?, id_cajero=?, id_caja=?, \n"
                    + "       fecha_compra=?, usu_modi=?, nro_factura_compra=?, "
                    + " tipo_compra=?, monto_entregado_compra=?, "
                    + " fecha_vencimiento_cuota_compra=?, cantidad_cuota_compra=?, id_deposito=?, timbrado_compra=?, fec_modi=now()\n"
                    + " WHERE id_compra=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, compraDto.getId_proveedor());
            ps.setObject(2, compraDto.getId_cajero());
            ps.setObject(3, compraDto.getId_caja());
            ps.setObject(4, compraDto.getFecha_compra());
            ps.setObject(5, compraDto.getUsu_modi());
            ps.setObject(6, compraDto.getNumero_factura_compra());
            ps.setObject(7, compraDto.getTipo_compra());
            ps.setObject(8, compraDto.getMonto_entregado_compra());
            ps.setObject(9, compraDto.getFecha_vencimiento_cuota_compra());
            ps.setObject(10, compraDto.getCantidad_cuota_compra());
            ps.setObject(11, compraDto.getId_deposito());
            ps.setObject(12, compraDto.getTimbrado_compra());
            ps.setObject(13, compraDto.getId());

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
            String sql = " DELETE FROM stock_facturacion.compras\n" + 
                    " WHERE id_compra = ?";
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

    @Override
    public String finiquitar(CompraDTO compraDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.compras\n"
                    + "   SET estado_compra=1, "
                    + "       usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_compra=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, compraDto.getUsu_modi());
            ps.setObject(2, compraDto.getId());

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
    public String aplicarDescuentoCompra(CompraDTO compraDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.compras\n"
                    + "   SET descuento_aplicado=?, "
                    + "       usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_compra=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, compraDto.getDescuento_compra());
            ps.setObject(2, compraDto.getUsu_modi());
            ps.setObject(3, compraDto.getId());

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
    public String anular(CompraDTO compraDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.compras\n"
                    + "   SET estado_compra=2, "
                    + "       usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_compra=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, compraDto.getUsu_modi());
            ps.setObject(2, compraDto.getId());

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
    public String ajustarMontoTotalCompra(CompraDTO compraDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.compras\n"
                    + "   SET monto_total_compra=?, "
                    + "       usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_compra=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, compraDto.getMonto_total_compra());
            ps.setObject(2, compraDto.getUsu_modi());
            ps.setObject(3, compraDto.getId());

            int resultado = ps.executeUpdate();
            //System.out.println(ps.toString());
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

}
