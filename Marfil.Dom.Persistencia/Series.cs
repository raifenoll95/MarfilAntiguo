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
    
    public partial class Series
    {
        public string empresa { get; set; }
        public string tipodocumento { get; set; }
        public string id { get; set; }
        public string descripcion { get; set; }
        public Nullable<int> fkmonedas { get; set; }
        public string fkregimeniva { get; set; }
        public string fkcontadores { get; set; }
        public string fkejercicios { get; set; }
        public Nullable<int> tipoimpresion { get; set; }
        public Nullable<bool> riesgo { get; set; }
        public Nullable<bool> exentoiva { get; set; }
        public Nullable<bool> borrador { get; set; }
        public Nullable<bool> rectificativa { get; set; }
        public string fkseriesasociada { get; set; }
        public Nullable<System.DateTime> fechamodificacionbloqueo { get; set; }
        public Nullable<System.Guid> fkusuariobloqueo { get; set; }
        public Nullable<bool> bloqueada { get; set; }
        public string fkmotivosbloqueo { get; set; }
        public Nullable<int> tipoalmacenlote { get; set; }
        public Nullable<bool> entradasvarias { get; set; }
        public Nullable<bool> salidasvarias { get; set; }
    }
}