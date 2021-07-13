/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.ArticuloCostoDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface ArticuloCostoDAO {
    
    String insertar(ArticuloCostoDTO articuloCostoDto);

    String modificar(ArticuloCostoDTO articuloCostoDTO);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
}
