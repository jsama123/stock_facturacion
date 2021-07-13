/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;


import DTO.ProveedorDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface ProveedorDAO {
    
    String insertar(ProveedorDTO proveedorDto);

    String modificar(ProveedorDTO proveedorDto);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
}
