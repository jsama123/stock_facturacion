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
public class TimbradoDTO {
    
    private int id;
    private Double numero_timbrado;
    private Date fecha_inicio_timbrado;
    private Date fecha_fin_timbrado;
    private int estado;
    private int ultimo_nro_factura;
    private String usu_alta;
    private String usu_modi;

    public int getUltimo_nro_factura() {
        return ultimo_nro_factura;
    }

    public void setUltimo_nro_factura(int ultimo_nro_factura) {
        this.ultimo_nro_factura = ultimo_nro_factura;
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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Double getNumero_timbrado() {
        return numero_timbrado;
    }

    public void setNumero_timbrado(Double numero_timbrado) {
        this.numero_timbrado = numero_timbrado;
    }

    public Date getFecha_inicio_timbrado() {
        return fecha_inicio_timbrado;
    }

    public void setFecha_inicio_timbrado(Date fecha_inicio_timbrado) {
        this.fecha_inicio_timbrado = fecha_inicio_timbrado;
    }

    public Date getFecha_fin_timbrado() {
        return fecha_fin_timbrado;
    }

    public void setFecha_fin_timbrado(Date fecha_fin_timbrado) {
        this.fecha_fin_timbrado = fecha_fin_timbrado;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }
    
    
}
