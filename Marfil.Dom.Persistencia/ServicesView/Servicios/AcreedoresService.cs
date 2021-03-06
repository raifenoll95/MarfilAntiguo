using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;
using Marfil.Dom.Persistencia.Model;
using Marfil.Dom.ControlsUI.BusquedaTerceros;
using Marfil.Dom.Persistencia.Model.Configuracion.Cuentas;
using Marfil.Dom.Persistencia.Model.Interfaces;
using Marfil.Dom.Persistencia.Model.Terceros;
using Marfil.Dom.Persistencia.ServicesView.Interfaces;
using Marfil.Dom.Persistencia.ServicesView.Servicios.Converter;
using Marfil.Inf.Genericos.Helper;

namespace Marfil.Dom.Persistencia.ServicesView.Servicios
{
    public interface IAcreedoresService
    {
        
    }

    public class AcreedoresService : GestionService<AcreedoresModel, Acreedores>, IMobileTercerosService, IAcreedoresService
    {
        #region CTR

        public AcreedoresService(IContextService context, MarfilEntities db = null) : base(context, db)
        {

        }

        #endregion

        #region Create

        public override void create(IModelView obj)
        {
            using (var tran = Marfil.Inf.Genericos.Helper.TransactionScopeBuilder.CreateTransactionObject())
            {
                var model = obj as AcreedoresModel;

                base.create(obj);

                //guardar direcciones
                GuardarCuentas(model);
                GuardarDirecciones(model);
                GuardarContactos(model);
                GuardarBancos(model);
                tran.Complete();
            }

        }

        #endregion

        #region Edit

        public override void edit(IModelView obj)
        {
            using (var tran = Marfil.Inf.Genericos.Helper.TransactionScopeBuilder.CreateTransactionObject())
            {
                var model = obj as AcreedoresModel;

                base.edit(obj);

                //guardar direcciones
                GuardarCuentas(model);
                GuardarDirecciones(model);
                GuardarContactos(model);
                GuardarBancos(model);
                tran.Complete();
            }
        }

        #endregion

        #region Delete

        public override void delete(IModelView obj)
        {
            using (var tran = Marfil.Inf.Genericos.Helper.TransactionScopeBuilder.CreateTransactionObject())
            {
                var model = obj as AcreedoresModel;

                base.delete(obj);

                DeleteCuentas(model);
                DeleteDirecciones(model);
                DeleteContactos(model);
                DeleteBancos(model);
                tran.Complete();
            }
        }


        #endregion

        #region List Index

        public override ListIndexModel GetListIndexModel(Type t, bool canEliminar, bool canModificar, string controller)
        {
            var model = CuentasService.GetTercerosIndexModel<AcreedoresModel>(_context, controller, canEliminar, canModificar);
            model.List = GetAll<CuentasBusqueda>();
            return model;
        }

        public override string GetSelectPrincipal()
        {
            return string.Format(CuentasService.SelectCuentasTerceros, (int) TiposCuentas.Acreedores, Empresa, TiposCuentas.Acreedores);
        }

        #endregion

        #region Tipo cuentas

        public struct StExiste
        {
            public bool Existe { get; set; }
            public bool Valido { get; set; }
        }
        public StExiste GetCompañia(TiposCuentas tipo, string id)
        {
            var result = new StExiste();
            var tiposcuentasService =
                FService.Instance.GetService(typeof (TiposCuentasModel), _context) as TiposcuentasService;
            var subcuenta = tiposcuentasService.GetMascaraFromTipoCuenta(tipo);
            result.Valido = id.Contains(subcuenta);
            result.Existe = false;
            if (result.Valido)
            {
                result.Existe = exists(id);
            }
            return result;
        }

        #endregion

        #region Helper cuetnas

        private void DeleteCuentas(AcreedoresModel model)
        {
            var fservice = FService.Instance;
            var cuentasService = fservice.GetService(typeof(CuentasModel), _context, _db) as CuentasService;
            cuentasService.FlagDeleteFromThird = true;
            cuentasService.delete(model.Cuentas);
        }

        private void GuardarCuentas(AcreedoresModel model)
        {
            model.Cuentas.Tiposcuentas = (int)TiposCuentas.Acreedores;
            var fservice = FService.Instance;

            var cuentasService = fservice.GetService(typeof(CuentasModel), _context, _db) as CuentasService;
            if (cuentasService.exists(model.Cuentas.Id))
            {
                var fserviceOriginal = FService.Instance;
                var cuentasServiceOriginal = fserviceOriginal.GetService(typeof(CuentasModel), _context);
                var dbmodel = cuentasServiceOriginal.get(model.Fkcuentas) as CuentasModel;
                dbmodel.Descripcion = model.Cuentas.Descripcion;
                dbmodel.Descripcion2 = model.Cuentas.Descripcion2;
                dbmodel.FkPais = model.Cuentas.FkPais;
                dbmodel.Nif = model.Cuentas.Nif;

                cuentasService.edit(dbmodel);
            }
            else
            {
                cuentasService.create(model.Cuentas);
            }

        }

