﻿using DevExpress.DataAccess.ConnectionParameters;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using DevExpress.DataAccess.Sql;
using Marfil.Dom.Persistencia.Model.Configuracion.Cuentas;
using Marfil.Dom.Persistencia.ServicesView.Servicios;

namespace Marfil.Dom.Persistencia.Model.Documentos.Transformaciones
{
    

    class TransformacionesReport: IReport
    {
        public SqlDataSource DataSource { get; private set; }

        public TransformacionesReport(IContextService user,string primarykey)
        {
            
            
                var server = ConfigurationManager.AppSettings["Server"];
                var usuario = ConfigurationManager.AppSettings["User"];
                var password = ConfigurationManager.AppSettings["Password"];
                DataSource = new SqlDataSource("Report", new MsSqlConnectionParameters(server, user.BaseDatos, usuario, password,MsSqlAuthorizationType.SqlServer));
                DataSource.Name = "Report";
                var mainQuery = new CustomSqlQuery("Transformaciones", "SELECT * FROM [Transformaciones] ");
                if (!string.IsNullOrEmpty(primarykey))
                {
                    mainQuery.Parameters.Add(new QueryParameter("empresa", typeof(string), user.Empresa));
                    mainQuery.Parameters.Add(new QueryParameter("referencia",typeof(string),primarykey));
                    mainQuery.Sql = "SELECT * FROM [Transformaciones] where empresa=@empresa and referencia=@referencia";
                }
           
            DataSource.Queries.Add(new CustomSqlQuery("empresa", "SELECT e.*,d.direccion as [Direccionempresa],d.poblacion as [Poblacionempresa],d.cp as [Cpempresa],d.telefono as [Telefonoempresa] FROM [Empresas] as e left join direcciones as d on d.empresa=e.id and d.tipotercero=-1 and d.fkentidad=e.id"));
            DataSource.Queries.Add(mainQuery);
            DataSource.Queries.Add(new CustomSqlQuery("Transformacionesentradalin", "SELECT pr.*,u.textocorto as [Unidadesdescripcion] FROM [Transformacionesentradalin] as pr" +
                     " inner join Familiasproductos as fp on fp.empresa=pr.empresa and fp.id=substring(pr.fkarticulos,0,3)" +
                    " left join unidades as u on fp.fkunidadesmedida=u.id"));

            DataSource.Queries.Add(new CustomSqlQuery("Transformacionessalidalin", "SELECT pr.*,u.textocorto as [Unidadesdescripcion] FROM [TransformacionessalidaLin] as pr" +
                     " inner join Familiasproductos as fp on fp.empresa=pr.empresa and fp.id=substring(pr.fkarticulos,0,3)" +
                    " left join unidades as u on fp.fkunidadesmedida=u.id"));
            // Create a master-detail relation between the queries.
            DataSource.Relations.Add("Transformaciones", "Transformacionesentradalin", new[] {
                    new RelationColumnInfo("empresa", "empresa"),
                    new RelationColumnInfo("id", "fktransformaciones")});

            DataSource.Relations.Add("Transformaciones", "Transformacionessalidalin", new[] {
                    new RelationColumnInfo("empresa", "empresa"),
                    new RelationColumnInfo("id", "fktransformaciones")});


            DataSource.Relations.Add("Transformaciones", "empresa", new[] {
                    new RelationColumnInfo("empresa", "id")});


            DataSource.Relations.Add("Transformaciones", "Formaspago", new[] {
                    new RelationColumnInfo("fkformaspago", "id")});

            DataSource.RebuildResultSchema();
                
            
        }
    }
}
