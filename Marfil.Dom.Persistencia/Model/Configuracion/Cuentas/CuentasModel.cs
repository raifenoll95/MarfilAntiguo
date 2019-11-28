﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Marfil.Dom.ControlsUI.Bloqueo;
using Marfil.Dom.ControlsUI.NifCif;
using Marfil.Dom.Persistencia.Model.Interfaces;
using Marfil.Dom.Persistencia.ServicesView.Servicios;
using Resources;
using RCuentas = Marfil.Inf.ResourcesGlobalization.Textos.Entidades.Cuentas;
namespace Marfil.Dom.Persistencia.Model.Configuracion.Cuentas
{
    [Serializable]
    public class CuentasModel : BaseModel<CuentasModel, Persistencia.Cuentas>
    {

        #region Properties
        [Required]
        public string Empresa { get; set; }

        [Required]
        [Display(ResourceType = typeof(RCuentas), Name = "Id")]
        [MaxLength(15, ErrorMessageResourceType = typeof(Unobtrusive), ErrorMessageResourceName = "MaxLength")]
        public string Id { get; set; }

        [Display(ResourceType = typeof(RCuentas), Name = "Descripcion2")]
        public string Descripcion2 { get; set; }

        [Required]
        [Display(ResourceType = typeof(RCuentas), Name = "Descripcion")]
        public string Descripcion { get; set; }

        [Required]
        [Display(ResourceType = typeof(RCuentas), Name = "Nivel")]
        public int Nivel { get; set; }

        [Display(ResourceType = typeof(RCuentas), Name = "Tiposcuentas")]
        public int? Tiposcuentas { get; set; }

        [Display(ResourceType = typeof(RCuentas), Name = "FkPais")]
        public string FkPais { get; set; }

        [Display(ResourceType = typeof(RCuentas), Name = "Nifrequired")]
        public bool Nifrequired { get; set; }


        [Display(ResourceType = typeof(RCuentas), Name = "Nif")]
        public NifCifModel Nif { get; set; }

        [Display(ResourceType = typeof(RCuentas), Name = "Contrapartida")]
        public string Contrapartida { get; set; }

        [Display(ResourceType = typeof(RCuentas), Name = "ContrapartidaDescripcion")]
        public string ContrapartidaDescripcion { get; set; }

        //bloqueo

        [Display(ResourceType = typeof(RCuentas), Name = "BloqueoModel")]
        public BloqueoEntidadModel BloqueoModel { get; set; }

        public bool Bloqueado
        {
            get { return BloqueoModel?.Bloqueada ?? false; }
        }

        [Display(ResourceType = typeof(RCuentas), Name = "Usuario")]
        public string Usuario { get; set; }

        public string UsuarioId { get; set; }

        [Display(ResourceType = typeof(RCuentas), Name = "DescripcionLarga")]
        public string DescripcionLarga
        {
            get { return Id + " - " + Descripcion; }
        }

        [Display(ResourceType = typeof(RCuentas), Name = "FechaModificacion")]
        public DateTime FechaModificacion { get; set; }

        #endregion

        #region CTR

        public CuentasModel()
        {

        }

        public CuentasModel(IContextService context) : base(context)
        {

        }

        #endregion

        public override object generateId(string id)
        {
            return id;
        }

        public override string GetPrimaryKey()
        {
            return Id;
        }

        public override string DisplayName => RCuentas.TituloEntidad;
        public DateTime Fechaalta { get; set; }
    }
}
