using System;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using Marfil.Dom.Persistencia.Model.Interfaces;
using Marfil.Dom.Persistencia.ServicesView.Servicios;
using Resources;
using RCobrosYPagos = Marfil.Inf.ResourcesGlobalization.Textos.Entidades.CobrosYPagos;
using RFacturas = Marfil.Inf.ResourcesGlobalization.Textos.Entidades.Facturas;
using Marfil.Inf.Genericos;

namespace Marfil.Dom.Persistencia.Model.Documentos.CobrosYPagos
{

    public enum TipoVencimiento
    {
        [StringValue(typeof(RCobrosYPagos), "Cobros")]
        Cobros,
        [StringValue(typeof(RCobrosYPagos), "Pagos")]
        Pagos
    }

    public enum TipoOrigen
    {
        [StringValue(typeof(RCobrosYPagos), "EntradaManual")]
        EntradaManual,
        [StringValue(typeof(RCobrosYPagos), "RegIVA")]
        RegIVA,
        [StringValue(typeof(RCobrosYPagos), "FacturaCompra")]
        FacturaCompra,
        [StringValue(typeof(RCobrosYPagos), "FacturaVenta")]
        FacturaVenta,
        [StringValue(typeof(RCobrosYPagos), "FacturaConciliada")]
        FacturaConciliada,
        [StringValue(typeof(RCobrosYPagos), "ConciliarAsiento")]
        ConciliarAsiento      
    }

    public enum TipoEstado
    {
        [StringValue(typeof(RCobrosYPagos), "Inicial")]
        Inicial,
        [StringValue(typeof(RCobrosYPagos), "Cubierto")]
        CubiertoParcial,
        [StringValue(typeof(RCobrosYPagos), "Total")]
        Total
    }

    public enum TipoSituacion
    {
        [StringValue(typeof(RCobrosYPagos), "Inicial")]
        Inicial,
        [StringValue(typeof(RCobrosYPagos), "Pagado")]
        Pagado
    }


    public class VencimientosModel : BaseModel<VencimientosModel, Persistencia.Vencimientos>
    {

        #region CTR
        public VencimientosModel()
        {
        }

        public VencimientosModel(IContextService context) : base(context)
        {
        }
        #endregion

        #region properties

        public int? Id { get; set; }

        public string Empresa { get; set; }

        //Factura a la que hace referecia
        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Fkfacturas")]
        public String Traza { get; set; }

        //Cobros o Pagos (C/P)
        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Tipo")]
        public TipoVencimiento Tipo { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Origen")]
        public TipoOrigen Origen { get; set; }

        [Display(ResourceType = typeof(RFacturas), Name = "Fkformaspago")]
        public int? Fkformaspago { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Usuario")]
        public String Usuario { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Fkcuentas")]
        public string Fkcuentas { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Fechacreacion")]
        public DateTime? Fechacreacion { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Fechafactura")]
        public DateTime? Fechafactura { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Fecharegistrofactura")]
        public DateTime? Fecharegistrofactura { get; set; }

        [Required]
        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Fechavencimiento")]
        public DateTime? Fechavencimiento { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Fechadescuento")]
        public DateTime? Fechadescuento { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Fechapago")]
        public DateTime? Fechapago { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Monedabase")]
        public int Monedabase { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Monedagiro")]
        public int Monedagiro { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Importegiro")]
        public double Importegiro { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Cambioaplicado")]
        public double Cambioaplicado { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Importefactura")]
        public double Importefactura { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Monedafactura")]
        public int Monedafactura { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Fkcuentastesoreria")]
        public String Fkcuentatesoreria { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Mandato")]
        public String Mandato { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Importeasignado")]
        public double Importeasignado { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Importepagado")]
        public double Importepagado { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Estado")]
        public TipoEstado Estado { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Situación")]
        public String Situacion { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Comentario")]
        public String Comentario { get; set; }

        public string urlDocumento { get; set; }

        #endregion


        #region atributos

        public override object generateId(string id)
        {
            return id;
        }

        public override void createNewPrimaryKey()
        {
            primaryKey = getProperties().Where(f => f.property.Name.ToLower() == "id").Select(f => f.property);
        }

        public override string GetPrimaryKey()
        {
            return Id.ToString();
        }

        public string CambiarNombre { get; set; }

        public override string DisplayName => CambiarNombre;

        #endregion
    }


    public class CarteraVencimientosModel : BaseModel<CarteraVencimientosModel, Persistencia.CarteraVencimientos>
    {

        #region CTR
        public CarteraVencimientosModel()
        {
        }

        public CarteraVencimientosModel(IContextService context) : base(context)
        {
        }
        #endregion

        #region properties

        public int? Id { get; set; }

        public string Empresa { get; set; }

        //Factura a la que hace referecia
        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Fkfacturas")]
        public String Traza { get; set; }

        //Cobros o Pagos (C/P)
        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Tipo")]
        public TipoVencimiento Tipo { get; set; }

        [Display(ResourceType = typeof(RFacturas), Name = "Fkformaspago")]
        public int? Fkformaspago { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Usuario")]
        public String Usuario { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Fkcuentas")]
        public string Fkcuentas { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Fechacreacion")]
        public DateTime? Fechacreacion { get; set; }

        [Required]
        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Fechavencimiento")]
        public DateTime? Fechavencimiento { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Fechadescuento")]
        public DateTime? Fechadescuento { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Fechapago")]
        public DateTime? Fechapago { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Monedabase")]
        public int Monedabase { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Monedagiro")]
        public int Monedagiro { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Importegiro")]
        public double Importegiro { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Cambioaplicado")]
        public double Cambioaplicado { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Fkcuentastesoreria")]
        public String Fkcuentatesoreria { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Mandato")]
        public String Mandato { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Situación")]
        public String Situacion { get; set; }

        [Display(ResourceType = typeof(RCobrosYPagos), Name = "Comentario")]
        public String Comentario { get; set; }

        public string urlDocumento { get; set; }

        public String Codigoremesa { get; set; }

        public int Tiponumerofactura { get; set; }

        #endregion


        #region atributos

        public override object generateId(string id)
        {
            return id;
        }

        public override void createNewPrimaryKey()
        {
            primaryKey = getProperties().Where(f => f.property.Name.ToLower() == "id").Select(f => f.property);
        }

        public override string GetPrimaryKey()
        {
            return Id.ToString();
        }

        public override string DisplayName => RCobrosYPagos.TituloCartera;

        #endregion
    }

}
