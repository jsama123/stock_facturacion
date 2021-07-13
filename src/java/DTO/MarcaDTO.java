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
public class MarcaDTO {
    
    private int id = 0;
    private String marca_descripcion = "";
    private String usu_alta = "";
    private String usu_modi = "";

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMarca_descripcion() {
        return marca_descripcion;
    }

    public void setMarca_descripcion(String marca_descripcion) {
        this.marca_descripcion = marca_descripcion;
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
