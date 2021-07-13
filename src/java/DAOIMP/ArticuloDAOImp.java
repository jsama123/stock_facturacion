/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAOIMP;

import DAO.ArticuloDAO;
import DTO.ArticuloDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Jose Samaniego
 */
public class ArticuloDAOImp implements ArticuloDAO {

    public ArticuloDAOImp() {
    }

    Connection cn;
    private String nombre_fichero = "[ArticuloDAOImp.java]";

    @Override
    public String insertar(ArticuloDTO articuloDto) {
        String error = "";
        try {
            String sql = " INSERT INTO stock_facturacion.articulos(\n"
                    + "            id_impuesto, id_marca, id_medida, id_grupo, codigo_barra, articulo_descripcion, \n"
                    + "            usu_alta, fec_alta, \n"
                    + "            fecha_vencimiento)\n"
                    + "    VALUES (?, ?, ?, ?, ?, ?, ?, now(), ?);";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, articuloDto.getId_impuesto());
            ps.setObject(2, articuloDto.getId_marca());
            ps.setObject(3, articuloDto.getId_medida());
            ps.setObject(4, articuloDto.getId_grupo());
            ps.setObject(5, articuloDto.getCodigo_barra());
            ps.setObject(6, articuloDto.getArticulo_descripcion().toUpperCase());
            ps.setObject(7, articuloDto.getUsu_alta());
            ps.setObject(8, articuloDto.getFecha_vencimiento());
            
            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

    @Override
    public String modificar(ArticuloDTO articuloDto) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.articulos\n"
                    + "   SET id_marca=?, id_medida=?, id_grupo=?, codigo_barra=?, \n"
                    + "       articulo_descripcion=?, usu_modi=?, fec_modi=now(), fecha_vencimiento=?, "
                    + "id_impuesto = ? "
                    + " WHERE id_articulo = ?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, articuloDto.getId_marca());
            ps.setObject(2, articuloDto.getId_medida());
            ps.setObject(3, articuloDto.getId_grupo());
            ps.setObject(4, articuloDto.getCodigo_barra());
            ps.setObject(5, articuloDto.getArticulo_descripcion().toUpperCase());
            ps.setObject(6, articuloDto.getUsu_modi());
            ps.setObject(7, articuloDto.getFecha_vencimiento());
            ps.setObject(8, articuloDto.getId_impuesto());
            ps.setObject(9, articuloDto.getId());

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
            String sql = " DELETE FROM stock_facturacion.articulos\n"
                    + " WHERE id_articulo = ?;";
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
    public String actualizarCostoArticulo(ArticuloDTO articuloDTO) {
        String error = "";
        try {
            String sql = " UPDATE stock_facturacion.articulos\n"
                    + "   SET usu_modi=?, fec_modi=now(), costo_articulo = ? "
                    + " WHERE id_articulo = ?;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setObject(1, articuloDTO.getUsu_modi());
            ps.setObject(2, articuloDTO.getCosto_articulo());
            ps.setObject(3, articuloDTO.getId());

            int resultado = ps.executeUpdate();
        } catch (Exception e) {
            String error2 = nombre_fichero + " ERROR : " + e.toString();
            System.out.println(error2);
            error = "Ha ocurrido un error al insertar los datos.-";
        }
        return error;
    }

}
