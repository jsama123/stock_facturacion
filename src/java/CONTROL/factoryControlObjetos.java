/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.AjustesStockDAO;
import DAO.ArqueoCajaDAO;
import DAO.ArqueoCajaDetalleDAO;
import DAO.ArticuloCostoDAO;
import DAO.ArticuloDAO;
import DAO.CajaDAO;
import DAO.CajeroDAO;
import DAO.ClienteDAO;
import DAO.CompraCreditoDAO;
import DAO.CompraDAO;
import DAO.CompraDetalleDAO;
import DAO.DepositoDAO;
import DAO.EmpresaDAO;
import DAO.GastoDAO;
import DAO.GrupoDAO;
import DAO.ImpuestoDAO;
import DAO.ListaPrecioDAO;
import DAO.MalogradoDAO;
import DAO.MarcaDAO;
import DAO.MedidaDAO;
import DAO.NotaCreditoDAO;
import DAO.NotaCreditoDetalleDAO;
import DAO.NotaPresupuestoDAO;
import DAO.NotaPresupuestoDetalleDAO;
import DAO.ParametroCuotaVentaDAO;
import DAO.ParametroSistemaDAO;
import DAO.ProveedorDAO;
import DAO.StockDAO;
import DAO.SucursalDAO;
import DAO.TimbradoDAO;
import DAO.TraspasoDAO;
import DAO.TraspasoDetalleDAO;
import DAO.UsuarioDAO;
import DAO.VendedorDAO;
import DAO.VentaCreditoDAO;
import DAO.VentaDAO;
import DAO.VentaDetalleDAO;
import DAO.VentaManualDAO;
import DAO.VentaManualDetalleDAO;
import DAOIMP.AjustesStockDAOImp;
import DAOIMP.ArqueoCajaDAOImp;
import DAOIMP.ArqueoCajaDetalleDAOImp;
import DAOIMP.ArticuloCostoDAOImp;
import DAOIMP.ArticuloDAOImp;
import DAOIMP.CajaDAOImp;
import DAOIMP.CajeroDAOImp;
import DAOIMP.ClienteDAOImp;
import DAOIMP.CompraCreditoDAOImp;
import DAOIMP.CompraDAOImp;
import DAOIMP.CompraDetalleDAOImp;
import DAOIMP.DepositoDAOImp;
import DAOIMP.EmpresaDAOImp;
import DAOIMP.GastoDAOImp;
import DAOIMP.GrupoDAOImp;
import DAOIMP.ImpuestoDAOImp;
import DAOIMP.ListaPrecioDAOImp;
import DAOIMP.MalogradoDAOImp;
import DAOIMP.MarcaDAOImp;
import DAOIMP.MedidaDAOImp;
import DAOIMP.NotaCreditoDAOImp;
import DAOIMP.NotaCreditoDetalleDAOImp;
import DAOIMP.NotaPresupuestoDAOImp;
import DAOIMP.NotaPresupuestoDetalleDAOImp;
import DAOIMP.ParametroCuotaVentaDAOImp;
import DAOIMP.ParametroSistemaDAOImp;
import DAOIMP.ProveedorDAOImp;
import DAOIMP.StockDAOImp;
import DAOIMP.SucursalDAOImp;
import DAOIMP.TimbradoDAOImp;
import DAOIMP.TraspasoDAOImp;
import DAOIMP.TraspasoDetalleDAOImp;
import DAOIMP.UsuarioDAOImp;
import DAOIMP.VendedorDAOImp;
import DAOIMP.VentaCreditoDAOImp;
import DAOIMP.VentaDAOImp;
import DAOIMP.VentaDetalleDAOImp;
import DAOIMP.VentaManualDAOImp;
import DAOIMP.VentaManualDetalleDAOImp;

/**
 *
 * @author Jose Samaniego
 */
public class factoryControlObjetos {

    public factoryControlObjetos() {
    }
    
    
    public MarcaDAO crearObjetoMarca(){
        return new MarcaDAOImp();
    }
    
    public  MedidaDAO crearObjetoMedida(){
        return new MedidaDAOImp();
    }
    
    public GrupoDAO crearObjetoGrupo(){
        return new GrupoDAOImp();
    }
    
    public DepositoDAO crearObjetoDeposito(){
        return new DepositoDAOImp();
    }
    
