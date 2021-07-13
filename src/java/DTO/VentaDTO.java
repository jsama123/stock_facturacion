/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author Jose Samaniego
 */
public class VentaDTO {
    
   private int id;
   private int id_cliente;
   private String id_timbrado;
   private int id_cajero;
   private int id_caja;
   private Timestamp fecha_venta;
   private String numero_factura_venta;
   private int numero_ticket_venta;
   private int id_tipo_pago;
   private int descuento_venta;
   private Double monto_pago;
   private String usu_alta;
   private String usu_modi;
   private String nro_boleta_tarjeta;
   private String tipo_venta;
   private Double monto_recibido_venta;
   private int cantidad_cuotas_ventas;
   private Date fecha_vencimiento_primer_cuota_venta;

    public String getTipo_venta() {
        return tipo_venta;
    }

    public void setTipo_venta(String tipo_venta) {
        this.tipo_venta = tipo_venta;
    }

    public Double getMonto_recibido_venta() {
        return monto_recibido_venta;
    }

    public void setMonto_recibido_venta(Double monto_recibido_venta) {
        this.monto_recibido_venta = monto_recibido_venta;
    }

    public int getCantidad_cuotas_ventas() {
        return cantidad_cuotas_ventas;
    }

    public void setCantidad_cuotas_ventas(int cantidad_cuotas_ventas) {
        this.cantidad_cuotas_ventas = cantidad_cuotas_ventas;
    }

    public Date getFecha_vencimiento_primer_cuota_venta() {
        return fecha_vencimiento_primer_cuota_venta;
    }

    public void setFecha_vencimiento_primer_cuota_venta(Date fecha_vencimiento_primer_cuota_venta) {
        this.fecha_vencimiento_primer_cuota_venta = fecha_vencimiento_primer_cuota_venta;
    }

    public String getNro_boleta_tarjeta() {
        return nro_boleta_tarjeta;
    }

    public void setNro_boleta_tarjeta(String nro_boleta_tarjeta) {
        this.nro_boleta_tarjeta = nro_boleta_tarjeta;
    }

    public int getDescuento_venta() {
        return descuento_venta;
    }

    public void setDescuento_venta(int descuento_venta) {
        this.descuento_venta = descuento_venta;
    }
   
    public String getId_timbrado() {
        return id_timbrado;
    }

    public void setId_timbrado(String id_timbrado) {
        this.id_timbrado = id_timbrado;
    }
   
    public String getNumero_factura_venta() {
        return numero_factura_venta;
    }

    public void setNumero_factura_venta(String numero_factura_venta) {
        this.numero_factura_venta = numero_factura_venta;
    }
   
    public int getNumero_ticket_venta() {
        return numero_ticket_venta;
    }

    public void setNumero_ticket_venta(int numero_ticket_venta) {
        this.numero_ticket_venta = numero_ticket_venta;
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

    public Timestamp getFecha_venta() {
        return fecha_venta;
    }

    public void setFecha_venta(Timestamp fecha_venta) {
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
