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
    
    public partial class Ficheros
    {
        public string empresa { get; set; }
        public System.Guid id { get; set; }
        public string nombre { get; set; }
        public string descripcion { get; set; }
        public string ruta { get; set; }
        public string tipo { get; set; }
        public System.Guid fkcarpetas { get; set; }
    
        public virtual Carpetas Carpetas { get; set; }
    }
}
