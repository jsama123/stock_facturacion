/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.VentaCreditoDAO;
import DTO.VentaCreditoDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class VentaCreditoDAOImp implements VentaCreditoDAO {

    public VentaCreditoDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[VentaCreditoDAOImp.java]";

    @Override
    public String insertar(VentaCreditoDTO ventaCreditoDto) {
        String error = "";
        try {
            String sql = "INSERT INTO stock_facturacion.ventas_credito_detalles(\n"
                    + "            id_venta, nro_cuota, monto_cuota, fecha_vencimiento_cuota, \n"
                    + "            estado_cuota, usu_alta, \n"
                    + "            fec_alta)\n"
                    + "    VALUES (?, ?, ?, ?, \n"
                    + "            0, ?, \n"
                    + "            now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, ventaCreditoDto.getId_venta());
            ps.setObject(2, ventaCreditoDto.getNro_cuota());
            ps.setObject(3, ventaCreditoDto.getMonto_cuota());
            ps.setObject(4, ventaCreditoDto.getFecha_vencimiento_cuota());
            ps.setObject(5, ventaCreditoDto.getUsu_alta());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(VentaCreditoDTO ventaCreditoDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.nota_creditos\n"
                    + "   SET id_cliente=?, concepto_nota_credito=?,\n"
                    + "       usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_nota_credito=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(3, ventaCreditoDto.getUsu_modi());
            ps.setObject(4, ventaCreditoDto.getId());

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
            String sql = " DELETE FROM stock_facturacion.nota_creditos\n"
                    + " WHERE id_nota_credito = ?";
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