    public ClienteDAO crearObjetoCliente(){
        return new ClienteDAOImp();
    }
    
    public ProveedorDAO crearObjetoProveedor(){
        return new ProveedorDAOImp();
    }
    
    public ArticuloDAO crearObjetoArticulo(){
        return new ArticuloDAOImp();
    }
    
    public ListaPrecioDAO crearObjetoListaPrecio() {
        return new ListaPrecioDAOImp(); 
    }
    
    public StockDAO crearObjetoStock() {
        return new StockDAOImp();
    }
    
    public CajaDAO crearObjetoCaja(){
        return new CajaDAOImp(); 
    }
    
    public SucursalDAO crearObjetoSucursal(){
        return new SucursalDAOImp();
    }
    
    public ImpuestoDAO crearObjetoImpuesto(){
        return new ImpuestoDAOImp();
    }
    
    public VendedorDAO crearObjetoVendedor(){
        return new VendedorDAOImp();
    }
    
    public UsuarioDAO crearObjetoUsuario(){
        return new UsuarioDAOImp();
    }
    
    public TimbradoDAO crearObjetoTimbrado(){
        return new TimbradoDAOImp();
    }
    
    public EmpresaDAO crearObjetoEmpresa(){
        return new EmpresaDAOImp();
    }
    
    public CajeroDAO crearObjetoCajero(){
        return new CajeroDAOImp();
    }
    
    public ArqueoCajaDAO crearObjetoArqueoCaja(){
        return new ArqueoCajaDAOImp();
    }
    
    public ArqueoCajaDetalleDAO crearObjetoArqueoCajaDetalle(){
        return new ArqueoCajaDetalleDAOImp();
    }
    
    public VentaDAO crearObjetoVenta(){
        return new VentaDAOImp();
    }
    
    public VentaDetalleDAO crearObjetoVentaDetalle(){
        return new VentaDetalleDAOImp();
    }
    
    public VentaManualDAO crearObjetoVentaManual(){
        return new VentaManualDAOImp();
    }
    
    public VentaManualDetalleDAO crearObjetoVentaManualDetalle(){
        return new VentaManualDetalleDAOImp();
    }
    
    public CompraDAO crearObjetoCompra() {
        return new CompraDAOImp();
    }
    
    public CompraDetalleDAO crearObjetoCompraDetalle(){
        return new CompraDetalleDAOImp();
    }
    
    public ParametroSistemaDAO crearObjetoParametroSistema(){
        return new ParametroSistemaDAOImp();
    }
    
    public NotaCreditoDAO crearObjetoNotaCredito(){
        return new NotaCreditoDAOImp();
    }
    
    public NotaCreditoDetalleDAO crearObjetoNotaCreditoDetalle(){
        return new NotaCreditoDetalleDAOImp();
    }
    
    public GastoDAO crearObjetoGasto(){
        return new GastoDAOImp();
    }
    
    public CompraCreditoDAO crearObjetoCompraCredito(){
        return new CompraCreditoDAOImp();
    }
    
    public TraspasoDAO crearObjetoTraspaso(){
        return new TraspasoDAOImp();
    }
    
    public TraspasoDetalleDAO crearObjetoTraspasoDetalle(){
        return new TraspasoDetalleDAOImp();
    }
    
    public AjustesStockDAO crearObjetoAjustesStock(){
        return new AjustesStockDAOImp();
    }
    
    public MalogradoDAO crearObjetoMalogrado(){
        return new MalogradoDAOImp();
    }
    
    public NotaPresupuestoDAO crearObjetoNotaPresupuesto(){
        return new NotaPresupuestoDAOImp();
    }
    
    public NotaPresupuestoDetalleDAO crearObjetoNotaPresupuestoDetalle(){
        return new NotaPresupuestoDetalleDAOImp();
    }
    
    public ParametroCuotaVentaDAO crearObjetoParametroCuotaVenta(){
        return new ParametroCuotaVentaDAOImp();
    }
    
    public VentaCreditoDAO crearObjetoVentaCredito(){
        return new VentaCreditoDAOImp();
    }
    
    public ArticuloCostoDAO crearObjetoArticuloCosto(){
        return new ArticuloCostoDAOImp();
    }
 }
