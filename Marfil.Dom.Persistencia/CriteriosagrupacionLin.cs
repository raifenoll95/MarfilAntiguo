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
    
    public partial class CriteriosagrupacionLin
    {
        public string fkcriteriosagrupacion { get; set; }
        public int id { get; set; }
        public int campo { get; set; }
        public Nullable<int> orden { get; set; }
    
        public virtual Criteriosagrupacion Criteriosagrupacion { get; set; }
    }
}
