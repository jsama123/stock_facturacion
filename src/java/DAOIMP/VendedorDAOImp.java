/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.VendedorDAO;
import DTO.VendedorDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class VendedorDAOImp implements VendedorDAO {

    public VendedorDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[VendedorDAOImp.java]";

    @Override
    public String insertar(VendedorDTO vendedorDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.vendedores(\n"
                    + "            nombre_apellido_vendedor, ci_vendedor, observaciones_vendedor, \n"
                    + "            usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, ?, \n"
                    + "            ?, now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, vendedorDto.getNombre_apellido_vendedor().toUpperCase());
            ps.setObject(2, vendedorDto.getCi_vendedor());
            ps.setObject(3, vendedorDto.getObservaciones_vendedor().toUpperCase());
            ps.setObject(4, vendedorDto.getUsu_alta());

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
    public String modificar(VendedorDTO vendedorDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.vendedores\n"
                    + "   SET nombre_apellido_vendedor=?, ci_vendedor=?, observaciones_vendedor=?, \n"
                    + "       usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_vendedor=?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, vendedorDto.getNombre_apellido_vendedor().toUpperCase());
            ps.setObject(2, vendedorDto.getCi_vendedor());
            ps.setObject(3, vendedorDto.getObservaciones_vendedor().toUpperCase());
            ps.setObject(4, vendedorDto.getUsu_modi());
            ps.setObject(5, vendedorDto.getId());

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
            String sql = " DELETE FROM stock_facturacion.vendedores WHERE id_vendedor = ?";
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
