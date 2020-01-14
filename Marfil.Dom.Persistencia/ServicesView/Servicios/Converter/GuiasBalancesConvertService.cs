using Marfil.Dom.Persistencia.Model.Contabilidad;
using Marfil.Dom.Persistencia.Model.Interfaces;
using Marfil.Inf.Genericos;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Marfil.Dom.Persistencia.ServicesView.Servicios.Converter
{
    class GuiasBalancesConvertService : BaseConverterModel<GuiasBalancesModel, GuiasBalances>
    {
        public GuiasBalancesConvertService(IContextService context, MarfilEntities db) : base(context, db)
        {
                
        }

        public override IModelView GetModelView(GuiasBalances obj)
        {
            var result = base.GetModelView(obj) as GuiasBalancesModel;
            result.GuiasBalancesLineas = obj.GuiasBalancesLineas.ToList().Select(g => new GuiasBalancesLineasModel()
            {
                cuenta = g.cuenta,
                guia = g.guia,
                GuiasBalancesId = g.GuiasBalancesId,
                Id = g.Id,
                informe = g.informe,
                orden = g.orden,
                signo = g.signo,
                signoea = g.signoea
            }).ToList();
            return result;
        }
        public override GuiasBalances CreatePersitance(IModelView obj)
        {
            var viewmodel = base.CreatePersitance(obj);
            var result = _db.GuiasBalances.Create();

            foreach (var item in result.GetType().GetProperties())
            {
                if ((obj.GetType().GetProperty(item.Name.FirstToUpper())?.PropertyType.IsGenericType ?? false) &&
                    (obj.GetType().GetProperty(item.Name.FirstToUpper())?.PropertyType.GetGenericTypeDefinition() !=
                    typeof(ICollection<>)) && item.Name.ToLower() != "guiasbalanceslineas")
                {
                    item.SetValue(result, obj.GetType().GetProperty(item.Name.FirstToUpper())?.GetValue(obj, null));
                }
                else if (obj.GetType().GetProperty(item.Name.FirstToUpper())?.PropertyType.IsEnum ?? false)
                {
                    item.SetValue(result, (int)obj.GetType().GetProperty(item.Name.FirstToUpper())?.GetValue(obj, null));
                }
                else if (!obj.GetType().GetProperty(item.Name.FirstToUpper())?.PropertyType.IsGenericType ?? false)
                {
                    item.SetValue(result, obj.GetType().GetProperty(item.Name.FirstToUpper())?.GetValue(obj, null));
                }
            }

            result.GuiasBalancesLineas.Clear();
            foreach (var item in viewmodel.GuiasBalancesLineas)
            {
                var newItem = _db.Set<GuiasBalancesLineas>().Create();
                newItem.cuenta = item.cuenta;
                newItem.guia = item.guia;
                newItem.GuiasBalancesId = item.GuiasBalancesId;
                newItem.Id = item.Id;
                newItem.informe = item.informe;
                newItem.orden = item.orden;
                newItem.signo = item.signo;
                newItem.signoea = item.signoea;
                result.GuiasBalancesLineas.Add(newItem);
            }
            return result;
        }
        public override GuiasBalances EditPersitance(IModelView obj)
        {
            var viewmodel = obj as GuiasBalancesModel;
            var result = _db.GuiasBalances.Where(w => w.Id == viewmodel.Id).Include(i=> i.GuiasBalancesLineas).ToList().Single();

            foreach (var item in result.GetType().GetProperties())
            {
                if ((obj.GetType().GetProperty(item.Name.FirstToUpper())?.PropertyType.IsGenericType ?? false) &&
                    (obj.GetType().GetProperty(item.Name.FirstToUpper())?.PropertyType.GetGenericTypeDefinition() !=
                    typeof(ICollection<>)) && item.Name.ToLower() != "guiasbalanceslineas")
                {
                    item.SetValue(result, obj.GetType().GetProperty(item.Name.FirstToUpper())?.GetValue(obj, null));
                }
                else if (obj.GetType().GetProperty(item.Name.FirstToUpper())?.PropertyType.IsEnum ?? false)
                {
                    item.SetValue(result, (int)obj.GetType().GetProperty(item.Name.FirstToUpper())?.GetValue(obj, null));
                }
                else if (!obj.GetType().GetProperty(item.Name.FirstToUpper())?.PropertyType.IsGenericType ?? false)
                {
                    item.SetValue(result, obj.GetType().GetProperty(item.Name.FirstToUpper())?.GetValue(obj, null));
                }
            }

            result.GuiasBalancesLineas.Clear();
            foreach (var item in viewmodel.GuiasBalancesLineas)
            {
                var newItem = _db.Set<GuiasBalancesLineas>().Create();
                newItem.cuenta = item.cuenta;
                newItem.guia = item.guia;
                newItem.GuiasBalancesId = item.GuiasBalancesId;
                newItem.Id = item.Id;
                newItem.informe = item.informe;
                newItem.orden = item.orden;
                newItem.signo = item.signo;
                newItem.signoea = item.signoea;
                result.GuiasBalancesLineas.Add(newItem);
            }
            return result;
        }
    }
}
