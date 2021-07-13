/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.StockDAO;
import DTO.StockDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class StockDAOImp implements StockDAO {

    public StockDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[StockDAOImp.java]";

    @Override
    public String insertar(StockDTO stockDto) {
        String error = "";
        try {
            String sql = "INSERT INTO stock_facturacion.stocks(\n"
                    + "            id_deposito_sucursal, id_articulo, existencia, minimo, maximo, existencia_inicial, \n"
                    + "            usu_alta, fec_alta, id_articulo_costo)\n"
                    + "    VALUES (?, ?, ?, ?, ?, ?, \n"
                    + "            ?, now(), ?);";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, stockDto.getId_deposito_sucursal());
            ps.setObject(2, stockDto.getId_articulo());
            ps.setObject(3, stockDto.getExistencia());
            ps.setObject(4, stockDto.getMinimo());
            ps.setObject(5, stockDto.getMaximo());
            ps.setObject(6, stockDto.getExistencia_inicial());
            ps.setObject(7, stockDto.getUsu_alta());
            ps.setObject(8, stockDto.getId_articulo_costo());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(StockDTO stockDto) {
        String error = "";
        try {
            String sql = "UPDATE stock_facturacion.stocks\n"
                    + "   SET minimo=?, maximo=?, usu_modi=?, fec_modi=now()\n"
                    + " WHERE id_stock=?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, stockDto.getMinimo());
            ps.setObject(2, stockDto.getMaximo());
            ps.setObject(3, stockDto.getUsu_modi());
            ps.setObject(4, stockDto.getId());

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
            String sql = "DELETE FROM stock_facturacion.stocks\n"
                    + " WHERE id_stock = ? ";
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

    @Override
    public String actualizarStockOrigenTraspasoOrigen(StockDTO stockDto) {
        String error = "";
        try {
            String sql = "UPDATE stock_facturacion.stocks SET "
                    + "existencia = existencia - ?,  "
                    + "usu_modi=?, "
                    + "fec_modi=now() "
                    + "WHERE id_stock=? ";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, stockDto.getExistencia());
            ps.setObject(2, stockDto.getUsu_modi());
            ps.setObject(3, stockDto.getId());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String actualizarStockOrigenTraspasoDestino(StockDTO stockDto) {
        String error = "";
        try {
            String sql = "UPDATE stock_facturacion.stocks SET "
                    + "existencia = existencia + ?,  "
                    + "usu_modi=?, "
                    + "fec_modi=now() "
                    + "WHERE id_stock=? ";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, stockDto.getExistencia());
            ps.setObject(2, stockDto.getUsu_modi());
            ps.setObject(3, stockDto.getId());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String insertarStockTraspasoDestino(StockDTO stockDto) {
        String error = "";
        try {
            String sql = "INSERT INTO stock_facturacion.stocks "
                    + "("
                    + "id_deposito_sucursal, "
                    + "id_articulo, "
                    + "existencia, "
                    + "usu_alta, "
                    + "fec_alta, "
                    + "id_articulo_costo "
                    + ") VALUES "
                    + "(?, ?, ?, ?, now(), ?)";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, stockDto.getId_deposito_sucursal());
            ps.setObject(2, stockDto.getId_articulo());
            ps.setObject(3, stockDto.getExistencia());
            ps.setObject(4, stockDto.getUsu_alta());
            ps.setObject(5, stockDto.getId_articulo_costo());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String anulacionStockActualizarTraspasoOrigen(StockDTO stockDto) {
        String error = "";
        try {
            String sql = "UPDATE stock_facturacion.stocks SET "
                    + "existencia = existencia + ?,  "
                    + "usu_modi=?, "
                    + "fec_modi=now() "
                    + "WHERE id_stock=? ";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, stockDto.getExistencia());
            ps.setObject(2, stockDto.getUsu_modi());
            ps.setObject(3, stockDto.getId());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String anulacionStockActualizarTraspasoDestino(StockDTO stockDto) {
        String error = "";
        try {
            String sql = "UPDATE stock_facturacion.stocks SET "
                    + "existencia = existencia - ?,  "
                    + "usu_modi=?, "
                    + "fec_modi=now() "
                    + "WHERE id_stock=? ";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, stockDto.getExistencia());
            ps.setObject(2, stockDto.getUsu_modi());
            ps.setObject(3, stockDto.getId());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

}
