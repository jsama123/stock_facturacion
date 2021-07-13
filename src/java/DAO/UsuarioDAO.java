/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.UsuarioDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface UsuarioDAO {
    
    String actualizarPass(UsuarioDTO usuarioDto);
    
    void crearConexion(Connection cn);
}
