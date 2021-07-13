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
public class CompraCreditoDTO {

    private int id;
    private int id_compra;
    private int nro_cuota_compra_credito;
    private Date fecha_pago_cuota;
    private String nro_comprobante_pago_cuota;
    private Double monto_pagado_cuota;
    private int estado_cuota;
    private int id_tipo_comprobante;
    private String usu_alta;
    private String usu_modi;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_compra() {
        return id_compra;
    }

    public void setId_compra(int id_compra) {
        this.id_compra = id_compra;
    }

    public int getNro_cuota_compra_credito() {
        return nro_cuota_compra_credito;
    }

    public void setNro_cuota_compra_credito(int nro_cuota_compra_credito) {
        this.nro_cuota_compra_credito = nro_cuota_compra_credito;
    }

    public Date getFecha_pago_cuota() {
        return fecha_pago_cuota;
    }

    public void setFecha_pago_cuota(Date fecha_pago_cuota) {
        this.fecha_pago_cuota = fecha_pago_cuota;
    }

    public String getNro_comprobante_pago_cuota() {
        return nro_comprobante_pago_cuota;
    }

    public void setNro_comprobante_pago_cuota(String nro_comprobante_pago_cuota) {
        this.nro_comprobante_pago_cuota = nro_comprobante_pago_cuota;
    }

    public Double getMonto_pagado_cuota() {
        return monto_pagado_cuota;
    }

    public void setMonto_pagado_cuota(Double monto_pagado_cuota) {
        this.monto_pagado_cuota = monto_pagado_cuota;
    }

    public int getEstado_cuota() {
        return estado_cuota;
    }

    public void setEstado_cuota(int estado_cuota) {
        this.estado_cuota = estado_cuota;
    }

    public int getId_tipo_comprobante() {
        return id_tipo_comprobante;
    }

    public void setId_tipo_comprobante(int id_tipo_comprobante) {
        this.id_tipo_comprobante = id_tipo_comprobante;
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
