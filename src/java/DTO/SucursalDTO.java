/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

/**
 *
 * @author Jose Samaniego
 */
public class SucursalDTO {
    
    private int id;
    private String descripcion_sucursal;
    private String direccion_sucursal;
    private String telefono_sucursal;
    private int nro_sucursal;
    private String usu_alta;
    private String usu_modi;

    public int getNro_sucursal() {
        return nro_sucursal;
    }

    public void setNro_sucursal(int nro_sucursal) {
        this.nro_sucursal = nro_sucursal;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescripcion_sucursal() {
        return descripcion_sucursal;
    }

    public void setDescripcion_sucursal(String descripcion_sucursal) {
        this.descripcion_sucursal = descripcion_sucursal;
    }

    public String getDireccion_sucursal() {
        return direccion_sucursal;
    }

    public void setDireccion_sucursal(String direccion_sucursal) {
        this.direccion_sucursal = direccion_sucursal;
    }

    public String getTelefono_sucursal() {
        return telefono_sucursal;
    }

    public void setTelefono_sucursal(String telefono_sucursal) {
        this.telefono_sucursal = telefono_sucursal;
    }

    public String getUsu_alta() {
        return usu_alta;
    }

    public void setUsu_alta(String usu_alta) {
        this.usu_alta = usu_alta;
    }

    public String getUsu_modi() {
        return usu_modi;
    }

    public void setUsu_modi(String usu_modi) {
        this.usu_modi = usu_modi;
    }
    
    
}
