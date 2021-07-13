/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.TraspasoDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface TraspasoDAO {

    String insertar(TraspasoDTO traspasoDto);

    String modificar(TraspasoDTO traspasoDTO);

    String eliminar(Integer id);
    
    String aprobar(TraspasoDTO traspasoDto);
    
    String anular(TraspasoDTO traspasoDto);

    void crearConexion(Connection cn);
}
