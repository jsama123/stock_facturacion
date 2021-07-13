/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.CompraCreditoDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface CompraCreditoDAO {
    
    String insertar(CompraCreditoDTO compraCreditoDto);

    String modificar(CompraCreditoDTO compraCreditoDto);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
}
