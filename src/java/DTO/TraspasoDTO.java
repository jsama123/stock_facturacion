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
public class TraspasoDTO {
    
    private int id;
    private int id_deposito_destino;
    private int id_deposito_origen;
    private Date fecha;
    private String observacion;
    private int estado;
    private String usu_alta;
    private String usu_modi;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_deposito_destino() {
        return id_deposito_destino;
    }

    public void setId_deposito_destino(int id_deposito_destino) {
        this.id_deposito_destino = id_deposito_destino;
    }

    public int getId_deposito_origen() {
        return id_deposito_origen;
    }

    public void setId_deposito_origen(int id_deposito_origen) {
        this.id_deposito_origen = id_deposito_origen;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
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
