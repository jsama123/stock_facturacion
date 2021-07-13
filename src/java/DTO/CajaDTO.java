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
public class CajaDTO {
    
    private int id;
    private String descripcion_caja;
    private String usu_alta = "";
    private String usu_modi = "";
    private int nro_caja;

    public int getNro_caja() {
        return nro_caja;
    }

    public void setNro_caja(int nro_caja) {
        this.nro_caja = nro_caja;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescripcion_caja() {
        return descripcion_caja;
    }

    public void setDescripcion_caja(String descripcion_caja) {
        this.descripcion_caja = descripcion_caja;
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
