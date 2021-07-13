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
public class VentaCreditoDTO {
    
   private int id;
   private int id_venta;
   private int nro_cuota;
   private int monto_cuota;
   private Date fecha_vencimiento_cuota;
   private Date fecha_cobro_cuota;
   private int estado_cuota;
   private int dias_mora;
   private int monto_cobrado;
   private String usu_alta;
   private String usu_modi;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_venta() {
        return id_venta;
    }

    public void setId_venta(int id_venta) {
        this.id_venta = id_venta;
    }

    public int getNro_cuota() {
        return nro_cuota;
    }

    public void setNro_cuota(int nro_cuota) {
        this.nro_cuota = nro_cuota;
    }

    public int getMonto_cuota() {
        return monto_cuota;
    }

    public void setMonto_cuota(int monto_cuota) {
        this.monto_cuota = monto_cuota;
    }

    public Date getFecha_vencimiento_cuota() {
        return fecha_vencimiento_cuota;
    }

    public void setFecha_vencimiento_cuota(Date fecha_vencimiento_cuota) {
        this.fecha_vencimiento_cuota = fecha_vencimiento_cuota;
    }

    public Date getFecha_cobro_cuota() {
        return fecha_cobro_cuota;
    }

    public void setFecha_cobro_cuota(Date fecha_cobro_cuota) {
        this.fecha_cobro_cuota = fecha_cobro_cuota;
    }

    public int getEstado_cuota() {
        return estado_cuota;
    }

    public void setEstado_cuota(int estado_cuota) {
        this.estado_cuota = estado_cuota;
    }

    public int getDias_mora() {
        return dias_mora;
    }

    public void setDias_mora(int dias_mora) {
        this.dias_mora = dias_mora;
    }

    public int getMonto_cobrado() {
        return monto_cobrado;
    }

    public void setMonto_cobrado(int monto_cobrado) {
        this.monto_cobrado = monto_cobrado;
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
