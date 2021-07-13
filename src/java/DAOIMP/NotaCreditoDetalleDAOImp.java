/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.NotaCreditoDetalleDAO;
import DTO.NotaCreditoDetalleDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * // * @author Jose Samaniego
 */
public class NotaCreditoDetalleDAOImp implements NotaCreditoDetalleDAO {

    public NotaCreditoDetalleDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[NotaCreditoDetalleDAOImp.java]";

    @Override
    public String insertar(NotaCreditoDetalleDTO notaCreditoDetalleDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.nota_creditos_detalle(\n"
                    + "            id_nota_credito, id_stock, id_venta, \n"
                    + "            monto_nota_credito, usu_alta, fec_alta, cantidad_nota_credito)\n"
                    + "    VALUES (?, ?, ?, \n"
                    + "            ?, ?, now(), ?);";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, notaCreditoDetalleDto.getId_nota_credito());
            ps.setObject(2, notaCreditoDetalleDto.getId_stock());
            ps.setObject(3, notaCreditoDetalleDto.getId_venta());
            ps.setObject(4, notaCreditoDetalleDto.getMonto_nota_credito());
            ps.setObject(5, notaCreditoDetalleDto.getUsu_alta());
            ps.setObject(6, notaCreditoDetalleDto.getCantidad_nota_credito());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(NotaCreditoDetalleDTO notaCreditoDetalleDto) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String eliminar(Integer id) {
        String error = "";
        try {
            String sql = " DELETE FROM stock_facturacion.nota_creditos_detalle\n"
                    + " WHERE id_nota_credito_detalle = ?;";
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
