/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.VentaManualDetalleDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface VentaManualDetalleDAO {
    
    String insertar(VentaManualDetalleDTO ventaDetalleDto);

    String modificar(VentaManualDetalleDTO ventaDetalleDto);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
}
