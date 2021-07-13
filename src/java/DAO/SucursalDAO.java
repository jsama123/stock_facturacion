/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.SucursalDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface SucursalDAO {
    
    String insertar(SucursalDTO sucursalDto);

    String modificar(SucursalDTO sucursalDTO);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
}
