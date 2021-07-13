/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.MalogradoDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface MalogradoDAO {
    
    String insertar(MalogradoDTO malogradoDto);

    String modificar(MalogradoDTO malogradoDto);

    String eliminar(Integer id);
    
    String procesar(MalogradoDTO malogradoDto);
    
    void crearConexion (Connection cn);
}
