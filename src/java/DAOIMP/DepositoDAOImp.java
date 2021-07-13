/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.DepositoDAO;
import DTO.DepositoDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class DepositoDAOImp implements DepositoDAO {

    public DepositoDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[DepositoDAOImp.java]";

    @Override
    public String insertar(DepositoDTO depositoDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.depositos_sucursales(\n"
                    + "            deposito_sucursal_descripcion, id_sucursal, deposito_comercial, usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, ?, ?, now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, depositoDto.getDeposito_descripcion().toUpperCase());
            ps.setObject(2, depositoDto.getId_sucursal());
            ps.setObject(3, depositoDto.isDeposito_comercial());
            ps.setObject(4, depositoDto.getUsu_alta());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(DepositoDTO depositoDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.depositos_sucursales\n"
                    + "   SET deposito_sucursal_descripcion=?, id_sucursal = ?, deposito_comercial=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_deposito_sucursal = ?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, depositoDto.getDeposito_descripcion().toUpperCase());
            ps.setObject(2, depositoDto.getId_sucursal());
            ps.setObject(3, depositoDto.isDeposito_comercial());
            ps.setObject(4, depositoDto.getUsu_modi());
            ps.setObject(5, depositoDto.getId());

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
            String sql = " DELETE FROM stock_facturacion.depositos_sucursales\n"
                    + " WHERE id_deposito = ?;";
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
