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
public class VendedorDTO {
    
    private int id;
    private String nombre_apellido_vendedor;
    private String ci_vendedor;
    private String observaciones_vendedor;
    private String usu_alta;
    private String usu_modi;

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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre_apellido_vendedor() {
        return nombre_apellido_vendedor;
    }

    public void setNombre_apellido_vendedor(String nombre_apellido_vendedor) {
        this.nombre_apellido_vendedor = nombre_apellido_vendedor;
    }

    public String getCi_vendedor() {
        return ci_vendedor;
    }

    public void setCi_vendedor(String ci_vendedor) {
        this.ci_vendedor = ci_vendedor;
    }

    public String getObservaciones_vendedor() {
        return observaciones_vendedor;
    }

    public void setObservaciones_vendedor(String observaciones_vendedor) {
        this.observaciones_vendedor = observaciones_vendedor;
    }
    
    
}
