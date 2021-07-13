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
public class ProveedorDTO {
    
    private int id = 0;
    private String ci_ruc_cliente = "";
    private String razon_social_proveedor = "";
    private String ci_ruc_proveedor = "";
    private String direccion_proveedor = "";
    private String email_proveedor = "";
    private String nro_telefono_provedor = "";
    private String usu_alta = "";
    private String usu_modi = "";

    public String getNro_telefono_provedor() {
        return nro_telefono_provedor;
    }

    public void setNro_telefono_provedor(String nro_telefono_provedor) {
        this.nro_telefono_provedor = nro_telefono_provedor;
    }

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

    public String getRazon_social_proveedor() {
        return razon_social_proveedor;
    }

    public void setRazon_social_proveedor(String razon_social_proveedor) {
        this.razon_social_proveedor = razon_social_proveedor;
    }

    public String getCi_ruc_proveedor() {
        return ci_ruc_proveedor;
    }

    public void setCi_ruc_proveedor(String ci_ruc_proveedor) {
        this.ci_ruc_proveedor = ci_ruc_proveedor;
    }

    public String getDireccion_proveedor() {
        return direccion_proveedor;
    }

    public void setDireccion_proveedor(String direccion_proveedor) {
        this.direccion_proveedor = direccion_proveedor;
    }

    public String getEmail_proveedor() {
        return email_proveedor;
    }

    public void setEmail_proveedor(String email_proveedor) {
        this.email_proveedor = email_proveedor;
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
