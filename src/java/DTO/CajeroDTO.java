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
public class CajeroDTO {
    
    private int id;
    private String nombre_apellido_cajero;
    private String ci_cajero;
    private String observaciones_cajero;
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

    public String getNombre_apellido_cajero() {
        return nombre_apellido_cajero;
    }

    public void setNombre_apellido_cajero(String nombre_apellido_cajero) {
        this.nombre_apellido_cajero = nombre_apellido_cajero;
    }

    public String getCi_cajero() {
        return ci_cajero;
    }

    public void setCi_cajero(String ci_cajero) {
        this.ci_cajero = ci_cajero;
    }

    public String getObservaciones_cajero() {
        return observaciones_cajero;
    }

    public void setObservaciones_cajero(String observaciones_cajero) {
        this.observaciones_cajero = observaciones_cajero;
    }
    
    
}
