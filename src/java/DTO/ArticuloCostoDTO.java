/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DTO;

/**
 *
 * @author jose-samaniego
 */
public class ArticuloCostoDTO {
    
    private int id;
    private int id_articulo;
    private Double costo_compra;
    private Double costo_venta;
    private String usu_alta;
    private String usu_modi;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_articulo() {
        return id_articulo;
    }

    public void setId_articulo(int id_articulo) {
        this.id_articulo = id_articulo;
    }

    public Double getCosto_compra() {
        return costo_compra;
    }

    public void setCosto_compra(Double costo_compra) {
        this.costo_compra = costo_compra;
    }

    public Double getCosto_venta() {
        return costo_venta;
    }

    public void setCosto_venta(Double costo_venta) {
        this.costo_venta = costo_venta;
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
