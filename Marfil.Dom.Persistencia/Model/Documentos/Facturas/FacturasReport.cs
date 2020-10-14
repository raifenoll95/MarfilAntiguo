using System.Configuration;
using DevExpress.DataAccess.ConnectionParameters;
using DevExpress.DataAccess.Sql;
using Marfil.Dom.Persistencia.Model.Configuracion.Cuentas;
using Marfil.Dom.Persistencia.ServicesView.Servicios;

namespace Marfil.Dom.Persistencia.Model.Documentos.Facturas
{


    class FacturasReport : IReport
    {
        public SqlDataSource DataSource { get; private set; }

        public FacturasReport(IContextService user, string primarykey)
        {


            var server = ConfigurationManager.AppSettings["Server"];
            var usuario = ConfigurationManager.AppSettings["User"];
            var password = ConfigurationManager.AppSettings["Password"];
            DataSource = new SqlDataSource("Report", new MsSqlConnectionParameters(server, user.BaseDatos, usuario, password, MsSqlAuthorizationType.SqlServer));
            DataSource.Name = "Report";
            var mainQuery = new CustomSqlQuery("Facturas", "SELECT * FROM [Facturas] ");
            
            if (!string.IsNullOrEmpty(primarykey))
            {
                mainQuery.Parameters.Add(new QueryParameter("empresa", typeof(string), user.Empresa));
                mainQuery.Parameters.Add(new QueryParameter("referencia", typeof(string), primarykey));
                mainQuery.Sql = "SELECT * FROM [Facturas] where empresa=@empresa and referencia=@referencia";
            }
            DataSource.Queries.Add(new CustomSqlQuery("clientes", string.Format("SELECT c.*,d.direccion as [Direccioncliente],d.poblacion as [Poblacioncliente],d.cp as [Cpcliente],d.telefono as [Telefonocliente] FROM [Clientes] as c left join direcciones as d on d.empresa=c.empresa and d.tipotercero={0} and d.fkentidad=c.fkcuentas", (int)TiposCuentas.Clientes)));
            DataSource.Queries.Add(new CustomSqlQuery("empresa", "SELECT e.*,d.direccion as [Direccionempresa],d.poblacion as [Poblacionempresa],d.cp as [Cpempresa],d.telefono as [Telefonoempresa] FROM [Empresas] as e left join direcciones as d on d.empresa=e.id and d.tipotercero=-1 and d.fkentidad=e.id"));
            DataSource.Queries.Add(mainQuery);
            DataSource.Queries.Add(new CustomSqlQuery("Facturaslin", "SELECT fl.*,u.textocorto as [Unidadesdescripcion], (fl.ancho * 100) AS ancho_cm, (fl.largo * 100) AS largo_cm, (fl.grueso * 100) AS grueso_cm FROM [FacturasLin] as fl  " +
                                                                    " inner join Familiasproductos as fp on fp.empresa=fl.empresa and fp.id=substring(fl.fkarticulos,0,3)" +
                                                                     " left join unidades as u on fp.fkunidadesmedida=u.id"));
            DataSource.Queries.Add(new CustomSqlQuery("Facturastotales", "SELECT * FROM [FacturasTotales]"));
            DataSource.Queries.Add(new CustomSqlQuery("Facturasvencimientos", "SELECT * FROM [Facturasvencimientos]"));
            DataSource.Queries.Add(new CustomSqlQuery("Formaspago", "SELECT * FROM [formaspago]"));
            DataSource.Queries.Add(new CustomSqlQuery("Monedas", "SELECT DISTINCT e.id, m.id, abreviatura FROM Monedas m, Facturas f, Empresas e WHERE m.id = f.fkmonedas"));

            // BANCOSMANDATOS -> Para acceder a los datos bancarios tanto del cliente como de la misma empresa emisora (LL)
            DataSource.Queries.Add(new CustomSqlQuery("BancosMandatos", "SELECT bm.empresa, bm.fkcuentas, bm.descripcion, bm.iban, bm.bic FROM BancosMandatos bm"));

            // Create a master-detail relation between the queries.
            DataSource.Relations.Add("Facturas", "Facturaslin", new[] {
                    new RelationColumnInfo("empresa", "empresa"),
                    new RelationColumnInfo("id", "fkfacturas")
                    });

            DataSource.Relations.Add("Facturas", "Facturastotales", new[] {
                    new RelationColumnInfo("empresa", "empresa"),
                    new RelationColumnInfo("id", "fkfacturas")});

            DataSource.Relations.Add("Facturas", "Facturasvencimientos", new[] {
                    new RelationColumnInfo("empresa", "empresa"),
                    new RelationColumnInfo("id", "fkfacturas")});

            DataSource.Relations.Add("Facturas", "clientes", new[] {
                    new RelationColumnInfo("empresa", "empresa"),
                    new RelationColumnInfo("fkclientes", "fkcuentas")});

            DataSource.Relations.Add("Facturas", "empresa", new[] {
                    new RelationColumnInfo("empresa", "id")});


            DataSource.Relations.Add("Facturas", "Formaspago", new[] {
                    new RelationColumnInfo("fkformaspago", "id")});

            DataSource.Relations.Add("Facturas", "Monedas", new[] {
                    new RelationColumnInfo("empresa", "empresa"),
                    new RelationColumnInfo("fkmonedas", "id")});

            DataSource.Relations.Add("Facturaslin", "Articulos", new[] {
                new RelationColumnInfo("empresa", "empresa"), 
                new RelationColumnInfo("fkarticulos", "id") });

            // EMPRESA <-> BANCOSMANDATOS (LL)
            DataSource.Relations.Add("empresa", "BancosMandatos", new[] {new RelationColumnInfo("id", "empresa")});
            // CLIENTES <-> BANCOSMANDATOS (LL)
            DataSource.Relations.Add("clientes", "BancosMandatos", new[] {
                new RelationColumnInfo("empresa", "empresa"),
                new RelationColumnInfo("cuentatesoreria", "fkcuentas")});

            DataSource.RebuildResultSchema();


        }
    }
}
