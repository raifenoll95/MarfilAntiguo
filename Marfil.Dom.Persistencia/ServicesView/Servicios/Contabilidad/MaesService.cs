using System.Data.Entity.Migrations;
using System.Linq;
using System.Collections.Generic;

using Marfil.Dom.Persistencia.ServicesView.Servicios.Converter;
using Marfil.Dom.Persistencia.ServicesView.Servicios.Validation;
using Marfil.Dom.Persistencia.Model.Interfaces;
using Marfil.Dom.Persistencia.Model.Contabilidad.Movs;
using Marfil.Dom.Persistencia.Model.Contabilidad.Maes;



namespace Marfil.Dom.Persistencia.ServicesView.Servicios
{


    public enum TipoOperacionMaes
    {
        Alta,
        Baja
    }

    public interface IMaesService
    {
        //void GenerarLineas(MovsModel model);
        //void GenerarLineas(MovsModel model, MaesModel.TipoOperacion operacion);
    }

    public class MaesService : GestionService<MaesModel, Maes>, IMaesService
    {

        #region Member

        private string _ejercicioId;

        #endregion

        #region Properties

        public string EjercicioId
        {
            get { return _ejercicioId; }
            set
            {
                _ejercicioId = value;
                ((MaesValidation)_validationService).EjercicioId = value;
            }
        }

        #endregion

        #region CTR
        public MaesService(IContextService context, MarfilEntities db = null) : base(context, db)
        {
            EjercicioId = context.Ejercicio;
        }
        #endregion CTR


        #region Api

        public override IModelView get(string id)
        {
            ((MaesConverterService)_converterModel).Ejercicio = EjercicioId;
            return base.get(id);
        }

        //public IEnumerable<MaesModel> RecalcularMaes(IEnumerable<MovsLinModel> model)
        //{
        //    List<MaesModel> result = new List<MaesModel>();
                       
        //    result = model.GroupBy(l => l.Fkcuentas)
        //        .Select(cl => new MaesModel
        //        {
        //            Fkcuentas = cl.First().Fkcuentas,
        //            Debe = cl.Sum(c => c.Debe),
        //            Haber = cl.Sum(c => c.Haber)
        //        }).ToList();
        //    return result;

        //}

        public void GenerarMovimiento(MovsModel model, TipoOperacionMaes tipo)// short multiplo)
        // multiplo 1 para alta  -1 para baja
        {
            // nivel 0
            foreach (var item in model.Lineas.GroupBy(l => l.Fkcuentas))
            {
                string fkcuentas = item.Key;

                
                var itemmaes = _db.Maes.SingleOrDefault(f => f.empresa == model.Empresa && f.fkcuentas == fkcuentas && f.fkejercicio == model.Fkejercicio)
                              ?? _db.Maes.Create();

                if (string.IsNullOrWhiteSpace(itemmaes.empresa))
                {
                    itemmaes.empresa = model.Empresa;
                    itemmaes.fkcuentas = fkcuentas;
                    itemmaes.fkejercicio = model.Fkejercicio;
                }
                int multiplo = (tipo == TipoOperacionMaes.Alta ? 1 : -1);

                itemmaes.debe = (itemmaes.debe ?? 0) + (item.Where(l=>l.Esdebe == 1).Sum(l=> l.Importe) * (multiplo));
                itemmaes.haber = (itemmaes.haber ?? 0) + (item.Where(l => l.Esdebe == -1).Sum(l => l.Importe) * (multiplo));
                itemmaes.saldo = (itemmaes.debe ?? 0) - (itemmaes.haber ?? 0);

                _db.Maes.AddOrUpdate(itemmaes);
            }


            // nivel 0 - 4

            for (int nivel = 4; nivel > 0; nivel--)
            {
                foreach (var item in model.Lineas.GroupBy(l=> l.Fkcuentas.Substring(0, nivel)))
                {
                    string fkcuentas = item.Key;//.Substring(0, nivel);

                    var itemmaes = _db.Maes.SingleOrDefault(f => f.empresa == model.Empresa && f.fkcuentas == fkcuentas && f.fkejercicio == model.Fkejercicio)
                                   ?? _db.Maes.Create();

                    if(string.IsNullOrWhiteSpace(itemmaes.empresa))
                    {
                        itemmaes.empresa = model.Empresa;
                        itemmaes.fkcuentas = fkcuentas;
                        itemmaes.fkejercicio = model.Fkejercicio;
                    }
                    int multiplo = (tipo == TipoOperacionMaes.Alta ? 1 : -1);

                    itemmaes.debe = (itemmaes.debe ?? 0) + (item.Where(l => l.Esdebe == 1).Sum(l => l.Importe) * (multiplo));
                    itemmaes.haber = (itemmaes.haber ?? 0) + (item.Where(l => l.Esdebe == -1).Sum(l => l.Importe) * (multiplo));
                    itemmaes.saldo = (itemmaes.debe ?? 0) - (itemmaes.haber ?? 0);

                    _db.Maes.AddOrUpdate(itemmaes);
                }
            }
        }


        //public void GenerarLineas(MovsModel model)
        //{
        //    foreach (var item in model.Lineas)
        //    {
        //        var itemmaes = _db.Maes.SingleOrDefault(f => f.empresa == model.Empresa && f.fkcuentas == item.Fkcuentas && f.fkejercicio == model.Fkejercicio)
        //                       ?? _db.Maes.Create();

        //        itemmaes.empresa = model.Empresa;
        //        itemmaes.fkcuentas = item.Fkcuentas;
        //        itemmaes.fkejercicio = model.Fkejercicio;

        //        //switch (operacion)
        //        //{
        //        //    case MaesModel.TipoOperacion.Añadir:
        //        itemmaes.debe = itemmaes.debe + item.Debe;
        //        itemmaes.haber = itemmaes.haber + item.Haber;
        //        //        break;
        //        //    case MaesModel.TipoOperacion.Borrar:
        //        //        itemmaes.debe = itemmaes.debe - item.Debe;
        //        //        itemmaes.haber = itemmaes.haber - item.Haber;
        //        //        break;
        //        //    case MaesModel.TipoOperacion.Actualizar:
        //        //        itemmaes.debe = itemmaes.debe + item.Debe;
        //        //        itemmaes.haber = itemmaes.haber + item.Haber;
        //        //        break;
        //        //}


        //        itemmaes.saldo = itemmaes.debe - itemmaes.haber;


        //        _db.Maes.AddOrUpdate(itemmaes);
        //    }
        //}

        #endregion
    }
}