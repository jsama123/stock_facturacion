/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.NotaPresupuestoDetalleDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface NotaPresupuestoDetalleDAO {
    
    String insertar(NotaPresupuestoDetalleDTO notaPresupuestoDetalleDto);

    String modificar(NotaPresupuestoDetalleDTO notaPresupuestoDetalleDto);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
}
