//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Marfil.Dom.Persistencia
{
    using System;
    using System.Collections.Generic;
    
    public partial class PedidosLin
    {
        public string empresa { get; set; }
        public int fkpedidos { get; set; }
        public int id { get; set; }
        public string fkarticulos { get; set; }
        public string descripcion { get; set; }
        public string lote { get; set; }
        public Nullable<int> tabla { get; set; }
        public Nullable<double> cantidad { get; set; }
        public Nullable<double> cantidadpedida { get; set; }
        public Nullable<double> largo { get; set; }
        public Nullable<double> ancho { get; set; }
        public Nullable<double> grueso { get; set; }
        public string fkunidades { get; set; }
        public Nullable<double> metros { get; set; }
        public Nullable<double> precio { get; set; }
        public Nullable<double> porcentajedescuento { get; set; }
        public Nullable<double> importedescuento { get; set; }
        public string fktiposiva { get; set; }
        public Nullable<double> porcentajeiva { get; set; }
        public Nullable<double> cuotaiva { get; set; }
        public Nullable<double> porcentajerecargoequivalencia { get; set; }
        public Nullable<double> cuotarecargoequivalencia { get; set; }
        public Nullable<double> importe { get; set; }
        public string notas { get; set; }
        public string documentoorigen { get; set; }
        public string documentodestino { get; set; }
        public string canal { get; set; }
        public Nullable<double> precioanterior { get; set; }
        public string revision { get; set; }
        public Nullable<int> decimalesmonedas { get; set; }
        public Nullable<int> decimalesmedidas { get; set; }
        public Nullable<int> labor1l1 { get; set; }
        public string labor2l1 { get; set; }
        public string labor3l1 { get; set; }
        public string labor4l1 { get; set; }
        public Nullable<int> labor1l2 { get; set; }
        public string labor2l2 { get; set; }
        public string labor3l2 { get; set; }
        public string labor4l2 { get; set; }
        public Nullable<int> labor1l3 { get; set; }
        public string labor2l3 { get; set; }
        public string labor3l3 { get; set; }
        public string labor4l3 { get; set; }
        public Nullable<int> labor1l4 { get; set; }
        public string labor2l4 { get; set; }
        public string labor3l4 { get; set; }
        public string labor4l4 { get; set; }
        public string bundle { get; set; }
        public Nullable<int> tblnum { get; set; }
        public Nullable<int> caja { get; set; }
        public Nullable<int> fkpresupuestos { get; set; }
        public Nullable<int> fkpresupuestosid { get; set; }
        public string fkpresupuestosreferencia { get; set; }
        public Nullable<int> orden { get; set; }
    
        public virtual Pedidos Pedidos { get; set; }
    }
}
