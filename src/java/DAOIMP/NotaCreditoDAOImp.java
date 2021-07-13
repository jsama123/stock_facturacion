/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.NotaCreditoDAO;
import DTO.NotaCreditoDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class NotaCreditoDAOImp implements NotaCreditoDAO {

    public NotaCreditoDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[NotaCreditoDAOImp.java]";

    @Override
    public String insertar(NotaCreditoDTO notaCreditoDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.nota_creditos(\n"
                    + "            id_cliente, concepto_nota_credito, fecha_nota_credito, \n"
                    + "            usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, ?, \n"
                    + "            ?, now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, notaCreditoDto.getId_cliente());
            ps.setObject(2, notaCreditoDto.getConcepto_nota_credito());
            ps.setObject(3, notaCreditoDto.getFecha_nota_credito());
            ps.setObject(4, notaCreditoDto.getUsu_alta());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(NotaCreditoDTO notaCreditoDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.nota_creditos\n"
                    + "   SET id_cliente=?, concepto_nota_credito=?,\n"
                    + "       usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_nota_credito=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, notaCreditoDto.getId_cliente());
            ps.setObject(2, notaCreditoDto.getConcepto_nota_credito());
            ps.setObject(3, notaCreditoDto.getUsu_modi());
            ps.setObject(4, notaCreditoDto.getId());

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

    @Override
    public String procesar(NotaCreditoDTO notaCreditoDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.nota_creditos\n"
                    + "   SET numero_nota_credito=?, observacion_nota_credito=?,  usu_modi=?, \n"
                    + "   fec_modi=now(), accion_nota_credito=?, estado_nota_credito=?\n"
                    + " WHERE id_nota_credito=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, notaCreditoDto.getNumero_nota_credito());
            ps.setObject(2, notaCreditoDto.getObservacion_nota_credito());
            ps.setObject(3, notaCreditoDto.getUsu_modi());
            ps.setObject(4, notaCreditoDto.getAccion_nota_credito());
            ps.setObject(5, notaCreditoDto.getEstado());
            ps.setObject(6, notaCreditoDto.getId());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

}
