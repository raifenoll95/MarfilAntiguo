using Marfil.Dom.Persistencia.Model.Configuracion.Cuentas;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Marfil.Dom.Persistencia.ServicesView.Servicios
{
    public interface IBancosMandatosService
    {

    }

    public class BancosMandatosService : GestionService<BancosMandatosLinModel, BancosMandatos>, IBancosMandatosService
    {
        #region CTR

        public BancosMandatosService(IContextService context, MarfilEntities db = null) : base(context, db)
        {

        }

        #endregion

        #region API


        internal void CleanAllBancosMandatos(string fkcuentas)
        {
            var vector = _db.BancosMandatos.Where(f => f.empresa == Empresa && f.fkcuentas == fkcuentas);
            _db.BancosMandatos.RemoveRange(vector);
            _db.SaveChanges();
        }

        public List<BancosMandatosLinModel> GetBancosMandatos(string fkcuentas)
        {
            return _db.Set<BancosMandatos>().Where(f => f.empresa == Empresa && f.fkcuentas == fkcuentas).ToList().Select(f => _converterModel.GetModelView(f) as BancosMandatosLinModel).ToList();
        }

       

        #endregion
    }
}
