/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.ListaPrecioDAO;
import DTO.ListaPrecioDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class ListaPrecioDAOImp implements ListaPrecioDAO {

    public ListaPrecioDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[ListaPrecioDAOImp.java]";

    @Override
    public String insertar(ListaPrecioDTO listaPrecioDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.lista_precios(\n"
                    + "            descripcion_lista_precio, porcentaje_lista_precio, \n"
                    + "            usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, \n"
                    + "            ?, now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, listaPrecioDto.getDescripcion_lista_precio().toUpperCase());
            ps.setObject(2, listaPrecioDto.getPorcentaje_lista_precio());
            ps.setObject(3, listaPrecioDto.getUsu_alta());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(ListaPrecioDTO listaPrecioDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.lista_precios\n"
                    + "   SET descripcion_lista_precio=?, porcentaje_lista_precio=?, \n"
                    + "        usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_lista_precio=? ;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, listaPrecioDto.getDescripcion_lista_precio().toUpperCase());
            ps.setObject(2, listaPrecioDto.getPorcentaje_lista_precio());
            ps.setObject(3, listaPrecioDto.getUsu_modi());
            ps.setObject(4, listaPrecioDto.getId());

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
            String sql = " DELETE FROM stock_facturacion.lista_precios\n"
                    + " WHERE id_lista_precio = ? ;";
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
