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
    
    public partial class CircuitosTesoreriaCobros
    {
        public string empresa { get; set; }
        public int id { get; set; }
        public string descripcion { get; set; }
        public string situacioninicial { get; set; }
        public string situacionfinal { get; set; }
        public Nullable<int> datos { get; set; }
        public Nullable<bool> asientocontable { get; set; }
        public Nullable<bool> fecharemesa { get; set; }
        public Nullable<bool> fechapago { get; set; }
        public Nullable<bool> liquidariva { get; set; }
        public Nullable<bool> conciliacion { get; set; }
        public Nullable<bool> datosdocumento { get; set; }
        public string cuentacargo1 { get; set; }
        public string cuentacargo2 { get; set; }
        public string cuentacargorel { get; set; }
        public string cuentaabono1 { get; set; }
        public string cuentaabono2 { get; set; }
        public string cuentaabonorel { get; set; }
        public Nullable<int> importecuentacargo1 { get; set; }
        public Nullable<int> importecuentacargo2 { get; set; }
        public Nullable<int> importecuentaabono1 { get; set; }
        public Nullable<int> importecuentaabono2 { get; set; }
        public Nullable<int> importecuentacargorel { get; set; }
        public Nullable<int> importecuentaabonorel { get; set; }
        public string desccuentacargo1 { get; set; }
        public string desccuentacargo2 { get; set; }
        public string desccuentacargorel { get; set; }
        public string desccuentaabono1 { get; set; }
        public string desccuentaabono2 { get; set; }
        public string desccuentaabonorel { get; set; }
        public Nullable<int> tipocircuito { get; set; }
        public string codigodescripcionasiento { get; set; }
        public Nullable<bool> documentocartera { get; set; }
        public Nullable<bool> actualizarcobrador { get; set; }
    }
}
