/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.NotaPresupuestoDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface NotaPresupuestoDAO {
    
    String insertar(NotaPresupuestoDTO notaPresupuestoDto);

    String modificar(NotaPresupuestoDTO notaPresupuestoDto);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
}
