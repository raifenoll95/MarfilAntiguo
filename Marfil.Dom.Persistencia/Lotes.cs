//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Marfil.Dom.Persistencia
{
    using System;
    using System.Collections.Generic;
    
    public partial class Lotes
    {
        public string empresa { get; set; }
        public long id { get; set; }
        public string Articulo { get; set; }
        public string Codarticulo { get; set; }
        public string lote { get; set; }
        public string loteid { get; set; }
        public double CantidadProduccion { get; set; }
        public double LargoProduccion { get; set; }
        public double AnchoProduccion { get; set; }
        public double GruesoProduccion { get; set; }
        public Nullable<double> MetrosProduccion { get; set; }
        public string Unidades { get; set; }
        public int Decimales { get; set; }
        public string Kit { get; set; }
        public string Bundle { get; set; }
        public string codigoproveedor { get; set; }
        public Nullable<System.DateTime> fechaentrada { get; set; }
        public Nullable<double> precioentrada { get; set; }
        public Nullable<int> codigodocumentoentrada { get; set; }
        public Nullable<double> cantidadentrada { get; set; }
        public Nullable<double> largoentrada { get; set; }
        public Nullable<double> anchoentrada { get; set; }
        public Nullable<double> gruesoentrada { get; set; }
        public Nullable<double> MetrosEntrada { get; set; }
        public Nullable<double> netocompra { get; set; }
        public Nullable<double> preciovaloracion { get; set; }
        public string codigocliente { get; set; }
        public Nullable<System.DateTime> fechasalida { get; set; }
        public Nullable<double> preciosalida { get; set; }
        public Nullable<int> codigodocumentosalida { get; set; }
        public Nullable<double> cantidadsalida { get; set; }
        public Nullable<double> largosalida { get; set; }
        public Nullable<double> anchosalida { get; set; }
        public Nullable<double> gruesosalida { get; set; }
        public Nullable<double> MetrosSalida { get; set; }
        public Nullable<double> CantidadDisponible { get; set; }
        public Nullable<double> MetrosDisponibles { get; set; }
        public int EnStock { get; set; }
        public Nullable<int> tipoalmacenlote { get; set; }
    }
}
