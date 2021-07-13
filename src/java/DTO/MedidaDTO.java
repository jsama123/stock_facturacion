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
public class MedidaDTO {
    
    private int id = 0;
    private String medida_descripcion = "";
    private String usu_alta = "";
    private String usu_modi = "";

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMedida_descripcion() {
        return medida_descripcion;
    }

    public void setMedida_descripcion(String medida_descripcion) {
        this.medida_descripcion = medida_descripcion;
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
