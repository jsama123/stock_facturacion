/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.ParametroCuotaVentaDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface ParametroCuotaVentaDAO {
    
    String insertar(ParametroCuotaVentaDTO parametroSystemDto);

    String modificar(ParametroCuotaVentaDTO parametroSystemDto);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
    
}
