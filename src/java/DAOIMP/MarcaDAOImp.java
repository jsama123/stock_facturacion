/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.MarcaDAO;
import DTO.MarcaDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class MarcaDAOImp implements MarcaDAO {

    public MarcaDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[MarcaDAOImp.java]";

    @Override
    public String insertar(MarcaDTO marcaDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.marcas(\n"
                    + "            marca_descripcion, usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, marcaDto.getMarca_descripcion().toUpperCase());
            ps.setObject(2, marcaDto.getUsu_alta());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(MarcaDTO marcaDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.marcas\n"
                    + "   SET marca_descripcion=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_marca = ?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, marcaDto.getMarca_descripcion().toUpperCase());
            ps.setObject(2, marcaDto.getUsu_modi());
            ps.setObject(3, marcaDto.getId());

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
            String sql = " DELETE FROM stock_facturacion.marcas\n"
                    + " WHERE id_marca = ?;";
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
