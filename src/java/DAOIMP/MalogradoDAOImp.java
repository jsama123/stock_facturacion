/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.MalogradoDAO;
import DTO.MalogradoDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author jose-samaniego
 */
public class MalogradoDAOImp implements MalogradoDAO {

    public MalogradoDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[MalogradoDAOImp.java]";

    @Override
    public String insertar(MalogradoDTO malogradoDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.malogrados(\n"
                    + "            motivo, id_stock, cantidad, observacion, usu_alta, \n"
                    + "            fec_alta, estado)\n"
                    + "    VALUES (?, ?, ?, ?, ?, \n"
                    + "            now(), ?);";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, malogradoDto.getMotivo().toUpperCase());
            ps.setObject(2, malogradoDto.getId_stock());
            ps.setObject(3, malogradoDto.getCantidad());
            ps.setObject(4, malogradoDto.getObservacion().toUpperCase());
            ps.setObject(5, malogradoDto.getUsu_alta());
            ps.setObject(6, malogradoDto.getEstado());
            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(MalogradoDTO malogradoDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.malogrados\n"
                    + "   SET motivo=?, id_stock=?, cantidad=?, observacion=?, \n"
                    + "        usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_malogrado=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, malogradoDto.getMotivo().toUpperCase());
            ps.setObject(2, malogradoDto.getId_stock());
            ps.setObject(3, malogradoDto.getCantidad());
            ps.setObject(4, malogradoDto.getObservacion().toUpperCase());
            ps.setObject(5, malogradoDto.getUsu_modi());
            ps.setObject(6, malogradoDto.getId());
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
            String sql = " DELETE FROM stock_facturacion.malogrados\n"
                    + " WHERE id_malogrado = ?";
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
    public String procesar(MalogradoDTO malogradoDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.malogrados\n"
                    + "   SET usu_modi=?, fec_modi=now(),\n"
                    + "       estado=1\n"
                    + " WHERE id_malogrado=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, malogradoDto.getUsu_modi());
            ps.setObject(2, malogradoDto.getId());
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
