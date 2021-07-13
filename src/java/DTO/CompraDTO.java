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
public class CompraDTO {
    
   private int id;
   private int id_proveedor;
   private int id_cajero;
   private int id_caja;
   private Date fecha_compra;
   private String numero_factura_compra;
   private int id_tipo_pago;
   private int descuento_compra;
   private Double monto_pago;
   private String usu_alta;
   private String usu_modi;
   private String tipo_compra;
   private Double monto_entregado_compra;
   private String peridiocidad_compra;
   private String fecha_vencimiento_cuota_compra;
   private int cantidad_cuota_compra;
   private int id_deposito;
   private String timbrado_compra;
   private Double monto_total_compra;

    public Double getMonto_total_compra() {
        return monto_total_compra;
    }

    public void setMonto_total_compra(Double monto_total_compra) {
        this.monto_total_compra = monto_total_compra;
    }

    public String getTimbrado_compra() {
        return timbrado_compra;
    }

    public void setTimbrado_compra(String timbrado_compra) {
        this.timbrado_compra = timbrado_compra;
    }

    public int getId_deposito() {
        return id_deposito;
    }

    public void setId_deposito(int id_deposito) {
        this.id_deposito = id_deposito;
    }

    public String getTipo_compra() {
        return tipo_compra;
    }

    public void setTipo_compra(String tipo_compra) {
        this.tipo_compra = tipo_compra;
    }

    public Double getMonto_entregado_compra() {
        return monto_entregado_compra;
    }

    public void setMonto_entregado_compra(Double monto_entregado_compra) {
        this.monto_entregado_compra = monto_entregado_compra;
    }

    public String getPeridiocidad_compra() {
        return peridiocidad_compra;
    }

    public void setPeridiocidad_compra(String peridiocidad_compra) {
        this.peridiocidad_compra = peridiocidad_compra;
    }

    public String getFecha_vencimiento_cuota_compra() {
        return fecha_vencimiento_cuota_compra;
    }

    public void setFecha_vencimiento_cuota_compra(String fecha_vencimiento_cuota_compra) {
        this.fecha_vencimiento_cuota_compra = fecha_vencimiento_cuota_compra;
    }

    public int getCantidad_cuota_compra() {
        return cantidad_cuota_compra;
    }

    public void setCantidad_cuota_compra(int cantidad_cuota_compra) {
        this.cantidad_cuota_compra = cantidad_cuota_compra;
    }

    public int getDescuento_compra() {
        return descuento_compra;
    }

    public void setDescuento_compra(int descuento_compra) {
        this.descuento_compra = descuento_compra;
    }
   
    public String getNumero_factura_compra() {
        return numero_factura_compra;
    }

    public void setNumero_factura_compra(String numero_factura_compra) {
        this.numero_factura_compra = numero_factura_compra;
    }
   
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_proveedor() {
        return id_proveedor;
    }

    public void setId_proveedor(int id_proveedor) {
        this.id_proveedor = id_proveedor;
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

    public Date getFecha_compra() {
        return fecha_compra;
    }

    public void setFecha_compra(Date fecha_compra) {
        this.fecha_compra = fecha_compra;
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
