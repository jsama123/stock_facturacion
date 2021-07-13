/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

/**
 *
 * @author Jose Samaniego
 */
public class StockDTO {
    
    private int id;
    private int id_deposito_sucursal;
    private int id_articulo;
    private double existencia;
    private double existencia_inicial;
    private double minimo;
    private double maximo;
    private String usu_alta = "";
    private String usu_modi = "";
    private int id_articulo_costo;

    public int getId_articulo_costo() {
        return id_articulo_costo;
    }

    public void setId_articulo_costo(int id_articulo_costo) {
        this.id_articulo_costo = id_articulo_costo;
    }

    public double getExistencia_inicial() {
        return existencia_inicial;
    }

    public void setExistencia_inicial(double existencia_inicial) {
        this.existencia_inicial = existencia_inicial;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_deposito_sucursal() {
        return id_deposito_sucursal;
    }

    public void setId_deposito_sucursal(int id_deposito_sucursal) {
        this.id_deposito_sucursal = id_deposito_sucursal;
    }

    public int getId_articulo() {
        return id_articulo;
    }

    public void setId_articulo(int id_articulo) {
        this.id_articulo = id_articulo;
    }

    public double getExistencia() {
        return existencia;
    }

    public void setExistencia(double existencia) {
        this.existencia = existencia;
    }

    public double getMinimo() {
        return minimo;
    }

    public void setMinimo(double minimo) {
        this.minimo = minimo;
    }

    public double getMaximo() {
        return maximo;
    }

    public void setMaximo(double maximo) {
        this.maximo = maximo;
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
