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
public class ParametroCuotaVentaDTO {
    
    private int id;
    private int cantidad_cuota;
    private String usu_alta;
    private String usu_modi;
    private int interes_mensual;

    public String getUsu_alta() {
        return usu_alta;
    }
    
    public int getCantidad_cuota() {
        return cantidad_cuota;
    }

    public void setCantidad_cuota(int cantidad_cuota) {
        this.cantidad_cuota = cantidad_cuota;
    }

    public int getInteres_mensual() {
        return interes_mensual;
    }

    public void setInteres_mensual(int interes_mensual) {
        this.interes_mensual = interes_mensual;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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
