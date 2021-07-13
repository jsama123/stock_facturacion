/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.NotaPresupuestoDAO;
import DAO.NotaPresupuestoDetalleDAO;
import DTO.NotaPresupuestoDTO;
import DTO.NotaPresupuestoDetalleDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author jose-samaniego
 */
public class NotaPresupuestoDetalleDAOImp implements NotaPresupuestoDetalleDAO {

    public NotaPresupuestoDetalleDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[NotaPresupuestoDAOImp.java]";

    @Override
    public String insertar(NotaPresupuestoDetalleDTO notaPresupuestoDto) {
        String error = "";
        try {
            String sql = "INSERT INTO stock_facturacion.nota_presupuesto_detalle(\n"
                    + "            id_nota_presupuesto, id_articulo, \n"
                    + "            cantidad, desc_aplicado, iva_aplicado, precio_aplicado, usu_alta, \n"
                    + "            fec_alta)\n"
                    + "    VALUES (?, ?, \n"
                    + "            ?, ?, ?, ?, ?, \n"
                    + "            now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, notaPresupuestoDto.getId_nota_presupuesto());
            ps.setObject(2, notaPresupuestoDto.getId_articulo());
            ps.setObject(3, notaPresupuestoDto.getCantidad());
            ps.setObject(4, notaPresupuestoDto.getDesc_aplicado());
            ps.setObject(5, notaPresupuestoDto.getIva_aplicado());
            ps.setObject(6, notaPresupuestoDto.getPrecio_aplicado());
            ps.setObject(7, notaPresupuestoDto.getUsu_alta());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    public String modificar(NotaPresupuestoDetalleDTO notaPresupuestoDto) {
        String error = "";
        try {
            String sql = "UPDATE stock_facturacion.nota_presupuesto_detalle\n"
                    + "   SET id_nota_presupuesto=?, id_articulo=?, \n"
                    + "       cantidad=?, desc_aplicado=?, iva_aplicado=?, precio_aplicado=?, \n"
                    + "        usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_nota_presupuesto_detalle=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, notaPresupuestoDto.getId_nota_presupuesto());
            ps.setObject(2, notaPresupuestoDto.getId_articulo());
            ps.setObject(3, notaPresupuestoDto.getCantidad());
            ps.setObject(4, notaPresupuestoDto.getDesc_aplicado());
            ps.setObject(5, notaPresupuestoDto.getIva_aplicado());
            ps.setObject(6, notaPresupuestoDto.getPrecio_aplicado());
            ps.setObject(7, notaPresupuestoDto.getUsu_alta());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String eliminar(Integer id) {
        String error = "";
        try {
            String sql = " DELETE FROM stock_facturacion.nota_presupuesto_detalle\n"
                    + " WHERE id_nota_presupuesto_detalle = ?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, id);

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public void crearConexion(Connection cn) {
        this.cn = cn;
    }

}
