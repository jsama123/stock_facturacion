/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.ArqueoCajaDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface ArqueoCajaDAO {
    
    String insertar(ArqueoCajaDTO arqueoCajaDto);

    String modificar(ArqueoCajaDTO arqueoCajaDTO);
    
    String cerrarCaja(ArqueoCajaDTO arqueoCajaDTO);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
}
