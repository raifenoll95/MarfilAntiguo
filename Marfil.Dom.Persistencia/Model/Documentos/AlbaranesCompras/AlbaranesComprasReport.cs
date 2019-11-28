﻿using System.Configuration;
using DevExpress.DataAccess.ConnectionParameters;
using DevExpress.DataAccess.Sql;
using Marfil.Dom.Persistencia.ServicesView.Servicios;

namespace Marfil.Dom.Persistencia.Model.Documentos.AlbaranesCompras
{
    

    class AlbaranesComprasReport: IReport
    {
        public SqlDataSource DataSource { get; private set; }

        public AlbaranesComprasReport(IContextService user,string primarykey)
        {
            
            
                var server = ConfigurationManager.AppSettings["Server"];
                var usuario = ConfigurationManager.AppSettings["User"];
                var password = ConfigurationManager.AppSettings["Password"];
                DataSource = new SqlDataSource("Report", new MsSqlConnectionParameters(server, user.BaseDatos, usuario, password, MsSqlAuthorizationType.SqlServer));
                DataSource.Name = "Report";
                var mainQuery = new CustomSqlQuery("Albaranes", "SELECT * FROM [AlbaranesCompras] ");
               
                if (!string.IsNullOrEmpty(primarykey))
                {
                mainQuery.Parameters.Add(new QueryParameter("empresa", typeof(string), user.Empresa));
                mainQuery.Parameters.Add(new QueryParameter("referencia",typeof(string),primarykey));
                    mainQuery.Sql = "SELECT * FROM [AlbaranesCompras] where empresa=@empresa and referencia=@referencia";
                }
                DataSource.Queries.Add(new CustomSqlQuery("clientes", "SELECT * FROM [Proveedores]"));
                DataSource.Queries.Add(new CustomSqlQuery("empresa", "SELECT * FROM [Empresas]"));
                DataSource.Queries.Add(mainQuery);
                DataSource.Queries.Add(new CustomSqlQuery("Albaraneslin", "SELECT * FROM [AlbaranesComprasLin]"));
                DataSource.Queries.Add(new CustomSqlQuery("Albaranestotales", "SELECT * FROM [AlbaranesComprasTotales]"));

                // Create a master-detail relation between the queries.
                DataSource.Relations.Add("Albaranes", "Albaraneslin", new[] {
                    new RelationColumnInfo("empresa", "empresa"),
                    new RelationColumnInfo("id", "fkalbaranes")});

                DataSource.Relations.Add("Albaranes", "Albaranestotales", new[] {
                    new RelationColumnInfo("empresa", "empresa"),
                    new RelationColumnInfo("id", "fkalbaranes")});

                DataSource.Relations.Add("Albaranes", "clientes", new[] {
                    new RelationColumnInfo("empresa", "empresa"),
                    new RelationColumnInfo("fkproveedores", "fkcuentas")});

                DataSource.Relations.Add("Albaranes", "empresa", new[] {
                    new RelationColumnInfo("empresa", "id")});


               

                DataSource.RebuildResultSchema();
                
            
        }
    }
}
