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
public class GastoDTO {
    
    private int id;
    private int id_proveedor;
    private String concepto_gasto;
    private String nro_comprobante_gasto;
    private Double monto_gasto;
    private String tipo_gasto;
    private int cantidad_cuota_gasto;
    private String usu_alta;
    private String usu_modi;
    private int iva;
    private Date fecha_gasto;
    private String timbrado_gasto;

    public String getTimbrado_gasto() {
        return timbrado_gasto;
    }

    public void setTimbrado_gasto(String timbrado_gasto) {
        this.timbrado_gasto = timbrado_gasto;
    }

    public Date getFecha_gasto() {
        return fecha_gasto;
    }

    public void setFecha_gasto(Date fecha_gasto) {
        this.fecha_gasto = fecha_gasto;
    }

    public int getIva() {
        return iva;
    }

    public void setIva(int iva) {
        this.iva = iva;
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

    public String getConcepto_gasto() {
        return concepto_gasto;
    }

    public void setConcepto_gasto(String concepto_gasto) {
        this.concepto_gasto = concepto_gasto;
    }

    public String getNro_comprobante_gasto() {
        return nro_comprobante_gasto;
    }

    public void setNro_comprobante_gasto(String nro_comprobante_gasto) {
        this.nro_comprobante_gasto = nro_comprobante_gasto;
    }

    public Double getMonto_gasto() {
        return monto_gasto;
    }

    public void setMonto_gasto(Double monto_gasto) {
        this.monto_gasto = monto_gasto;
    }

    public String getTipo_gasto() {
        return tipo_gasto;
    }

    public void setTipo_gasto(String tipo_gasto) {
        this.tipo_gasto = tipo_gasto;
    }

    public int getCantidad_cuota_gasto() {
        return cantidad_cuota_gasto;
    }

    public void setCantidad_cuota_gasto(int cantidad_cuota_gasto) {
        this.cantidad_cuota_gasto = cantidad_cuota_gasto;
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
