/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.TraspasoDTO;
import DTO.TraspasoDetalleDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface TraspasoDetalleDAO {

    String insertar(TraspasoDetalleDTO traspasoDetalleDto);

    String modificar(TraspasoDetalleDTO traspasoDetalleDto);

    String eliminar(Integer id);

    void crearConexion(Connection cn);
}
