/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.GrupoDAO;
import DTO.GrupoDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class GrupoDAOImp implements GrupoDAO {

    public GrupoDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[GrupoDAOImp.java]";

    @Override
    public String insertar(GrupoDTO grupoDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.grupos(\n"
                    + "            grupo_descripcion, usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, grupoDto.getGrupo_descripcion().toUpperCase());
            ps.setObject(2, grupoDto.getUsu_alta());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(GrupoDTO grupoDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.grupos\n"
                    + "   SET grupo_descripcion=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_grupo = ?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, grupoDto.getGrupo_descripcion().toUpperCase());
            ps.setObject(2, grupoDto.getUsu_modi());
            ps.setObject(3, grupoDto.getId());

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
            String sql = " DELETE FROM stock_facturacion.grupos\n"
                    + " WHERE id_grupo = ?;";
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
