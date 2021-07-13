/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

import java.sql.Date;

/**
 *
 * @author Jose Samaniego
 */
public class VentaManualDTO {
    
   private int id;
   private int id_cliente;
   private int id_cajero;
   private int id_caja;
   private Date fecha_venta;
   private String numero_factura_venta;
   private int id_tipo_pago;
   private int descuento_venta;
   private Double monto_pago;
   private String usu_alta;
   private String usu_modi;

    public int getDescuento_venta() {
        return descuento_venta;
    }

    public void setDescuento_venta(int descuento_venta) {
        this.descuento_venta = descuento_venta;
    }
   
    public String getNumero_factura_venta() {
        return numero_factura_venta;
    }

    public void setNumero_factura_venta(String numero_factura_venta) {
        this.numero_factura_venta = numero_factura_venta;
    }
   
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }

    public int getId_cajero() {
        return id_cajero;
    }

    public void setId_cajero(int id_cajero) {
        this.id_cajero = id_cajero;
    }

    public int getId_caja() {
        return id_caja;
    }

    public void setId_caja(int id_caja) {
        this.id_caja = id_caja;
    }

    public Date getFecha_venta() {
        return fecha_venta;
    }

    public void setFecha_venta(Date fecha_venta) {
        this.fecha_venta = fecha_venta;
    }
    public int getId_tipo_pago() {
        return id_tipo_pago;
    }

    public void setId_tipo_pago(int id_tipo_pago) {
        this.id_tipo_pago = id_tipo_pago;
    }

    public Double getMonto_pago() {
        return monto_pago;
    }

    public void setMonto_pago(Double monto_pago) {
        this.monto_pago = monto_pago;
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
