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
public class DepositoDTO {
    
    private int id = 0;
    private String deposito_descripcion = "";
    private int id_sucursal;
    private String usu_alta = "";
    private String usu_modi = "";
    private boolean deposito_comercial;

    public boolean isDeposito_comercial() {
        return deposito_comercial;
    }

    public void setDeposito_comercial(boolean deposito_comercial) {
        this.deposito_comercial = deposito_comercial;
    }

    public int getId_sucursal() {
        return id_sucursal;
    }

    public void setId_sucursal(int id_sucursal) {
        this.id_sucursal = id_sucursal;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDeposito_descripcion() {
        return deposito_descripcion;
    }

    public void setDeposito_descripcion(String deposito_descripcion) {
        this.deposito_descripcion = deposito_descripcion;
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
