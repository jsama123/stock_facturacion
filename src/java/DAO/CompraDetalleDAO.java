/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.CompraDetalleDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface CompraDetalleDAO {
    
    String insertar(CompraDetalleDTO compraDetalleDto);

    String modificar(CompraDetalleDTO compraDetalleDto);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
}
