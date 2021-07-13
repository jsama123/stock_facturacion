/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;


import DTO.EmpresaDTO;
import java.sql.Connection;

/**
 *
 * @author Jose Samaniego
 */
public interface EmpresaDAO {
    
    String insertar(EmpresaDTO empresaDto);

    String modificar(EmpresaDTO empresaDto);

    String eliminar(Integer id);
    
    void crearConexion (Connection cn);
}
