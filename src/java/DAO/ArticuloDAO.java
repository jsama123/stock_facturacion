/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.ArticuloDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface ArticuloDAO {
    
    String insertar(ArticuloDTO articuloDto);

    String modificar(ArticuloDTO articuloDTO);
    
    String actualizarCostoArticulo(ArticuloDTO articuloDTO);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
}
