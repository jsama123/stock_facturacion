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
public class EmpresaDTO {
    
    private int id = 0;
    private String razon_social_empresa = "";
    private String ci_ruc_empresa = "";
    private String direccion_empresa = "";
    private String email_empresa = "";
    private String nro_telefono_provedor = "";
    private String usu_alta = "";
    private String usu_modi = "";
    private String actividad_economica = "";

    public String getActividad_economica() {
        return actividad_economica;
    }

    public void setActividad_economica(String actividad_economica) {
        this.actividad_economica = actividad_economica;
    }
    
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

    public String getCi_ruc_empresa() {
        return ci_ruc_empresa;
    }

    public void setCi_ruc_empresa(String ci_ruc_empresa) {
        this.ci_ruc_empresa = ci_ruc_empresa;
    }

    public String getRazon_social_empresa() {
        return razon_social_empresa;
    }

    public void setRazon_social_empresa(String razon_social_empresa) {
        this.razon_social_empresa = razon_social_empresa;
    }

    public String getDireccion_empresa() {
        return direccion_empresa;
    }

    public void setDireccion_empresa(String direccion_empresa) {
        this.direccion_empresa = direccion_empresa;
    }

    public String getEmail_empresa() {
        return email_empresa;
    }

    public void setEmail_empresa(String email_empresa) {
        this.email_empresa = email_empresa;
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
