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
    
    public partial class AlmacenesZona
    {
        public string empresa { get; set; }
        public string fkalmacenes { get; set; }
        public int id { get; set; }
        public string descripcion { get; set; }
        public string fktipoubicacion { get; set; }
        public string coordenadas { get; set; }
    
        public virtual Almacenes Almacenes { get; set; }
    }
}
