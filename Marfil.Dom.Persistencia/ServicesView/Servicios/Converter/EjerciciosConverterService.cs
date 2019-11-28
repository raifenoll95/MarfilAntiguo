using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Marfil.Dom.ControlsUI.Bloqueo;
using Marfil.Dom.Persistencia.Helpers;
using Marfil.Dom.Persistencia.Model.Configuracion;
using Marfil.Dom.Persistencia.Model.FicherosGenerales;
using Marfil.Dom.Persistencia.Model.Interfaces;
using Marfil.Inf.Genericos;
using REjercicios =Marfil.Inf.ResourcesGlobalization.Textos.Entidades.Ejercicios;
namespace Marfil.Dom.Persistencia.ServicesView.Servicios.Converter
{
    internal class EjerciciosConverterService : BaseConverterModel<EjerciciosModel, Ejercicios>
    {
        public EjerciciosConverterService(IContextService context, MarfilEntities db) : base(context, db)
        {
        }

        public override bool Exists(string id)
        {
            var idInt = int.Parse(id);
            return _db.Set<Ejercicios>().Any(f => f.id == idInt && f.empresa == Empresa);
        }

        public override IEnumerable<IModelView> GetAll()
        {
            return _db.Ejercicios.Where(f => f.empresa == Empresa).ToList().Select(f => GetModelView(f));
        }

        public override IModelView CreateView(string id)
        {
            var idInt = int.Parse(id);
            var obj = _db.Set<Ejercicios>().Single(f => f.id == idInt && f.empresa == Empresa);
            return GetModelView(obj) as EjerciciosModel;
        }

        public override Ejercicios EditPersitance(IModelView obj)
        {
            var model = obj as EjerciciosModel;
            var efobj = _db.Set<Ejercicios>().Single(f => f.id == model.Id && f.empresa == Empresa);
            foreach (var item in efobj.GetType().GetProperties())
            {
                if ((obj.GetType().GetProperty(item.Name.FirstToUpper())?.PropertyType.IsGenericType ?? false) &&
                    obj.GetType().GetProperty(item.Name.FirstToUpper())?.PropertyType.GetGenericTypeDefinition() !=
                    typeof(ICollection<>))
                {
                    item.SetValue(efobj, obj.GetType().GetProperty(item.Name.FirstToUpper())?.GetValue(obj, null));
                }
                else if (obj.GetType().GetProperty(item.Name.FirstToUpper())?.PropertyType.IsEnum ?? false)
                {
                    item.SetValue(efobj, (int)obj.GetType().GetProperty(item.Name.FirstToUpper())?.GetValue(obj, null));
                }
                else if (!obj.GetType().GetProperty(item.Name.FirstToUpper())?.PropertyType.IsGenericType ?? false)
                {
                    item.SetValue(efobj, obj.GetType().GetProperty(item.Name.FirstToUpper())?.GetValue(obj, null));
                }
            }

            return efobj;
        }

        //Create p
        //public override Ejercicios CreatePersitance(IModelView obj)
        //{
        //    var objmodel = obj as EjerciciosModel;
        //    var result = _db.Set<Ejercicios>().Create();

        //    foreach (var item in result.GetType().GetProperties())
        //    {
        //        if ((obj.GetType().GetProperty(item.Name.FirstToUpper())?.PropertyType.IsGenericType ?? false) &&
        //            (obj.GetType().GetProperty(item.Name.FirstToUpper())?.PropertyType.GetGenericTypeDefinition() !=
        //            typeof(ICollection<>)))
        //        {
        //            item.SetValue(result, obj.GetType().GetProperty(item.Name.FirstToUpper())?.GetValue(obj, null));
        //        }
        //        else if (obj.GetType().GetProperty(item.Name.FirstToUpper())?.PropertyType.IsEnum ?? false)
        //        {
        //            item.SetValue(result, (int)obj.GetType().GetProperty(item.Name.FirstToUpper())?.GetValue(obj, null));
        //        }
        //        else if (!obj.GetType().GetProperty(item.Name.FirstToUpper())?.PropertyType.IsGenericType ?? false)
        //        {
        //            item.SetValue(result, obj.GetType().GetProperty(item.Name.FirstToUpper())?.GetValue(obj, null));
        //        }
        //    }

        //    return result;
        //}

        public override IModelView GetModelView(Ejercicios obj)
        {
            var instance = new EjerciciosModel();
            var objProperties = obj.GetType().GetProperties();
            foreach (var item in objProperties)
            {
                if (obj.GetType().GetProperty(item.Name).PropertyType.IsGenericType &&
                    obj.GetType().GetProperty(item.Name).PropertyType.GetGenericTypeDefinition() !=
                    typeof(ICollection<>))
                {
                    instance.set(item.Name.FirstToUpper(), obj.GetType().GetProperty(item.Name)?.GetValue(obj, null));
                }
                else if (obj.GetType().GetProperty(item.Name).PropertyType.IsEnum)
                {
                    instance.set(item.Name.FirstToUpper(), (int)obj.GetType().GetProperty(item.Name)?.GetValue(obj, null));
                }
                else if (!obj.GetType().GetProperty(item.Name).PropertyType.IsGenericType && item.Name != "CostesVariablesPeriodo")
                {
                    instance.set(item.Name.FirstToUpper(), obj.GetType().GetProperty(item.Name)?.GetValue(obj, null));
                }

            }

            return instance;
        }
    }
}
