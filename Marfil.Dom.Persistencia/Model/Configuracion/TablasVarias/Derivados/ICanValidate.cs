﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Marfil.Dom.Persistencia.Model.Configuracion.TablasVarias.Derivados
{
    public interface ICanValidate
    {
        bool ValidateModel(IEnumerable<object> containerCollection);
    }
}
