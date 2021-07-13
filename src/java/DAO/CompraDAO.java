/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.CompraDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface CompraDAO {
    
    String insertar(CompraDTO compraDto);

    String modificar(CompraDTO compraDto);
    
    String aplicarDescuentoCompra(CompraDTO compraDto);

    String eliminar(Integer id);
    
    String finiquitar(CompraDTO compraDto);
    
    String anular(CompraDTO compraDto);
    
    String ajustarMontoTotalCompra(CompraDTO compraDto);
    
    void crearConexion (Connection cn);
}
