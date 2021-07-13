/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.CajeroDAO;
import DTO.CajeroDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class CajeroDAOImp implements CajeroDAO {

    public CajeroDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[CajeroDAOImp.java]";

    @Override
    public String insertar(CajeroDTO cajeroDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.cajeros(\n"
                    + "            nombre_apellido_cajero, ci_cajero, observaciones_cajero, \n"
                    + "            usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, ?, \n"
                    + "            ?, now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, cajeroDto.getNombre_apellido_cajero().toUpperCase());
            ps.setObject(2, cajeroDto.getCi_cajero());
            ps.setObject(3, cajeroDto.getObservaciones_cajero().toUpperCase());
            ps.setObject(4, cajeroDto.getUsu_alta());

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
    public String modificar(CajeroDTO cajeroDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.cajeros\n"
                    + "   SET nombre_apellido_cajero=?, ci_cajero=?, observaciones_cajero=?, \n"
                    + "       usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_cajero=?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, cajeroDto.getNombre_apellido_cajero().toUpperCase());
            ps.setObject(2, cajeroDto.getCi_cajero());
            ps.setObject(3, cajeroDto.getObservaciones_cajero().toUpperCase());
            ps.setObject(4, cajeroDto.getUsu_modi());
            ps.setObject(5, cajeroDto.getId());

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
            String sql = " DELETE FROM stock_facturacion.cajeros WHERE id_cajero = ?";
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
