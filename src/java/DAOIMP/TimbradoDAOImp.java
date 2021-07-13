/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.TimbradoDAO;
import DTO.TimbradoDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class TimbradoDAOImp implements TimbradoDAO {

    Connection cn;
    private String nombre_fichero = "[TimbradoDAOImp.java]";

    @Override
    public String insertar(TimbradoDTO timbradoDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.timbrados(\n"
                    + "            numero_timbrado, fecha_inicio_timbrado, fecha_fin_timbrado, \n"
                    + "            estado, usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, ?, \n"
                    + "            ?, ?, now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, timbradoDto.getNumero_timbrado());
            ps.setObject(2, timbradoDto.getFecha_inicio_timbrado());
            ps.setObject(3, timbradoDto.getFecha_fin_timbrado());
            ps.setObject(4, timbradoDto.getEstado());
            ps.setObject(5, timbradoDto.getUsu_alta());

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
    public String modificar(TimbradoDTO timbradoDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.timbrados\n"
                    + "   SET numero_timbrado=?, fecha_inicio_timbrado=?, fecha_fin_timbrado=?, \n"
                    + "       estado=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_timbrado=?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, timbradoDto.getNumero_timbrado());
            ps.setObject(2, timbradoDto.getFecha_inicio_timbrado());
            ps.setObject(3, timbradoDto.getFecha_fin_timbrado());
            ps.setObject(4, timbradoDto.getEstado());
            ps.setObject(5, timbradoDto.getUsu_modi());
            ps.setObject(6, timbradoDto.getId());

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
            String sql = " DELETE FROM stock_facturacion.timbrados\n"
                    + " WHERE id_timbrado = ?";
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
    public String actualizarEstado(TimbradoDTO timbradoDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.timbrados\n"
                    + "   SET estado=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE estado=0;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, timbradoDto.getEstado());
            ps.setObject(2, timbradoDto.getUsu_modi());

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
    public String actualizarNroFacturaTimbradoVigennte(TimbradoDTO timbradoDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.timbrados\n"
                    + "   SET ultimo_nro_factura=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE estado=0;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, timbradoDto.getUltimo_nro_factura()+1);
            ps.setObject(2, timbradoDto.getUsu_modi());

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
