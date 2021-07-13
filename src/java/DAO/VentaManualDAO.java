/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.VentaManualDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface VentaManualDAO {
    
    String insertar(VentaManualDTO ventaDto);

    String modificar(VentaManualDTO ventaDto);
    
    String registrarPagoVentaManual(VentaManualDTO ventaDto);
    
    String aplicarDescuentoVentaManual(VentaManualDTO ventaDto);

    String eliminar(Integer id);
    
    String finiquitar(VentaManualDTO ventaDto);
    
    String anular(VentaManualDTO ventaDto);
    
    void crearConexion (Connection cn);
}
