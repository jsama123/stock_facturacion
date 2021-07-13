/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.ListaPrecioDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface ListaPrecioDAO {
    
    String insertar(ListaPrecioDTO listaPrecioDto);

    String modificar(ListaPrecioDTO listaPrecioDto);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
    
}
