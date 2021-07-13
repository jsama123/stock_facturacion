/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.ImpuestoDAO;
import DTO.ImpuestoDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class ImpuestoDAOImp implements ImpuestoDAO {

    public ImpuestoDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[ImpuestoDAOImp.java]";

    @Override
    public String insertar(ImpuestoDTO impuestoDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.impuestos(\n"
                    + "            descripcion_impuesto, porcentaje_impuesto, \n"
                    + "            usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, \n"
                    + "            ?, now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, impuestoDto.getDescripcion_impuesto().toUpperCase());
            ps.setObject(2, impuestoDto.getPorcentaje_impuesto());
            ps.setObject(3, impuestoDto.getUsu_alta());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(ImpuestoDTO impuestoDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.impuestos\n"
                    + "   SET descripcion_impuesto=?, porcentaje_impuesto=?, \n"
                    + "        usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_impuesto=? ;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, impuestoDto.getDescripcion_impuesto().toUpperCase());
            ps.setObject(2, impuestoDto.getPorcentaje_impuesto());
            ps.setObject(3, impuestoDto.getUsu_modi());
            ps.setObject(4, impuestoDto.getId());

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
            String sql = " DELETE FROM stock_facturacion.impuestos\n"
                    + " WHERE id_impuesto = ? ;";
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
