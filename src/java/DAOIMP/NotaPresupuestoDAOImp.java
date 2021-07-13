/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.NotaPresupuestoDAO;
import DTO.NotaPresupuestoDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author jose-samaniego
 */
public class NotaPresupuestoDAOImp implements NotaPresupuestoDAO {

    public NotaPresupuestoDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[NotaPresupuestoDAOImp.java]";

    @Override
    public String insertar(NotaPresupuestoDTO notaPresupuestoDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.nota_presupuesto(\n"
                    + "            id_cliente, fecha_presupuesto, nro_nota_presupuesto, \n"
                    + "            observacion_presupuesto, usu_alta, fec_alta)\n"
                    + "    VALUES (?, ?, ?, \n"
                    + "            ?, ?, now());";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, notaPresupuestoDto.getId_cliente());
            ps.setObject(2, notaPresupuestoDto.getFecha_presupuesto());
            ps.setObject(3, notaPresupuestoDto.getNro_nota_presupuesto());
            ps.setObject(4, notaPresupuestoDto.getObservacion_presupuesto());
            ps.setObject(5, notaPresupuestoDto.getUsu_alta());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(NotaPresupuestoDTO notaPresupuestoDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.nota_presupuesto\n"
                    + "   SET id_cliente=?, fecha_presupuesto=?, \n"
                    + "       observacion_presupuesto=?, usu_modi=?, \n"
                    + "       fec_modi=now()\n"
                    + " WHERE id_nota_presupuesto=?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, notaPresupuestoDto.getId_cliente());
            ps.setObject(2, notaPresupuestoDto.getFecha_presupuesto());
            ps.setObject(3, notaPresupuestoDto.getObservacion_presupuesto());
            ps.setObject(4, notaPresupuestoDto.getUsu_modi());
            ps.setObject(5, notaPresupuestoDto.getId());

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
            String sql = " DELETE FROM stock_facturacion.nota_presupuesto\n" +
" WHERE id_nota_presupuesto = ?";
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
