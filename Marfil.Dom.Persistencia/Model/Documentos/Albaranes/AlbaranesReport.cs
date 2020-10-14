using System.Configuration;
using DevExpress.DataAccess.ConnectionParameters;
using DevExpress.DataAccess.Sql;
using Marfil.Dom.Persistencia.Model.Configuracion.Cuentas;
using Marfil.Dom.Persistencia.ServicesView.Servicios;

namespace Marfil.Dom.Persistencia.Model.Documentos.Albaranes
{
    

    class AlbaranesReport: IReport
    {
        public SqlDataSource DataSource { get; private set; }

        public AlbaranesReport(IContextService user,string primarykey)
        {
            
            
                var server = ConfigurationManager.AppSettings["Server"];
                var usuario = ConfigurationManager.AppSettings["User"];
                var password = ConfigurationManager.AppSettings["Password"];
                DataSource = new SqlDataSource("Report", new MsSqlConnectionParameters(server, user.BaseDatos, usuario, password, MsSqlAuthorizationType.SqlServer));
                DataSource.Name = "Report";
                var mainQuery = new CustomSqlQuery("Albaranes", "SELECT * FROM [Albaranes] ");
               
                if (!string.IsNullOrEmpty(primarykey))
                {
                mainQuery.Parameters.Add(new QueryParameter("empresa", typeof(string), user.Empresa));
                mainQuery.Parameters.Add(new QueryParameter("referencia",typeof(string),primarykey));
                    mainQuery.Sql = "SELECT * FROM [Albaranes] where empresa=@empresa and referencia=@referencia";
                }
            DataSource.Queries.Add(new CustomSqlQuery("clientes", string.Format("SELECT c.*,d.direccion as [Direccioncliente],d.poblacion as [Poblacioncliente],d.cp as [Cpcliente],d.telefono as [Telefonocliente] FROM [Clientes] as c left join direcciones as d on d.empresa=c.empresa and d.tipotercero={0} and d.fkentidad=c.fkcuentas", (int)TiposCuentas.Clientes)));
            DataSource.Queries.Add(new CustomSqlQuery("empresa", "SELECT e.*,d.direccion as [Direccionempresa],d.poblacion as [Poblacionempresa],d.cp as [Cpempresa],d.telefono as [Telefonoempresa] FROM [Empresas] as e left join direcciones as d on d.empresa=e.id and d.tipotercero=-1 and d.fkentidad=e.id"));
                DataSource.Queries.Add(mainQuery);
                DataSource.Queries.Add(new CustomSqlQuery("Albaraneslin", "SELECT al.*,u.textocorto as [Unidadesdescripcion] FROM [AlbaranesLin] as al" +
                                                                          " inner join Familiasproductos as fp on fp.empresa=al.empresa and fp.id=substring(al.fkarticulos,0,3)" +
                                                                          " left join unidades as u on fp.fkunidadesmedida=u.id"));
                DataSource.Queries.Add(new CustomSqlQuery("Albaranestotales", "SELECT * FROM [AlbaranesTotales]"));
                DataSource.Queries.Add(new CustomSqlQuery("Formaspago", "SELECT * FROM [formaspago]"));
                DataSource.Queries.Add(new CustomSqlQuery("Articulos", "SELECT * FROM Articulos"));
            // Create a master-detail relation between the queries.

            DataSource.Relations.Add("Albaranes", "Albaraneslin", new[] {
                    new RelationColumnInfo("empresa", "empresa"),
                    new RelationColumnInfo("id", "fkalbaranes")});

            DataSource.Relations.Add("Albaraneslin", "Articulos", new[] { 
                new RelationColumnInfo("empresa", "empresa"), 
                new RelationColumnInfo("fkarticulos", "id") });

            DataSource.Relations.Add("Albaranes", "Formaspago", new[] {
                    new RelationColumnInfo("fkformaspago", "id")});

            DataSource.Relations.Add("Albaranes", "Albaranestotales", new[] {
                    new RelationColumnInfo("empresa", "empresa"),
                    new RelationColumnInfo("id", "fkalbaranes")});

                DataSource.Relations.Add("Albaranes", "clientes", new[] {
                    new RelationColumnInfo("empresa", "empresa"),
                    new RelationColumnInfo("fkclientes", "fkcuentas")});

                DataSource.Relations.Add("Albaranes", "empresa", new[] {
                    new RelationColumnInfo("empresa", "id")});


               

                DataSource.RebuildResultSchema();
                
            
        }
    }
}
