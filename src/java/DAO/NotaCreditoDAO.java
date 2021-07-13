/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.NotaCreditoDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface NotaCreditoDAO {
    
    String insertar(NotaCreditoDTO proveedorDto);

    String modificar(NotaCreditoDTO proveedorDto);

    String eliminar(Integer id);
    
    String procesar(NotaCreditoDTO notaCreditoDto);
    
    void crearConexion (Connection cn);
}
