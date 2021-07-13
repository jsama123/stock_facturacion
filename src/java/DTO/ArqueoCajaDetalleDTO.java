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
public class ArqueoCajaDetalleDTO {
    
    private int id;
    private int id_arqueo_caja;
    private int cantidad;
    private double total_arqueo_caja;
    private double denominacion;
    private String usu_alta;
    private String usu_modi;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_arqueo_caja() {
        return id_arqueo_caja;
    }

    public void setId_arqueo_caja(int id_arqueo_caja) {
        this.id_arqueo_caja = id_arqueo_caja;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getTotal_arqueo_caja() {
        return total_arqueo_caja;
    }

    public void setTotal_arqueo_caja(double total_arqueo_caja) {
        this.total_arqueo_caja = total_arqueo_caja;
    }

    public double getDenominacion() {
        return denominacion;
    }

    public void setDenominacion(double denominacion) {
        this.denominacion = denominacion;
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
