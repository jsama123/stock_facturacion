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
public class ClienteDTO {
    
    private int id = 0;
    private String ci_ruc_cliente = "";
    private String razon_social_cliente = "";
    private String nro_telefono_cliente = "";
    private String direccion_cliente = "";
    private String email_cliente = "";
    private String usu_alta = "";
    private String usu_modi = "";
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCi_ruc_cliente() {
        return ci_ruc_cliente;
    }

    public void setCi_ruc_cliente(String ci_ruc_cliente) {
        this.ci_ruc_cliente = ci_ruc_cliente;
    }

    public String getRazon_social_cliente() {
        return razon_social_cliente;
    }

    public void setRazon_social_cliente(String razon_social_cliente) {
        this.razon_social_cliente = razon_social_cliente;
    }

    public String getNro_telefono_cliente() {
        return nro_telefono_cliente;
    }

    public void setNro_telefono_cliente(String nro_telefono_cliente) {
        this.nro_telefono_cliente = nro_telefono_cliente;
    }

    public String getDireccion_cliente() {
        return direccion_cliente;
    }

    public void setDireccion_cliente(String direccion_cliente) {
        this.direccion_cliente = direccion_cliente;
    }

    public String getEmail_cliente() {
        return email_cliente;
    }

    public void setEmail_cliente(String email_cliente) {
        this.email_cliente = email_cliente;
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
