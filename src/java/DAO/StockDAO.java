/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.StockDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface StockDAO {
    
    String insertar(StockDTO stockDto);

    String modificar(StockDTO stockDto);

    String eliminar(Integer id);
    
    String actualizarStockOrigenTraspasoOrigen(StockDTO stockDto);
    
    String actualizarStockOrigenTraspasoDestino(StockDTO stockDto);
    
    String anulacionStockActualizarTraspasoOrigen(StockDTO stockDto);
    
    String anulacionStockActualizarTraspasoDestino(StockDTO stockDto);
    
    String insertarStockTraspasoDestino(StockDTO stockDto);
    
    void crearConexion (Connection cn);
}