        #endregion

        #region Helper contactos

        private void ProcessContactos(AcreedoresModel model)
        {
            foreach (var item in model.Contactos.Contactos)
            {
                item.Empresa = model.Empresa;
                item.Fkentidad = model.Fkcuentas;
                item.Tipotercero = TiposCuentas.Acreedores;
                if (item.Id < 0)
                {
                    item.Id = GetNextContactoId(model);
                }
            }
        }

        private int GetNextContactoId(AcreedoresModel model)
        {
            var result = 1;

            if (model.Contactos != null && model.Contactos.Contactos.Any())
            {
                result = model.Contactos.Contactos.Max(f => f.Id) + 1;
            }

            return result;
        }

        private void GuardarContactos(AcreedoresModel model)
        {
            if (model.Contactos == null) return;
            var fservice = FService.Instance;
            var contactosService = fservice.GetService(typeof(ContactosLinModel), _context, _db) as ContactosService;
            ProcessContactos(model);

            contactosService.CleanAllContactos(TiposCuentas.Acreedores, model.Fkcuentas);
            foreach (var item in model.Contactos.Contactos)
            {
                contactosService.create(item);
            }
        }

        private void DeleteContactos(AcreedoresModel model)
        {
            if (model.Contactos == null) return;
            var fservice = FService.Instance;
            var contactosService = fservice.GetService(typeof(ContactosLinModel), _context, _db);
            ProcessContactos(model);
            foreach (var item in model.Contactos.Contactos)
            {
                contactosService.delete(item);
            }
        }

        #endregion

        #region Helper Direcciones

        private void ProcessDirecciones(AcreedoresModel model)
        {
            foreach (var item in model.Direcciones.Direcciones)
            {
                item.Empresa = model.Empresa;
                item.Fkentidad = model.Fkcuentas;
                item.Tipotercero = (int)TiposCuentas.Acreedores;
                if (item.Id < 0)
                {
                    item.Id = GetNextId(model);
                }
            }
        }

        private int GetNextId(AcreedoresModel model)
        {
            var result = 1;

            if (model.Direcciones != null && model.Direcciones.Direcciones.Any())
            {
                result = model.Direcciones.Direcciones.Max(f => f.Id) + 1;
            }

            return result;
        }

        private void GuardarDirecciones(AcreedoresModel model)
        {
            if (model.Direcciones == null) return;
            var fservice = FService.Instance;
            var direccionesService = fservice.GetService(typeof(DireccionesLinModel), _context, _db) as DireccionesService;
            ProcessDirecciones(model);

            direccionesService.CleanAllDirecciones(Empresa, TiposCuentas.Acreedores, model.Fkcuentas);
            foreach (var item in model.Direcciones.Direcciones)
            {
                direccionesService.create(item);
            }
        }

        private void DeleteDirecciones(AcreedoresModel model)
        {
            if (model.Direcciones == null) return;
            var fservice = FService.Instance;
            var direccionesService = fservice.GetService(typeof(DireccionesLinModel), _context, _db);
            ProcessDirecciones(model);
            foreach (var item in model.Direcciones.Direcciones)
            {
                direccionesService.delete(item);
            }
        }

        #endregion

        #region Helper Bancos

        private void ProcessBancos(AcreedoresModel model)
        {
            foreach (var item in model.BancosMandatos.BancosMandatos)
            {
                item.Empresa = model.Empresa;
                item.Fkcuentas = model.Fkcuentas;
                if (Funciones.Qint(item.Id) < 0)
                {
                    item.Id = GetNextBancosId(model);
                }
            }
        }

        private string GetNextBancosId(AcreedoresModel model)
        {
            var result = Funciones.RellenaCod("1", 3);

            if (model.BancosMandatos != null && model.BancosMandatos.BancosMandatos.Any())
            {
                var max = model.BancosMandatos.BancosMandatos.Max(f => f.Idnumerico) > 0
                    ? model.BancosMandatos.BancosMandatos.Max(f => f.Idnumerico)
                    : 1;
                result = Funciones.GetNextCode(max.ToString(), 3);
            }

            return result;
        }

