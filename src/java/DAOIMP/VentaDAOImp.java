/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.VentaDAO;
import DTO.VentaDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class VentaDAOImp implements VentaDAO {

    Connection cn;
    private String nombre_fichero = "[VentaDAOImp.java]";

    @Override
    public String insertar(VentaDTO ventaDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.ventas(\n"
                    + "            id_cliente, id_timbrado, id_cajero, id_caja, fecha_venta, \n"
                    + "            usu_alta, fec_alta, estado_venta, tipo_venta, cantidad_cuotas_ventas, fecha_vencimiento_primer_cuota_venta)\n"
                    + "    VALUES (?, ?, ?, ?, ?, \n"
                    + "            ?, now(), 0, ?, ?, ?);";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, ventaDto.getId_cliente());
            ps.setObject(2, ventaDto.getId_timbrado());
            ps.setObject(3, ventaDto.getId_cajero());
            ps.setObject(4, ventaDto.getId_caja());
            ps.setObject(5, ventaDto.getFecha_venta());
            ps.setObject(6, ventaDto.getUsu_alta());
            ps.setObject(7, ventaDto.getTipo_venta());
            ps.setObject(8, ventaDto.getCantidad_cuotas_ventas());
            ps.setObject(9, ventaDto.getFecha_vencimiento_primer_cuota_venta());

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
    public String modificar(VentaDTO ventaDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.ventas\n"
                    + "   SET id_cliente=?, id_cajero=?, id_caja=?, \n"
                    + "       usu_modi=?, id_timbrado=?, fec_modi=now(), tipo_venta=?, cantidad_cuotas_ventas=?, "
                    + " fecha_vencimiento_primer_cuota_venta=? \n"
                    + " WHERE id_venta=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, ventaDto.getId_cliente());
            ps.setObject(2, ventaDto.getId_cajero());
            ps.setObject(3, ventaDto.getId_caja());
            ps.setObject(4, ventaDto.getUsu_modi());
            ps.setObject(5, ventaDto.getId_timbrado());
            ps.setObject(6, ventaDto.getTipo_venta());
            ps.setObject(7, ventaDto.getCantidad_cuotas_ventas());
            ps.setObject(8, ventaDto.getFecha_vencimiento_primer_cuota_venta());
            ps.setObject(9, ventaDto.getId());

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
            String sql = " DELETE FROM stock_facturacion.ventas\n" + 
                    " WHERE id_venta = ?";
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
    public String registrarPagoVenta(VentaDTO ventaDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.ventas\n"
                    + "   SET id_tipo_pago=?, monto_pago=?, "
                    + "       usu_modi=?, nro_boleta_tarjeta=?, fec_modi=now()\n"
                    + " WHERE id_venta=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, ventaDto.getId_tipo_pago());
            ps.setObject(2, ventaDto.getMonto_pago());
            ps.setObject(3, ventaDto.getUsu_modi());
            ps.setObject(4, ventaDto.getNro_boleta_tarjeta());
            ps.setObject(5, ventaDto.getId());

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
    public String finiquitar(VentaDTO ventaDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.ventas\n"
                    + "   SET estado_venta=1, "
                    + "       usu_modi=?, fecha_venta=now(), numero_ticket_venta=?, nro_factura_venta=?, fec_modi=now()\n"
                    + " WHERE id_venta=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, ventaDto.getUsu_modi());
            ps.setObject(2, ventaDto.getNumero_ticket_venta());
            ps.setObject(3, ventaDto.getNumero_factura_venta());
            ps.setObject(4, ventaDto.getId());

            int resultado = ps.executeUpdate();
               System.out.println(ps.toString());
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String aplicarDescuentoVenta(VentaDTO ventaDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.ventas\n"
                    + "   SET descuento_aplicado=?, "
                    + "       usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_venta=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, ventaDto.getDescuento_venta());
            ps.setObject(2, ventaDto.getUsu_modi());
            ps.setObject(3, ventaDto.getId());

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
    public String anular(VentaDTO ventaDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.ventas\n"
                    + "   SET estado_venta=2, "
                    + "       usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_venta=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, ventaDto.getUsu_modi());
            ps.setObject(2, ventaDto.getId());

            int resultado = ps.executeUpdate();
            System.out.println(ps.toString());
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String actualizarNroFacturaVenta(VentaDTO ventaDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.ventas\n"
                    + "   SET nro_factura_venta=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_venta=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, ventaDto.getNumero_factura_venta());
            ps.setObject(2, ventaDto.getUsu_modi());
            ps.setObject(3, ventaDto.getId());

            int resultado = ps.executeUpdate();
               System.out.println(ps.toString());
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

}
