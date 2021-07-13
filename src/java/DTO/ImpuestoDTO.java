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
public class ImpuestoDTO {
    
    private int id;
    private String descripcion_impuesto;
    private int porcentaje_impuesto ;
    private String usu_alta = "";
    private String usu_modi = "";

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

    public String getDescripcion_impuesto() {
        return descripcion_impuesto;
    }

    public void setDescripcion_impuesto(String descripcion_impuesto) {
        this.descripcion_impuesto = descripcion_impuesto;
    }

    public int getPorcentaje_impuesto() {
        return porcentaje_impuesto;
    }

    public void setPorcentaje_impuesto(int porcentaje_impuesto) {
        this.porcentaje_impuesto = porcentaje_impuesto;
    }
    
    
}
