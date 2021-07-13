/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.ArqueoCajaDetalleDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface ArqueoCajaDetalleDAO {
    
    String insertar(ArqueoCajaDetalleDTO arqueoCajaDetalleDto);

    String modificar(ArqueoCajaDetalleDTO arqueoCajaDetalleDto);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
}
