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
public class CompraDetalleDTO {
    
    private int id_compra_detalle;
    private int id_compra;
    private int id_articulo;
    private int cantidad_compra;
    private Double costo_unitario;
    private int iva_aplicado;
    private int id_stock;
    private String usu_alta;
    private String usu_modi;

    public int getId_compra_detalle() {
        return id_compra_detalle;
    }

    public void setId_compra_detalle(int id_compra_detalle) {
        this.id_compra_detalle = id_compra_detalle;
    }

    public int getId_compra() {
        return id_compra;
    }

    public void setId_compra(int id_compra) {
        this.id_compra = id_compra;
    }

    public int getId_articulo() {
        return id_articulo;
    }

    public void setId_articulo(int id_articulo) {
        this.id_articulo = id_articulo;
    }

    public int getCantidad_compra() {
        return cantidad_compra;
    }

    public void setCantidad_compra(int cantidad_compra) {
        this.cantidad_compra = cantidad_compra;
    }

    public Double getPrecio_unitario() {
        return costo_unitario;
    }

    public void setPrecio_unitario(Double costo_unitario) {
        this.costo_unitario = costo_unitario;
    }

    public int getIva_aplicado() {
        return iva_aplicado;
    }

    public void setIva_aplicado(int iva_aplicado) {
        this.iva_aplicado = iva_aplicado;
    }

    public int getId_stock() {
        return id_stock;
    }

    public void setId_stock(int id_stock) {
        this.id_stock = id_stock;
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
