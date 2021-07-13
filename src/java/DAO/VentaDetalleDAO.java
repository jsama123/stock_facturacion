/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.VentaDetalleDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface VentaDetalleDAO {
    
    String insertar(VentaDetalleDTO ventaDetalleDto);

    String modificar(VentaDetalleDTO ventaDetalleDto);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
}
