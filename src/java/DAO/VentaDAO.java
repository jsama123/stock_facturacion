/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.VentaDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface VentaDAO {
    
    String insertar(VentaDTO ventaDto);

    String modificar(VentaDTO ventaDto);
    
    String registrarPagoVenta(VentaDTO ventaDto);
    
    String aplicarDescuentoVenta(VentaDTO ventaDto);

    String eliminar(Integer id);
    
    String finiquitar(VentaDTO ventaDto);
    
    String anular(VentaDTO ventaDto);
    
    String actualizarNroFacturaVenta(VentaDTO ventaDto);
    
    void crearConexion (Connection cn);
}
