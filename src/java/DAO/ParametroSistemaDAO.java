/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.ParametrosSistemaDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface ParametroSistemaDAO {
    
    String insertar(ParametrosSistemaDTO parametroSystemDto);

    String modificar(ParametrosSistemaDTO parametroSystemDto);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
    
}
