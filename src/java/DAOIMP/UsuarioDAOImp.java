/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.UsuarioDAO;
import DTO.UsuarioDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class UsuarioDAOImp implements UsuarioDAO {

    public UsuarioDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[UsuarioDAOImp.java]";

    @Override
    public String actualizarPass(UsuarioDTO usuarioDto) {
        String error = "";
        try {
            String sql = " UPDATE public.usuarios\n"
                    + "   SET passwd=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE login_usuario=?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, usuarioDto.getPasswd());
            ps.setObject(2, usuarioDto.getUsu_modi());
            ps.setObject(3, usuarioDto.getLogin_usuario());

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
