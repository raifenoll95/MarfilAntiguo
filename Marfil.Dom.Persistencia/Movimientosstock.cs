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
    
    public partial class Movimientosstock
    {
        public string empresa { get; set; }
        public long id { get; set; }
        public System.DateTime fecha { get; set; }
        public string fkalmacenes { get; set; }
        public string fkarticulos { get; set; }
        public string referenciaproveedor { get; set; }
        public string lote { get; set; }
        public string loteid { get; set; }
        public string tag { get; set; }
        public string fkunidadesmedida { get; set; }
        public double cantidad { get; set; }
        public double largo { get; set; }
        public double ancho { get; set; }
        public double grueso { get; set; }
        public string documentomovimiento { get; set; }
        public System.Guid integridadreferencialflag { get; set; }
        public string fkcontadorlote { get; set; }
        public Nullable<System.Guid> fkusuarios { get; set; }
        public Nullable<int> tipooperacion { get; set; }
        public Nullable<int> fkalmaceneszona { get; set; }
        public string fkcalificacioncomercial { get; set; }
        public string fktipograno { get; set; }
        public string fktonomaterial { get; set; }
        public string fkincidenciasmaterial { get; set; }
        public string fkvariedades { get; set; }
        public Nullable<double> costeadicionalmaterial { get; set; }
        public Nullable<double> costeadicionalportes { get; set; }
        public Nullable<double> costeadicionalotro { get; set; }
        public Nullable<double> costeacicionalvariable { get; set; }
        public int categoriamovimiento { get; set; }
        public Nullable<int> tipoalmacenlote { get; set; }
        public Nullable<int> Tipomovimiento { get; set; }
    }
}
