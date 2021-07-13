/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DTO;

import java.sql.Date;

/**
 *
 * @author jose-samaniego
 */
public class NotaPresupuestoDetalleDTO {
    
    private int id;
    private int id_nota_presupuesto;
    private int cantidad;
    private int id_articulo;
    private int desc_aplicado;
    private int iva_aplicado;
    private Double precio_aplicado;
    private String usu_alta;
    private String usu_modi;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_nota_presupuesto() {
        return id_nota_presupuesto;
    }

    public void setId_nota_presupuesto(int id_nota_presupuesto) {
        this.id_nota_presupuesto = id_nota_presupuesto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public int getId_articulo() {
        return id_articulo;
    }

    public void setId_articulo(int id_articulo) {
        this.id_articulo = id_articulo;
    }

    public int getDesc_aplicado() {
        return desc_aplicado;
    }

    public void setDesc_aplicado(int desc_aplicado) {
        this.desc_aplicado = desc_aplicado;
    }

    public int getIva_aplicado() {
        return iva_aplicado;
    }

    public void setIva_aplicado(int iva_aplicado) {
        this.iva_aplicado = iva_aplicado;
    }

    public Double getPrecio_aplicado() {
        return precio_aplicado;
    }

    public void setPrecio_aplicado(Double precio_aplicado) {
        this.precio_aplicado = precio_aplicado;
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
