/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.ClienteDAO;
import DTO.ClienteDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class ClienteDAOImp implements ClienteDAO {

    public ClienteDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[ClienteDAOImp.java]";

    @Override
    public String insertar(ClienteDTO clienteDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.clientes(\n"
                    + "            ci_ruc_cliente, razon_social_cliente, nro_telefono_cliente, \n"
                    + "            direccion_cliente, email_cliente, usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, ?, \n"
                    + "            ?, ?, ?, now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, clienteDto.getCi_ruc_cliente());
            ps.setObject(2, clienteDto.getRazon_social_cliente().toUpperCase().toUpperCase());
            ps.setObject(3, clienteDto.getNro_telefono_cliente().toUpperCase());
            ps.setObject(4, clienteDto.getDireccion_cliente().toUpperCase().toUpperCase());
            ps.setObject(5, clienteDto.getEmail_cliente().toUpperCase().toUpperCase());
            ps.setObject(6, clienteDto.getUsu_alta());
            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(ClienteDTO clienteDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.clientes\n"
                    + "   SET ci_ruc_cliente=?, razon_social_cliente=?, nro_telefono_cliente=?, \n"
                    + "       direccion_cliente=?, email_cliente=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_cliente = ?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, clienteDto.getCi_ruc_cliente());
            ps.setObject(2, clienteDto.getRazon_social_cliente().toUpperCase().toUpperCase());
            ps.setObject(3, clienteDto.getNro_telefono_cliente().toUpperCase());
            ps.setObject(4, clienteDto.getDireccion_cliente().toUpperCase().toUpperCase());
            ps.setObject(5, clienteDto.getEmail_cliente().toUpperCase().toUpperCase());
            ps.setObject(6, clienteDto.getUsu_modi());
            ps.setObject(7, clienteDto.getId());

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
            String sql = " DELETE FROM stock_facturacion.clientes\n"
                    + " WHERE id_cliente = ?;";
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
