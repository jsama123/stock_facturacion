/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.MarcaDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface MarcaDAO {
    
    String insertar(MarcaDTO marcaDto);

    String modificar(MarcaDTO marcaDto);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
}
