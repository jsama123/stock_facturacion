/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.CajeroDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface CajeroDAO {
    
    String insertar(CajeroDTO cajeroDto);

    String modificar(CajeroDTO cajeroDto);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
}
