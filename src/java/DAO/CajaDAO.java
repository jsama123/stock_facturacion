/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.CajaDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface CajaDAO {
    String insertar(CajaDTO cajaDto);

    String modificar(CajaDTO cajaDTO);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
}
