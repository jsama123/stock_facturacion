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
public class NotaCreditoDetalleDTO {
    
    private int id;
    private int id_nota_credito;
    private int id_stock;
    private int id_venta;
    private Double monto_nota_credito;
    private String usu_alta;
    private String usu_modi;
    private int cantidad_nota_credito;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_nota_credito() {
        return id_nota_credito;
    }

    public void setId_nota_credito(int id_nota_credito) {
        this.id_nota_credito = id_nota_credito;
    }

    public int getId_stock() {
        return id_stock;
    }

    public void setId_stock(int id_stock) {
        this.id_stock = id_stock;
    }

    public int getId_venta() {
        return id_venta;
    }

    public void setId_venta(int id_venta) {
        this.id_venta = id_venta;
    }

    public Double getMonto_nota_credito() {
        return monto_nota_credito;
    }

    public void setMonto_nota_credito(Double monto_nota_credito) {
        this.monto_nota_credito = monto_nota_credito;
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

    public int getCantidad_nota_credito() {
        return cantidad_nota_credito;
    }

    public void setCantidad_nota_credito(int cantidad_nota_credito) {
        this.cantidad_nota_credito = cantidad_nota_credito;
    }
    
    
    
}
