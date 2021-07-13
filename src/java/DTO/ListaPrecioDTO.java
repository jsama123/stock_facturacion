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
public class ListaPrecioDTO {
    
    private int id;
    private String descripcion_lista_precio;
    private int porcentaje_lista_precio ;
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

    public String getDescripcion_lista_precio() {
        return descripcion_lista_precio;
    }

    public void setDescripcion_lista_precio(String descripcion_lista_precio) {
        this.descripcion_lista_precio = descripcion_lista_precio;
    }

    public int getPorcentaje_lista_precio() {
        return porcentaje_lista_precio;
    }

    public void setPorcentaje_lista_precio(int porcentaje_lista_precio) {
        this.porcentaje_lista_precio = porcentaje_lista_precio;
    }
    
    
}
