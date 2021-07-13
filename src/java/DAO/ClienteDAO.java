/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.ClienteDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface ClienteDAO {
    
    String insertar(ClienteDTO clienteDto);

    String modificar(ClienteDTO clienteDto);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
}
