/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.MedidaDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface MedidaDAO {
    
    String insertar(MedidaDTO medidaDto);

    String modificar(MedidaDTO medidaDto);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
}