        private void GuardarBancos(AcreedoresModel model)
        {
            if (model.BancosMandatos == null) return;
            var fservice = FService.Instance;
            var bancosService = fservice.GetService(typeof(BancosMandatosLinModel), _context, _db) as BancosMandatosService;
            ProcessBancos(model);
            bancosService.CleanAllBancosMandatos(model.Fkcuentas);
            foreach (var item in model.BancosMandatos.BancosMandatos)
            {
                bancosService.create(item);
            }
        }


        private void DeleteBancos(AcreedoresModel model)
        {
            if (model.BancosMandatos == null) return;
            var fservice = FService.Instance;
            var bancosmandatosService = fservice.GetService(typeof(BancosMandatosLinModel), _context, _db);
            foreach (var item in model.BancosMandatos.BancosMandatos)
            {
                bancosmandatosService.delete(item);
            }
        }

        #endregion

        #region Busqueda de terceros

        public IEnumerable<IItemResultadoMovile> BuscarTercero(string cuenta)
        {
            var model = get(cuenta) as AcreedoresModel;

            var result = new List<IItemResultadoMovile>();
            result.Add(new ItemCabeceraResultadoMoviles()
            {
                Valor = Inf.ResourcesGlobalization.Textos.Entidades.Acreedores.TituloEntidad
            });

            result.Add(new ItemResultadoMovile()
            {
                Campo = Inf.ResourcesGlobalization.Textos.Entidades.Acreedores.Fkcuentas,
                Valor = model.Fkcuentas
            });

            result.Add(new ItemResultadoMovile()
            {
                Campo = Inf.ResourcesGlobalization.Textos.Entidades.Acreedores.Descripcion,
                Valor = model.Descripcion
            });

            result.Add(new ItemResultadoMovile()
            {
                Campo = Inf.ResourcesGlobalization.Textos.Entidades.Acreedores.RazonSocial,
                Valor = model.Razonsocial
            });

            result.Add(new ItemResultadoMovile()
            {
                Campo = Inf.ResourcesGlobalization.Textos.Entidades.Acreedores.Pais,
                Valor = model.Pais
            });

            result.Add(new ItemResultadoMovile()
            {
                Campo = Inf.ResourcesGlobalization.Textos.Entidades.Acreedores.Nif,
                Valor = model.Nif
            });

            result.Add(new ItemSeparadorResultadoMoviles());

            //Direcciones
            result.Add(new ItemCabeceraResultadoMoviles()
            {
                Valor = Inf.ResourcesGlobalization.Textos.Entidades.Direcciones.TituloEntidad
            });

            if (model.Direcciones != null)
                foreach (var item in model.Direcciones.Direcciones.OrderBy(f => f.Defecto))
                {
                    result.Add(new ItemResultadoMovile()
                    {
                        Campo = Inf.ResourcesGlobalization.Textos.Entidades.Direcciones.Descripcion,
                        Valor = model.Descripcion
                    });
                    result.Add(new ItemResultadoMovile()
                    {
                        Campo = Inf.ResourcesGlobalization.Textos.Entidades.Direcciones.Direccion,
                        Valor = model.Direccion
                    });
                    result.Add(new ItemResultadoMovile()
                    {
                        Campo = Inf.ResourcesGlobalization.Textos.Entidades.Direcciones.Cp,
                        Valor = model.Cp
                    });
                    result.Add(new ItemResultadoMovile()
                    {
                        Campo = Inf.ResourcesGlobalization.Textos.Entidades.Direcciones.Poblacion,
                        Valor = model.Poblacion
                    });
                }

            result.Add(new ItemSeparadorResultadoMoviles());

            //Contactos
            result.Add(new ItemCabeceraResultadoMoviles()
            {
                Valor = Inf.ResourcesGlobalization.Textos.Entidades.Contactos.TituloEntidad
            });

            if (model.Contactos != null)
                foreach (var item in model.Contactos.Contactos)
                {
                    result.Add(new ItemResultadoMovile()
                    {
                        Campo = Inf.ResourcesGlobalization.Textos.Entidades.Contactos.Nombre,
                        Valor = item.Nombre
                    });
                    result.Add(new ItemResultadoMovile()
                    {
                        Campo = Inf.ResourcesGlobalization.Textos.Entidades.Contactos.Telefono,
                        Valor = item.Telefono
                    });
                    result.Add(new ItemResultadoMovile()
                    {
                        Campo = Inf.ResourcesGlobalization.Textos.Entidades.Contactos.Telefonomovil,
                        Valor = item.Telefonomovil
                    });
                    result.Add(new ItemResultadoMovile()
                    {
                        Campo = Inf.ResourcesGlobalization.Textos.Entidades.Contactos.Email,
                        Valor = item.Email
                    });

                }

            return result;
        }

        #endregion
    }
}
