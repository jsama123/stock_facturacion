/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.TraspasoDAO;
import DTO.TraspasoDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author jose-samaniego
 */
public class TraspasoDAOImp implements TraspasoDAO {

    public TraspasoDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[TraspasoDAOImp.java]";

    @Override
    public String insertar(TraspasoDTO traspasoDto) {
        String error = "";
        try {
            String sql = "INSERT INTO stock_facturacion.traspasos(\n"
                    + "            id_deposito_destino, id_deposito_origen, fecha, \n"
                    + "            observacion, estado, usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, ?, ?, ?, \n"
                    + "            ?, now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, traspasoDto.getId_deposito_destino());
            ps.setObject(2, traspasoDto.getId_deposito_origen());
            ps.setObject(3, traspasoDto.getFecha());
            ps.setObject(4, traspasoDto.getObservacion());
            ps.setObject(5, traspasoDto.getEstado());
            ps.setObject(6, traspasoDto.getUsu_alta());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;

    }

    @Override
    public String modificar(TraspasoDTO traspasoDTO) {
        String error = "";
        try {
            String sql = "UPDATE stock_facturacion.traspasos\n"
                    + "   SET id_deposito_destino=?, id_deposito_origen=?, fecha=?, \n"
                    + "       observacion=?, usu_modi=?, \n"
                    + "       fec_modi=now()\n"
                    + " WHERE id_traspaso=?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, traspasoDTO.getId_deposito_destino());
            ps.setObject(2, traspasoDTO.getId_deposito_origen());
            ps.setObject(3, traspasoDTO.getFecha());
            ps.setObject(4, traspasoDTO.getObservacion());
            ps.setObject(5, traspasoDTO.getUsu_modi());
            ps.setObject(6, traspasoDTO.getId());

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
            String sql = " DELETE FROM stock_facturacion.traspasos\n"
                    + " WHERE id_traspaso = ?;";
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
    public String aprobar(TraspasoDTO traspasoDto) {
        String error = "";
        try {
            String sql = "UPDATE stock_facturacion.traspasos\n"
                    + "   SET estado=1, usu_modi=?, \n"
                    + "       fec_modi=now()\n"
                    + " WHERE id_traspaso=?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, traspasoDto.getUsu_modi());
            ps.setObject(2, traspasoDto.getId());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String anular(TraspasoDTO traspasoDto) {
        String error = "";
        try {
            String sql = "UPDATE stock_facturacion.traspasos\n"
                    + "   SET estado=2, usu_modi=?, \n"
                    + "       fec_modi=now()\n"
                    + " WHERE id_traspaso=?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, traspasoDto.getUsu_modi());
            ps.setObject(2, traspasoDto.getId());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

}
