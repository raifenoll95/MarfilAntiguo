﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Marfil.Dom.Persistencia.Model.Configuracion.TablasVarias;
using Marfil.Dom.Persistencia.Model.Configuracion.TablasVarias.Derivados;

namespace Marfil.Dom.Persistencia.ServicesView.Servicios.Startup
{
    class TiposNifStartup : IStartup, IStartupTablasVarias
    {
        #region Members

        private readonly TablasVariasService _tablasVariasService;
        private IContextService _context;

        #endregion

        #region Properties

        public string Id { get; set; }
        public string Nombre { get; set; }
        public string Clase { get; set; }
        public TipoTablaVaria Tipo { get; set; }
        public bool NoEditable { get; set; }

        #endregion

        #region CTR

        public TiposNifStartup(IContextService context,MarfilEntities db)
        {
            _context = context;
            _tablasVariasService = new TablasVariasService(context,db);
        }

        #endregion

        public void CrearDatos(string fichero)
        {
            var csvFile = _context.ServerMapPath(fichero);
            using (var reader = new StreamReader(csvFile, Encoding.Default, true))
            {
                var contenido = reader.ReadToEnd();
                var model = CreateModel(contenido);
                _tablasVariasService.create(model);
            }
        }

        private BaseTablasVariasModel CreateModel(string contenido)
        {
            return new BaseTablasVariasModel
            {
                Clase = Clase,
                Id = int.Parse(Id),
                Nombre = Nombre,
                Tipo=Tipo,
                Noeditable = NoEditable,
                Lineas = CrearLineas(contenido)
            };
        }

        private List<dynamic> CrearLineas(string xml)
        {
            var lineas = xml.Split(new[] { Environment.NewLine }, StringSplitOptions.None);
            return (lineas.Where(f => !string.IsNullOrEmpty(f)).Select(CrearLinea)).Cast<dynamic>().ToList();
        }

        private TablasVariasTiposNif CrearLinea(string linea)
        {
            var vector = linea.Split(';');
            return new TablasVariasTiposNif()
            {
                Valor = vector[0],
                Descripcion = vector[1],
                Descripcion2 = vector[2],
                VerificaValor = vector[3].ToLower() == "true"
            };
        }

        public void Dispose()
        {
            _tablasVariasService?.Dispose();
        }
    }
}
