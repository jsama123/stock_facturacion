/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.GastoDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface GastoDAO {
    
    String insertar(GastoDTO gastoDto); 

    String modificar(GastoDTO gastoDTO);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
}
