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
    
    public partial class MaterialesLin
    {
        public string empresa { get; set; }
        public string fkmateriales { get; set; }
        public string codigovariedad { get; set; }
        public string descripcion { get; set; }
        public string descripcion2 { get; set; }
    
        public virtual Materiales Materiales { get; set; }
    }
}