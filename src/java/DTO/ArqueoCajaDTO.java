/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

import java.sql.Timestamp;

/**
 *
 * @author Jose Samaniego
 */
public class ArqueoCajaDTO {
    
    private int id;
    private int id_cajero;
    private int id_caja;
    private double saldo_inicial_arqueo_caja;
    private int estado_arqueo_caja;
    private double resultado_arqueo_caja;
    private double total_arqueo_caja;
    private String observacion_arqueo_caja;
    private Timestamp fecha_inicio;
    private Timestamp fecha_fin;
    private String usu_alta;
    private String usu_modi;

    public double getTotal_arqueo_caja() {
        return total_arqueo_caja;
    }

    public void setTotal_arqueo_caja(double total_arqueo_caja) {
        this.total_arqueo_caja = total_arqueo_caja;
    }
    
    public Timestamp getFecha_inicio() {
        return fecha_inicio;
    }

    public void setFecha_inicio(Timestamp fecha_inicio) {
        this.fecha_inicio = fecha_inicio;
    }

    public Timestamp getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Timestamp fecha_fin) {
        this.fecha_fin = fecha_fin;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public double getSaldo_inicial_arqueo_caja() {
        return saldo_inicial_arqueo_caja;
    }

    public void setSaldo_inicial_arqueo_caja(double saldo_inicial_arqueo_caja) {
        this.saldo_inicial_arqueo_caja = saldo_inicial_arqueo_caja;
    }

    public int getEstado_arqueo_caja() {
        return estado_arqueo_caja;
    }

    public void setEstado_arqueo_caja(int estado_arqueo_caja) {
        this.estado_arqueo_caja = estado_arqueo_caja;
    }

    public double getResultado_arqueo_caja() {
        return resultado_arqueo_caja;
    }

    public void setResultado_arqueo_caja(double resultado_arqueo_caja) {
        this.resultado_arqueo_caja = resultado_arqueo_caja;
    }

    public String getObservacion_arqueo_caja() {
        return observacion_arqueo_caja;
    }

    public void setObservacion_arqueo_caja(String observacion_arqueo_caja) {
        this.observacion_arqueo_caja = observacion_arqueo_caja;
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
