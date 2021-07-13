/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.VentaManualDAO;
import DTO.VentaManualDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class VentaManualDAOImp implements VentaManualDAO {

    Connection cn;
    private String nombre_fichero = "[VentaManualDAOImp.java]";

    @Override
    public String insertar(VentaManualDTO ventaDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.ventas_manual(\n"
                    + "            id_cliente, id_cajero, id_caja, fecha_venta, \n"
                    + "            usu_alta, fec_alta, nro_factura_venta, estado_venta)\n"
                    + "    VALUES (?, ?, ?, ?, \n"
                    + "            ?, now(), ?, 0);";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, ventaDto.getId_cliente());
            ps.setObject(2, ventaDto.getId_cajero());
            ps.setObject(3, ventaDto.getId_caja());
            ps.setObject(4, ventaDto.getFecha_venta());
            ps.setObject(5, ventaDto.getUsu_alta());
            ps.setObject(6, ventaDto.getNumero_factura_venta());

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
    public String modificar(VentaManualDTO ventaDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.ventas_manual\n"
                    + "   SET id_cliente=?, id_cajero=?, id_caja=?, \n"
                    + "       fecha_venta=?, usu_modi=?, nro_factura_venta=?, fec_modi=now()\n"
                    + " WHERE id_venta_manual=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, ventaDto.getId_cliente());
            ps.setObject(2, ventaDto.getId_cajero());
            ps.setObject(3, ventaDto.getId_caja());
            ps.setObject(4, ventaDto.getFecha_venta());
            ps.setObject(5, ventaDto.getUsu_modi());
            ps.setObject(6, ventaDto.getNumero_factura_venta());
            ps.setObject(7, ventaDto.getId());

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
            String sql = " DELETE FROM stock_facturacion.ventas_manual\n" + 
                    " WHERE id_venta_manual = ?";
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
    public String registrarPagoVentaManual(VentaManualDTO ventaDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.ventas_manual\n"
                    + "   SET id_tipo_pago=?, monto_pago=?, "
                    + "       usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_venta_manual=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, ventaDto.getId_tipo_pago());
            ps.setObject(2, ventaDto.getMonto_pago());
            ps.setObject(3, ventaDto.getUsu_modi());
            ps.setObject(4, ventaDto.getId());

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
    public String finiquitar(VentaManualDTO ventaDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.ventas_manual\n"
                    + "   SET estado_venta=1, "
                    + "       usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_venta_manual=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, ventaDto.getUsu_modi());
            ps.setObject(2, ventaDto.getId());

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
    public String aplicarDescuentoVentaManual(VentaManualDTO ventaDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.ventas_manual\n"
                    + "   SET descuento_aplicado=?, "
                    + "       usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_venta_manual=?";
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
    public String anular(VentaManualDTO ventaDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.ventas_manual\n"
                    + "   SET estado_venta=2, "
                    + "       usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_venta_manual=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, ventaDto.getUsu_modi());
            ps.setObject(2, ventaDto.getId());

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
