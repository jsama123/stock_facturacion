/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.VentaCreditoDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface VentaCreditoDAO {
    
    String insertar(VentaCreditoDTO ventaDto);

    String modificar(VentaCreditoDTO ventaDto);
        
    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
}
