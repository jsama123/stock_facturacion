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
public class VentaManualDetalleDTO {
    
    private int id_venta_manual_detalle;
    private int id_venta_manual;
    private int id_articulo;
    private int cantidad_venta;
    private Double precio_unitario;
    private int iva_aplicado;
    private int id_stock;
    private String usu_alta;
    private String usu_modi;
    private int descuenta_venta;
    private int descuento_gs_venta;
    private boolean es_desc_gs_venta;

    public int getId_venta_manual_detalle() {
        return id_venta_manual_detalle;
    }

    public void setId_venta_manual_detalle(int id_venta_manual_detalle) {
        this.id_venta_manual_detalle = id_venta_manual_detalle;
    }

    public int getId_venta_manual() {
        return id_venta_manual;
    }

    public void setId_venta_manual(int id_venta_manual) {
        this.id_venta_manual = id_venta_manual;
    }

    public int getDescuenta_venta() {
        return descuenta_venta;
    }

    public void setDescuenta_venta(int descuenta_venta) {
        this.descuenta_venta = descuenta_venta;
    }

    public int getDescuento_gs_venta() {
        return descuento_gs_venta;
    }

    public void setDescuento_gs_venta(int descuento_gs_venta) {
        this.descuento_gs_venta = descuento_gs_venta;
    }

    public boolean isEs_desc_gs_venta() {
        return es_desc_gs_venta;
    }

    public void setEs_desc_gs_venta(boolean es_desc_gs_venta) {
        this.es_desc_gs_venta = es_desc_gs_venta;
    }

    public int getId_venta_detalle() {
        return id_venta_manual_detalle;
    }

    public void setId_venta_detalle(int id_venta_manual_detalle) {
        this.id_venta_manual_detalle = id_venta_manual_detalle;
    }

    public int getId_venta() {
        return id_venta_manual;
    }

    public void setId_venta(int id_venta_manual) {
        this.id_venta_manual = id_venta_manual;
    }

    public int getId_articulo() {
        return id_articulo;
    }

    public void setId_articulo(int id_articulo) {
        this.id_articulo = id_articulo;
    }

    public int getCantidad_venta() {
        return cantidad_venta;
    }

    public void setCantidad_venta(int cantidad_venta) {
        this.cantidad_venta = cantidad_venta;
    }

    public Double getPrecio_unitario() {
        return precio_unitario;
    }

    public void setPrecio_unitario(Double precio_unitario) {
        this.precio_unitario = precio_unitario;
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
