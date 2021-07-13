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
public class NotaPresupuestoDTO {
    
    private int id;
    private int id_cliente;
    private Date fecha_presupuesto;
    private int nro_nota_presupuesto;
    private String observacion_presupuesto;
    private String usu_alta;
    private String usu_modi;

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

    public Date getFecha_presupuesto() {
        return fecha_presupuesto;
    }

    public void setFecha_presupuesto(Date fecha_presupuesto) {
        this.fecha_presupuesto = fecha_presupuesto;
    }

    public int getNro_nota_presupuesto() {
        return nro_nota_presupuesto;
    }

    public void setNro_nota_presupuesto(int nro_nota_presupuesto) {
        this.nro_nota_presupuesto = nro_nota_presupuesto;
    }

    public String getObservacion_presupuesto() {
        return observacion_presupuesto;
    }

    public void setObservacion_presupuesto(String observacion_presupuesto) {
        this.observacion_presupuesto = observacion_presupuesto;
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
