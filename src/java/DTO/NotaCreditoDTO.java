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
public class NotaCreditoDTO {
    
    private int id;
    private int id_cliente;
    private int id_stock;
    private int id_venta;
    private String concepto_nota_credito;
    private Timestamp fecha_nota_credito;
    private int numero_nota_credito;
    private Double monto_nota_credito;
    private String observacion_nota_credito;
    private String usu_alta;
    private String usu_modi;
    private int accion_nota_credito;
    private boolean nota_credito_utilizada;
    private int estado;

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
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

    public int getId_stock() {
        return id_stock;
    }

    public void setId_stock(int id_stock) {
        this.id_stock = id_stock;
    }

    public int getId_venta() {
        return id_venta;
    }

    public void setId_venta(int id_venta) {
        this.id_venta = id_venta;
    }

    public String getConcepto_nota_credito() {
        return concepto_nota_credito;
    }

    public void setConcepto_nota_credito(String concepto_nota_credito) {
        this.concepto_nota_credito = concepto_nota_credito;
    }

    public Timestamp getFecha_nota_credito() {
        return fecha_nota_credito;
    }

    public void setFecha_nota_credito(Timestamp fecha_nota_credito) {
        this.fecha_nota_credito = fecha_nota_credito;
    }

    public int getNumero_nota_credito() {
        return numero_nota_credito;
    }

    public void setNumero_nota_credito(int numero_nota_credito) {
        this.numero_nota_credito = numero_nota_credito;
    }

    public Double getMonto_nota_credito() {
        return monto_nota_credito;
    }

    public void setMonto_nota_credito(Double monto_nota_credito) {
        this.monto_nota_credito = monto_nota_credito;
    }

    public String getObservacion_nota_credito() {
        return observacion_nota_credito;
    }

    public void setObservacion_nota_credito(String observacion_nota_credito) {
        this.observacion_nota_credito = observacion_nota_credito;
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

    public int getAccion_nota_credito() {
        return accion_nota_credito;
    }

    public void setAccion_nota_credito(int accion_nota_credito) {
        this.accion_nota_credito = accion_nota_credito;
    }

    public boolean isNota_credito_utilizada() {
        return nota_credito_utilizada;
    }

    public void setNota_credito_utilizada(boolean nota_credito_utilizada) {
        this.nota_credito_utilizada = nota_credito_utilizada;
    }
    
      
    
}
