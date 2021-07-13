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
public class ParametrosSistemaDTO {
    
    private int id;
    private int garantia_venta;
    private String usu_alta;
    private String usu_modi;
    private int interes_moratorio_venta;
    private String timbrado_venta_manual;

    public String getTimbrado_venta_manual() {
        return timbrado_venta_manual;
    }

    public void setTimbrado_venta_manual(String timbrado_venta_manual) {
        this.timbrado_venta_manual = timbrado_venta_manual;
    }

    public int getInteres_moratorio_venta() {
        return interes_moratorio_venta;
    }

    public void setInteres_moratorio_venta(int interes_moratorio_venta) {
        this.interes_moratorio_venta = interes_moratorio_venta;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getGarantia_venta() {
        return garantia_venta;
    }

    public void setGarantia_venta(int garantia_venta) {
        this.garantia_venta = garantia_venta;
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
