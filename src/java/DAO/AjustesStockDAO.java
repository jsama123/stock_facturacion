/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.AjustesStockDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface AjustesStockDAO {
    
    String insertar(AjustesStockDTO ajustesStockDto);

    String modificar(AjustesStockDTO ajustesStockDto);

    String eliminar(Integer id);
    
    String procesar(AjustesStockDTO ajustesStockDto);
    
    String anular(AjustesStockDTO ajustesStockDto);
    
    void crearConexion (Connection cn);
}
