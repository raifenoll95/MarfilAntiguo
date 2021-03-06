USE [marfilestable]
GO
/****** Object:  UserDefinedFunction [dbo].[_fn_enum_TipoAlmacenlote]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	Autor		Rafael Fuentes Lopez
	Fecha		13/06/18
	Comentarios
				Obtiene descripcion tal como está definido en la enumeracion C#
				 (sino obtiene mensaje de error)
				    public enum TipoAlmacenlote
						{
							Mercaderia,
							Propio,
							Gestionado,
						}

*/

CREATE FUNCTION [dbo].[_fn_enum_TipoAlmacenlote]
		( @Codigo int)
RETURNS varchar(max)
AS
	BEGIN

	DECLARE @Valor varchar(max)

	SELECT @Valor =
	 CASE
		WHEN @Codigo is null then ''
		WHEN @codigo=0 THEN 'Mercaderia'
		WHEN @codigo=1 THEN 'Propio'
		WHEN @codigo=2 THEN 'Gestionado'
		ELSE 'Indefinido en SQL: _fn_enum_TipoAlmacenlote '
	 END 



RETURN @Valor


END


GO
/****** Object:  Table [dbo].[Acabados]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Acabados](
	[id] [varchar](2) NOT NULL,
	[descripcion] [nvarchar](40) NULL,
	[descripcion2] [nvarchar](40) NULL,
	[descripcionabreviada] [nvarchar](20) NULL,
 CONSTRAINT [PK_Acabados] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Acreedores]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Acreedores](
	[empresa] [varchar](4) NOT NULL,
	[fkcuentas] [varchar](15) NOT NULL,
	[fkidiomas] [varchar](3) NOT NULL,
	[fkfamiliaacreedor] [varchar](3) NULL,
	[fkzonaacreedor] [varchar](3) NULL,
	[fktipoempresa] [varchar](3) NULL,
	[fkunidadnegocio] [varchar](3) NULL,
	[fkincoterm] [varchar](3) NULL,
	[fkpuertosfkpaises] [varchar](3) NULL,
	[fkpuertosid] [varchar](4) NULL,
	[fkmonedas] [int] NOT NULL,
	[fkregimeniva] [varchar](5) NOT NULL,
	[fkgruposiva] [varchar](4) NULL,
	[criterioiva] [int] NOT NULL,
	[fktiposretencion] [varchar](4) NULL,
	[fktransportistahabitual] [varchar](15) NULL,
	[tipoportes] [int] NULL,
	[cuentatesoreria] [nvarchar](15) NULL,
	[fkformaspago] [int] NOT NULL,
	[descuentoprontopago] [float] NULL,
	[descuentocomercial] [float] NULL,
	[diafijopago1] [int] NULL,
	[diafijopago2] [int] NULL,
	[periodonopagodesde] [nvarchar](5) NULL,
	[periodonopagohasta] [nvarchar](5) NULL,
	[notas] [ntext] NULL,
	[tarifa] [nvarchar](50) NULL,
	[fkcriteriosagrupacion] [varchar](4) NULL,
	[previsionpagosperiodicos] [int] NULL,
 CONSTRAINT [PK_Acreedores] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkcuentas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Administrador]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Administrador](
	[password] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Administrador] PRIMARY KEY CLUSTERED 
(
	[password] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Agentes]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Agentes](
	[empresa] [varchar](4) NOT NULL,
	[fkcuentas] [varchar](15) NOT NULL,
	[fktipoirpf] [varchar](4) NULL,
	[fkregimeniva] [varchar](5) NULL,
	[fkformapago] [int] NULL,
	[porcentajecomision] [float] NULL,
	[comisionporm2] [float] NULL,
	[comisionporm3] [float] NULL,
	[porcentajeincrementosobreptb] [float] NULL,
	[primaincrementosobreptb] [float] NULL,
	[porcentajedecrementosobreptb] [float] NULL,
	[primadecrementosobreptb] [float] NULL,
 CONSTRAINT [PK_Agentes] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkcuentas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Albaranes]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Albaranes](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkejercicio] [int] NOT NULL CONSTRAINT [DF__Albaranes__fkeje__2AF556D4]  DEFAULT ((1)),
	[fkseries] [varchar](3) NOT NULL,
	[identificadorsegmento] [varchar](12) NOT NULL,
	[referencia] [varchar](30) NULL,
	[fechadocumento] [datetime] NULL,
	[fechavalidez] [datetime] NULL,
	[fechaentrega] [datetime] NULL,
	[fecharevision] [datetime] NULL,
	[fkalmacen] [varchar](4) NULL,
	[fkclientes] [varchar](15) NULL,
	[nombrecliente] [varchar](200) NULL,
	[clientedireccion] [varchar](100) NULL,
	[clientepoblacion] [varchar](100) NULL,
	[clientecp] [varchar](10) NULL,
	[clientepais] [varchar](50) NULL,
	[clienteprovincia] [varchar](50) NULL,
	[clientetelefono] [varchar](50) NULL,
	[clientefax] [varchar](15) NULL,
	[clienteemail] [varchar](200) NULL,
	[clientenif] [varchar](15) NULL,
	[fkformaspago] [int] NULL,
	[fkagentes] [varchar](15) NULL,
	[fkcomerciales] [varchar](15) NULL,
	[comisionagente] [float] NULL,
	[comisioncomercial] [float] NULL,
	[fkmonedas] [int] NULL,
	[cambioadicional] [float] NULL,
	[importebruto] [float] NULL,
	[importebaseimponible] [float] NULL,
	[importeportes] [float] NULL,
	[porcentajedescuentocomercial] [float] NULL,
	[importedescuentocomercial] [float] NULL,
	[porcentajedescuentoprontopago] [float] NULL,
	[importedescuentoprontopago] [float] NULL,
	[importetotaldoc] [float] NULL,
	[importetotalmonedabase] [float] NULL,
	[notas] [ntext] NULL,
	[fkestados] [varchar](10) NULL,
	[fkobras] [varchar](15) NULL,
	[incoterm] [varchar](3) NULL,
	[descripcionincoterm] [varchar](30) NULL,
	[peso] [int] NULL,
	[confianza] [int] NULL,
	[costemateriales] [float] NULL,
	[tiempooficinatecnica] [float] NULL,
	[fkregimeniva] [varchar](5) NULL,
	[fktransportista] [varchar](15) NULL,
	[tipocambio] [float] NULL,
	[fkpuertosfkpaises] [varchar](3) NULL,
	[fkpuertosid] [varchar](4) NULL,
	[unidadnegocio] [varchar](3) NULL,
	[referenciadocumento] [varchar](30) NULL,
	[fkbancosmandatos] [varchar](3) NULL,
	[cartacredito] [varchar](25) NULL,
	[vencimientocartacredito] [datetime] NULL,
	[contenedores] [int] NULL,
	[fkcuentastesoreria] [varchar](15) NULL,
	[numerodocumentoproveedor] [varchar](30) NULL,
	[fechadocumentoproveedor] [datetime] NULL,
	[fkclientesreserva] [varchar](15) NULL,
	[tipoalbaran] [int] NOT NULL,
	[fkmotivosdevolucion] [varchar](3) NULL,
	[nombretransportista] [varchar](40) NULL,
	[conductor] [varchar](20) NULL,
	[matricula] [varchar](12) NULL,
	[bultos] [int] NULL,
	[pesoneto] [float] NULL,
	[pesobruto] [float] NULL,
	[volumen] [float] NULL,
	[envio] [ntext] NULL,
	[fkoperarios] [varchar](15) NULL,
	[fkoperadortransporte] [varchar](15) NULL,
	[fkzonas] [varchar](3) NULL,
	[fkdireccionfacturacion] [int] NULL,
	[fkcriteriosagrupacion] [varchar](4) NULL,
	[tipoportes] [int] NULL,
	[costeportes] [float] NULL,
	[fkusuarioalta] [uniqueidentifier] NOT NULL CONSTRAINT [DF__Albaranes__fkusu__2724C5F0]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechaalta] [datetime] NOT NULL CONSTRAINT [DF__Albaranes__fecha__2818EA29]  DEFAULT (getdate()),
	[fkusuariomodificacion] [uniqueidentifier] NOT NULL CONSTRAINT [DF__Albaranes__fkusu__290D0E62]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechamodificacion] [datetime] NOT NULL CONSTRAINT [DF__Albaranes__fecha__2A01329B]  DEFAULT (getdate()),
	[fkcarpetas] [uniqueidentifier] NULL,
	[modo] [int] NOT NULL DEFAULT ((0)),
	[integridadreferencial] [uniqueidentifier] NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fkpedidos] [nvarchar](30) NULL,
	[pedidosaldado] [bit] NULL DEFAULT ((0)),
	[fkprospectos] [varchar](15) NULL,
	[tipoalmacenlote] [int] NULL,
 CONSTRAINT [PK_Albaranes_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AlbaranesCompras]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AlbaranesCompras](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkejercicio] [int] NOT NULL CONSTRAINT [DF__AlbaranesCompras__fkeje__2AF556D4]  DEFAULT ((1)),
	[fkseries] [varchar](3) NOT NULL,
	[identificadorsegmento] [nvarchar](12) NULL,
	[referencia] [nvarchar](30) NULL,
	[fechadocumento] [datetime] NULL,
	[fechavalidez] [datetime] NULL,
	[fechaentrega] [datetime] NULL,
	[fecharevision] [datetime] NULL,
	[fkalmacen] [varchar](4) NULL,
	[fkproveedores] [varchar](15) NULL,
	[nombreproveedor] [nvarchar](200) NULL,
	[proveedordireccion] [nvarchar](100) NULL,
	[proveedorpoblacion] [nvarchar](100) NULL,
	[proveedorcp] [nvarchar](10) NULL,
	[proveedorpais] [nvarchar](50) NULL,
	[proveedorprovincia] [nvarchar](50) NULL,
	[proveedortelefono] [nvarchar](50) NULL,
	[proveedorfax] [nvarchar](15) NULL,
	[proveedoremail] [nvarchar](200) NULL,
	[proveedornif] [nvarchar](15) NULL,
	[fkformaspago] [int] NULL,
	[fkagentes] [varchar](15) NULL,
	[fkcomerciales] [varchar](15) NULL,
	[comisionagente] [float] NULL,
	[comisioncomercial] [float] NULL,
	[fkmonedas] [int] NULL,
	[cambioadicional] [float] NULL,
	[importebruto] [float] NULL,
	[importebaseimponible] [float] NULL,
	[importeportes] [float] NULL,
	[porcentajedescuentocomercial] [float] NULL,
	[importedescuentocomercial] [float] NULL,
	[porcentajedescuentoprontopago] [float] NULL,
	[importedescuentoprontopago] [float] NULL,
	[importetotaldoc] [float] NULL,
	[importetotalmonedabase] [float] NULL,
	[notas] [ntext] NULL,
	[fkestados] [varchar](10) NULL,
	[fkobras] [varchar](15) NULL,
	[incoterm] [nvarchar](3) NULL,
	[descripcionincoterm] [nvarchar](30) NULL,
	[peso] [int] NULL,
	[confianza] [int] NULL,
	[costemateriales] [float] NULL,
	[tiempooficinatecnica] [float] NULL,
	[fkregimeniva] [varchar](5) NULL,
	[fktransportista] [varchar](15) NULL,
	[tipocambio] [float] NULL,
	[fkpuertosfkpaises] [varchar](3) NULL,
	[fkpuertosid] [varchar](4) NULL,
	[unidadnegocio] [nvarchar](3) NULL,
	[referenciadocumento] [nvarchar](30) NULL,
	[fkbancosmandatos] [varchar](3) NULL,
	[cartacredito] [nvarchar](25) NULL,
	[vencimientocartacredito] [datetime] NULL,
	[contenedores] [int] NULL,
	[fkcuentastesoreria] [varchar](15) NULL,
	[numerodocumentoproveedor] [nvarchar](30) NULL,
	[fechadocumentoproveedor] [datetime] NULL,
	[fkclientesreserva] [varchar](15) NULL,
	[tipoalbaran] [int] NOT NULL,
	[fkmotivosdevolucion] [varchar](3) NULL,
	[nombretransportista] [nvarchar](40) NULL,
	[conductor] [nvarchar](20) NULL,
	[matricula] [nvarchar](12) NULL,
	[bultos] [int] NULL,
	[pesoneto] [float] NULL,
	[pesobruto] [float] NULL,
	[volumen] [float] NULL,
	[envio] [ntext] NULL,
	[fkoperarios] [varchar](15) NULL,
	[fkoperadortransporte] [varchar](15) NULL,
	[fkzonas] [varchar](3) NULL,
	[fkdireccionfacturacion] [int] NULL,
	[fkcriteriosagrupacion] [varchar](4) NULL,
	[tipoportes] [int] NULL,
	[costeportes] [float] NULL,
	[fkusuarioalta] [uniqueidentifier] NOT NULL CONSTRAINT [DF__AlbaranesCompras__fkusu__2724C5F0]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechaalta] [datetime] NOT NULL CONSTRAINT [DF__AlbaranesCompras__fecha__2818EA29]  DEFAULT (getdate()),
	[fkusuariomodificacion] [uniqueidentifier] NOT NULL CONSTRAINT [DF__AlbaranesCompras__fkusu__290D0E62]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechamodificacion] [datetime] NOT NULL CONSTRAINT [DF__AlbaranesCompras__fecha__2A01329B]  DEFAULT (getdate()),
	[fkcarpetas] [uniqueidentifier] NULL,
	[integridadreferenciaflag] [uniqueidentifier] NULL,
	[modo] [int] NOT NULL DEFAULT ((0)),
	[fkpedidoscompras] [nvarchar](30) NULL,
	[pedidosaldado] [bit] NULL DEFAULT ((0)),
	[tipoalmacenlote] [int] NULL,
 CONSTRAINT [PK_AlbaranesCompras_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AlbaranesComprasCostesadicionales]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AlbaranesComprasCostesadicionales](
	[empresa] [varchar](4) NOT NULL,
	[fkalbaranescompras] [int] NOT NULL,
	[id] [int] NOT NULL,
	[tipodocumento] [int] NOT NULL,
	[referenciadocumento] [nvarchar](30) NULL,
	[importe] [float] NULL,
	[porcentaje] [float] NULL,
	[total] [float] NULL,
	[tipocoste] [int] NOT NULL,
	[tiporeparto] [int] NOT NULL,
	[notas] [ntext] NULL,
 CONSTRAINT [PK_AlbaranesComprasCostesadicionales] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkalbaranescompras] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AlbaranesComprasLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AlbaranesComprasLin](
	[empresa] [varchar](4) NOT NULL,
	[fkalbaranes] [int] NOT NULL CONSTRAINT [DF__AlbaranesCompras__fkalb__2BE97B0D]  DEFAULT ((1)),
	[id] [int] NOT NULL,
	[fkarticulos] [varchar](15) NULL,
	[descripcion] [nvarchar](120) NULL,
	[lote] [nvarchar](12) NULL,
	[tabla] [int] NULL,
	[cantidad] [float] NULL,
	[cantidadpedida] [float] NULL,
	[largo] [float] NULL,
	[ancho] [float] NULL,
	[grueso] [float] NULL,
	[fkunidades] [varchar](2) NULL,
	[metros] [float] NULL,
	[precio] [float] NULL,
	[porcentajedescuento] [float] NULL,
	[importedescuento] [float] NULL,
	[fktiposiva] [varchar](3) NULL,
	[porcentajeiva] [float] NULL,
	[cuotaiva] [float] NULL,
	[porcentajerecargoequivalencia] [float] NULL,
	[cuotarecargoequivalencia] [float] NULL,
	[importe] [float] NULL,
	[importenetolinea] [float] NULL,
	[notas] [ntext] NULL,
	[documentoorigen] [nvarchar](15) NULL,
	[documentodestino] [nvarchar](15) NULL,
	[canal] [nvarchar](3) NULL,
	[precioanterior] [float] NULL,
	[revision] [nvarchar](1) NULL,
	[decimalesmonedas] [int] NULL,
	[decimalesmedidas] [int] NULL,
	[bundle] [nvarchar](2) NULL,
	[tblnum] [int] NULL,
	[contenedor] [nvarchar](12) NULL,
	[sello] [nvarchar](10) NULL,
	[caja] [int] NULL,
	[pesoneto] [float] NULL,
	[pesobruto] [float] NULL,
	[seccion] [nvarchar](4) NULL,
	[costeadicionalmaterial] [float] NULL,
	[costeadicionalportes] [float] NULL,
	[costeadicionalotro] [float] NULL,
	[costeacicionalvariable] [float] NULL,
	[orden] [int] NULL,
	[fkpedidos] [int] NULL,
	[fkpedidosid] [int] NULL,
	[fkpedidosreferencia] [varchar](30) NULL,
	[fkcontadoreslotes] [varchar](12) NULL,
	[flagidentifier] [uniqueidentifier] NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[tipoalmacenlote] [int] NULL,
 CONSTRAINT [PK_AlbaranesComprasLin_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkalbaranes] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AlbaranesComprasTotales]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AlbaranesComprasTotales](
	[empresa] [varchar](4) NOT NULL,
	[fkalbaranes] [int] NOT NULL CONSTRAINT [DF__AlbaranesCompras__fkalb__2CDD9F46]  DEFAULT ((1)),
	[fktiposiva] [varchar](3) NOT NULL,
	[brutototal] [float] NULL,
	[porcentajerecargoequivalencia] [float] NULL,
	[importerecargoequivalencia] [float] NULL,
	[porcentajedescuentoprontopago] [float] NULL,
	[importedescuentoprontopago] [float] NULL,
	[porcentajedescuentocomercial] [float] NULL,
	[importedescuentocomercial] [float] NULL,
	[basetotal] [float] NULL,
	[porcentajeiva] [float] NULL,
	[cuotaiva] [float] NULL,
	[subtotal] [float] NULL,
	[decimalesmonedas] [int] NULL,
 CONSTRAINT [PK_AlbaranesComprasTotales_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkalbaranes] ASC,
	[fktiposiva] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AlbaranesLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AlbaranesLin](
	[empresa] [varchar](4) NOT NULL,
	[fkalbaranes] [int] NOT NULL CONSTRAINT [DF__Albaranes__fkalb__2BE97B0D]  DEFAULT ((1)),
	[id] [int] NOT NULL,
	[fkarticulos] [varchar](15) NULL,
	[descripcion] [nvarchar](120) NULL,
	[lote] [nvarchar](12) NULL,
	[tabla] [int] NULL,
	[cantidad] [float] NULL,
	[cantidadpedida] [float] NULL,
	[largo] [float] NULL,
	[ancho] [float] NULL,
	[grueso] [float] NULL,
	[fkunidades] [varchar](2) NULL,
	[metros] [float] NULL,
	[precio] [float] NULL,
	[porcentajedescuento] [float] NULL,
	[importedescuento] [float] NULL,
	[fktiposiva] [varchar](3) NULL,
	[porcentajeiva] [float] NULL,
	[cuotaiva] [float] NULL,
	[porcentajerecargoequivalencia] [float] NULL,
	[cuotarecargoequivalencia] [float] NULL,
	[importe] [float] NULL,
	[importenetolinea] [float] NULL,
	[notas] [ntext] NULL,
	[documentoorigen] [nvarchar](15) NULL,
	[documentodestino] [nvarchar](15) NULL,
	[canal] [nvarchar](3) NULL,
	[precioanterior] [float] NULL,
	[revision] [nvarchar](1) NULL,
	[decimalesmonedas] [int] NULL,
	[decimalesmedidas] [int] NULL,
	[bundle] [nvarchar](2) NULL,
	[tblnum] [int] NULL,
	[contenedor] [nvarchar](12) NULL,
	[sello] [nvarchar](10) NULL,
	[caja] [int] NULL,
	[pesoneto] [float] NULL,
	[pesobruto] [float] NULL,
	[seccion] [nvarchar](4) NULL,
	[costeadicionalmaterial] [float] NULL,
	[costeadicionalportes] [float] NULL,
	[costeadicionalotro] [float] NULL,
	[costeacicionalvariable] [float] NULL,
	[orden] [int] NULL,
	[fkpedidos] [int] NULL,
	[fkpedidosid] [int] NULL,
	[fkpedidosreferencia] [varchar](30) NULL,
	[flagidentifier] [uniqueidentifier] NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[tipoalmacenlote] [int] NULL,
 CONSTRAINT [PK_AlbaranesLin_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkalbaranes] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AlbaranesTotales]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AlbaranesTotales](
	[empresa] [varchar](4) NOT NULL,
	[fkalbaranes] [int] NOT NULL CONSTRAINT [DF__Albaranes__fkalb__2CDD9F46]  DEFAULT ((1)),
	[fktiposiva] [varchar](3) NOT NULL,
	[brutototal] [float] NULL,
	[porcentajerecargoequivalencia] [float] NULL,
	[importerecargoequivalencia] [float] NULL,
	[porcentajedescuentoprontopago] [float] NULL,
	[importedescuentoprontopago] [float] NULL,
	[porcentajedescuentocomercial] [float] NULL,
	[importedescuentocomercial] [float] NULL,
	[basetotal] [float] NULL,
	[porcentajeiva] [float] NULL,
	[cuotaiva] [float] NULL,
	[subtotal] [float] NULL,
	[decimalesmonedas] [int] NULL,
 CONSTRAINT [PK_AlbaranesTotales_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkalbaranes] ASC,
	[fktiposiva] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Almacenes]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Almacenes](
	[empresa] [varchar](4) NOT NULL,
	[id] [varchar](4) NOT NULL,
	[descripcion] [nvarchar](200) NULL,
	[coordenadas] [nvarchar](40) NULL,
 CONSTRAINT [PK_Almacenes] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AlmacenesZona]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AlmacenesZona](
	[empresa] [varchar](4) NOT NULL,
	[fkalmacenes] [varchar](4) NOT NULL,
	[id] [int] NOT NULL,
	[descripcion] [nvarchar](30) NULL,
	[fktipoubicacion] [varchar](3) NULL,
	[coordenadas] [nvarchar](40) NULL,
 CONSTRAINT [PK_AlmacenesZona] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkalmacenes] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AppPermisos]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppPermisos](
	[id] [uniqueidentifier] NOT NULL,
	[descripcion] [nvarchar](100) NULL,
	[preferencias] [ntext] NULL,
 CONSTRAINT [PK_AppPermisos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AppPermisosRoles]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppPermisosRoles](
	[fkRoles] [uniqueidentifier] NOT NULL,
	[fkAppPermisos] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_AppPermisosRoles] PRIMARY KEY CLUSTERED 
(
	[fkRoles] ASC,
	[fkAppPermisos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AppPermisosUsuarios]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppPermisosUsuarios](
	[fkUsuarios] [uniqueidentifier] NOT NULL,
	[fkAppPermisos] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_AppPermisosUsuarios] PRIMARY KEY CLUSTERED 
(
	[fkUsuarios] ASC,
	[fkAppPermisos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Articulos]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Articulos](
	[empresa] [varchar](4) NOT NULL,
	[id] [varchar](15) NOT NULL,
	[descripcion] [nvarchar](120) NULL,
	[descripcion2] [nvarchar](120) NULL,
	[descripcionabreviada] [nvarchar](120) NULL,
	[coste] [float] NULL,
	[preciominimoventa] [float] NULL,
	[preciomateriaprima] [float] NULL,
	[porcentajemerma] [float] NULL,
	[costemateriaprima] [float] NULL,
	[costeelaboracionmateriaprima] [float] NULL,
	[costeportes] [float] NULL,
	[otroscostes] [float] NULL,
	[costefabricacion] [float] NULL,
	[costeindirecto] [float] NULL,
	[largo] [float] NULL,
	[ancho] [float] NULL,
	[grueso] [float] NULL,
	[fkgruposiva] [varchar](4) NULL,
	[fkguiascontables] [varchar](12) NULL,
	[editarlargo] [bit] NULL,
	[editarancho] [bit] NULL,
	[editargrueso] [bit] NULL,
	[fkgruposmateriales] [varchar](3) NULL,
	[partidaarancelaria] [nvarchar](10) NULL,
	[kilosud] [float] NULL,
	[medidalibre] [bit] NULL,
	[labor] [bit] NULL,
	[fklabores] [varchar](3) NULL,
	[excluircomisiones] [bit] NULL,
	[exentoretencion] [bit] NULL,
	[gestionarcaducidad] [bit] NULL,
	[tiempostandardfabricacion] [float] NULL,
	[gestionstock] [bit] NULL,
	[tipogestionlotes] [int] NULL,
	[stocknegativoautorizado] [bit] NULL,
	[existenciasminimasmetros] [float] NULL,
	[existenciasmaximasmetros] [float] NULL,
	[existenciasminimasunidades] [float] NULL,
	[existenciasmaximasunidades] [float] NULL,
	[web] [bit] NULL,
	[rendimientom2m3] [float] NULL,
	[articulonegocio] [bit] NULL,
	[articulocomentario] [bit] NULL,
	[lotefraccionable] [bit] NOT NULL DEFAULT ((0)),
	[tipoivavariable] [bit] NOT NULL DEFAULT ((0)),
	[piezascaja] [int] NULL,
	[categoria] [int] NOT NULL DEFAULT ((0)),
	[fechaultimaentrada] [datetime] NULL,
	[ultimaentrada] [varchar](30) NULL,
	[fechaultimasalida] [datetime] NULL,
	[ultimasalida] [varchar](30) NULL,
	[fkcarpetas] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Articulos] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Aseguradoras]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Aseguradoras](
	[empresa] [varchar](4) NOT NULL,
	[fkcuentas] [varchar](10) NOT NULL,
	[numeropoliza] [nvarchar](25) NULL,
	[fechainicio] [datetime] NULL,
	[fechafin] [datetime] NULL,
	[diasimpago] [int] NULL,
	[diasimpagovencimientoprorrogado] [int] NULL,
	[numeroprorrogas] [int] NULL,
	[primaanual] [float] NULL,
	[numerorecibos] [int] NULL,
	[porcentajecoberturariesgo] [float] NULL,
 CONSTRAINT [PK_Aseguradoras] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkcuentas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Bancos]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Bancos](
	[id] [varchar](4) NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[bic] [nvarchar](50) NULL,
 CONSTRAINT [PK_Bancos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BancosMandatos]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BancosMandatos](
	[empresa] [varchar](4) NOT NULL,
	[fkcuentas] [varchar](15) NOT NULL,
	[id] [varchar](3) NOT NULL,
	[descripcion] [nvarchar](100) NULL,
	[fkpaises] [varchar](3) NULL,
	[iban] [nvarchar](34) NULL,
	[bic] [nvarchar](15) NULL,
	[sufijoacreedor] [nvarchar](3) NULL,
	[contratoconfirmig] [nvarchar](12) NULL,
	[contadorconfirming] [nvarchar](10) NULL,
	[direccion] [nvarchar](100) NULL,
	[cpostal] [nvarchar](10) NULL,
	[ciudad] [nvarchar](50) NULL,
	[fkprovincias] [varchar](2) NULL,
	[telefonobanco] [nvarchar](20) NULL,
	[personacontacto] [nvarchar](50) NULL,
	[idmandato] [nvarchar](35) NULL,
	[idacreedor] [nvarchar](35) NULL,
	[tiposecuenciasepa] [int] NULL,
	[tipoadeudo] [int] NULL,
	[importemandato] [float] NULL,
	[recibosmandato] [int] NULL,
	[importelimiterecibo] [float] NULL,
	[fechafirma] [datetime] NULL,
	[fechaexpiracion] [datetime] NULL,
	[fechaultimaremesa] [datetime] NULL,
	[importeremesados] [float] NULL,
	[recibosremesados] [int] NULL,
	[devolvera] [nvarchar](60) NULL,
	[notas] [ntext] NULL,
	[defecto] [bit] NULL,
	[finalizado] [bit] NULL,
	[esquema] [int] NULL,
	[bloqueada] [bit] NULL,
	[fkMotivosbloqueo] [varchar](3) NULL,
	[fechamodificacionbloqueo] [datetime] NULL,
	[fkUsuariobloqueo] [uniqueidentifier] NULL,
	[riesgonacional] [nvarchar](50) NULL,
	[riesgoextranjero] [nvarchar](50) NULL,
 CONSTRAINT [PK_BancosMandatos] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkcuentas] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Bundle]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Bundle](
	[empresa] [varchar](4) NOT NULL,
	[lote] [varchar](15) NOT NULL,
	[id] [varchar](12) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[fkalmacen] [varchar](4) NULL,
	[descripcion] [nvarchar](200) NULL,
	[fkzonaalmacen] [int] NULL,
	[notas] [ntext] NULL,
	[fkoperarios] [varchar](15) NULL,
	[pesoneto] [float] NULL,
	[pesobruto] [float] NULL,
	[estado] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_Bundle] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[lote] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BundleLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BundleLin](
	[empresa] [varchar](4) NOT NULL,
	[fkbundlelote] [varchar](15) NOT NULL,
	[fkbundle] [varchar](12) NOT NULL,
	[id] [int] NOT NULL,
	[lote] [nvarchar](15) NULL,
	[loteid] [nvarchar](15) NULL,
	[fkarticulos] [varchar](15) NULL,
	[descripcion] [nvarchar](200) NULL,
	[coste] [float] NULL,
	[largo] [float] NULL,
	[ancho] [float] NULL,
	[grueso] [float] NULL,
	[metros] [float] NULL,
	[cantidad] [float] NULL,
	[fkunidades] [varchar](2) NOT NULL,
	[decimalesunidades] [int] NOT NULL,
	[decimalesprecio] [int] NOT NULL,
	[fkalmacenes] [varchar](4) NULL,
 CONSTRAINT [PK_BundleLin] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkbundlelote] ASC,
	[fkbundle] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Campañas]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Campañas](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] NOT NULL,
	[fkseries] [varchar](3) NOT NULL,
	[identificadorsegmento] [nvarchar](12) NULL,
	[referencia] [varchar](15) NULL,
	[fechadocumento] [datetime] NULL,
	[asunto] [varchar](100) NULL,
	[fechaultimoseguimiento] [datetime] NULL,
	[fechaproximoseguimiento] [datetime] NULL,
	[fketapa] [varchar](10) NULL,
	[prioridad] [int] NULL,
	[fkmodocontacto] [varchar](3) NULL,
	[fkoperario] [varchar](15) NULL,
	[fkcomercial] [varchar](15) NULL,
	[fkagente] [varchar](15) NULL,
	[notas] [varchar](max) NULL,
	[coste] [int] NULL,
	[cerrado] [bit] NULL,
	[fechacierre] [datetime] NULL,
	[fkreaccion] [varchar](3) NULL,
 CONSTRAINT [PK_Campañas] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Caracteristicas]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Caracteristicas](
	[empresa] [varchar](4) NOT NULL,
	[id] [varchar](2) NOT NULL,
 CONSTRAINT [PK_Caracteristicas] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CaracteristicasLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CaracteristicasLin](
	[empresa] [varchar](4) NOT NULL,
	[fkcaracteristicas] [varchar](2) NOT NULL,
	[id] [varchar](2) NOT NULL,
	[descripcion] [nvarchar](40) NULL,
	[descripcion2] [nvarchar](40) NULL,
	[descripcionabreviada] [nvarchar](20) NULL,
 CONSTRAINT [PK_CaracteristicasLin] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkcaracteristicas] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Carpetas]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Carpetas](
	[empresa] [varchar](4) NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[nombre] [nvarchar](100) NULL,
	[fkcarpetas] [uniqueidentifier] NULL,
	[ruta] [nvarchar](max) NULL,
 CONSTRAINT [PK_Carpetas] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Clientes](
	[empresa] [varchar](4) NOT NULL,
	[fkcuentas] [varchar](15) NOT NULL,
	[fkidiomas] [varchar](3) NOT NULL,
	[fkfamiliacliente] [varchar](3) NULL,
	[fkzonacliente] [varchar](3) NULL,
	[fktipoempresa] [varchar](3) NULL,
	[fkunidadnegocio] [varchar](3) NULL,
	[fkincoterm] [varchar](3) NULL,
	[fkpuertosfkpaises] [varchar](3) NULL,
	[fkpuertosid] [varchar](4) NULL,
	[fkmonedas] [int] NOT NULL,
	[fkregimeniva] [varchar](5) NOT NULL,
	[fkgruposiva] [varchar](4) NULL,
	[criterioiva] [int] NOT NULL,
	[fktiposretencion] [varchar](4) NULL,
	[fktransportistahabitual] [varchar](15) NULL,
	[tipoportes] [int] NULL,
	[cuentatesoreria] [nvarchar](15) NULL,
	[fkformaspago] [int] NOT NULL,
	[descuentoprontopago] [float] NULL,
	[descuentocomercial] [float] NULL,
	[diafijopago1] [int] NULL,
	[diafijopago2] [int] NULL,
	[periodonopagodesde] [nvarchar](5) NULL,
	[periodonopagohasta] [nvarchar](5) NULL,
	[notas] [ntext] NULL,
	[numerocopiasfactura] [int] NULL,
	[fkcuentasagente] [varchar](15) NULL,
	[fkcuentascomercial] [varchar](15) NULL,
	[perteneceagrupo] [nvarchar](50) NULL,
	[tarifa] [int] NULL,
	[fkcuentasaseguradoras] [varchar](15) NULL,
	[suplemento] [nvarchar](10) NULL,
	[porcentajeriesgocomercial] [float] NULL,
	[porcentajeriesgopolitico] [float] NULL,
	[riesgoconcedidoempresa] [int] NULL,
	[riesgosolicitado] [int] NULL,
	[riesgoaseguradora] [int] NULL,
	[fechaclasificacion] [datetime] NULL,
	[fechaultimasolicitud] [datetime] NULL,
	[diascondecidos] [int] NULL,
	[fktarifas] [varchar](12) NULL,
	[fkcriteriosagrupacion] [varchar](4) NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkcuentas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Comerciales]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Comerciales](
	[empresa] [varchar](4) NOT NULL,
	[fkcuentas] [varchar](15) NOT NULL,
	[fktipoirpf] [varchar](4) NULL,
	[fkregimeniva] [varchar](5) NULL,
	[fkformapago] [int] NULL,
	[porcentajecomision] [float] NULL,
	[comisionporm2] [float] NULL,
	[comisionporm3] [float] NULL,
	[porcentajeincrementosobreptb] [float] NULL,
	[primaincrementosobreptb] [float] NULL,
	[porcentajedecrementosobreptb] [float] NULL,
	[primadecrementosobreptb] [float] NULL,
 CONSTRAINT [PK_Comerciales] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkcuentas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Configuracion]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Configuracion](
	[id] [int] NOT NULL,
	[xml] [xml] NULL,
	[cargadatos] [int] NULL,
 CONSTRAINT [PK_Configuracion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Configuraciongraficas]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Configuraciongraficas](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[usuario] [uniqueidentifier] NOT NULL,
	[idlistado] [varchar](50) NOT NULL,
	[titulo] [varchar](200) NULL,
	[agruparpor] [varchar](200) NULL,
	[valores] [text] NULL,
	[intervalotemporal] [int] NULL,
	[apareceinicio] [bit] NULL,
	[tipografica] [int] NOT NULL,
	[filtros] [xml] NULL,
 CONSTRAINT [PK_Configuraciongraficas_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Contactos]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Contactos](
	[empresa] [varchar](4) NOT NULL,
	[tipotercero] [int] NOT NULL,
	[fkentidad] [varchar](15) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](100) NULL,
	[fktipocontacto] [varchar](3) NULL,
	[fkcargoempresa] [varchar](3) NULL,
	[fkidioma] [varchar](3) NULL,
	[telefono] [nvarchar](15) NULL,
	[telefonomovil] [nvarchar](15) NULL,
	[fax] [nvarchar](15) NULL,
	[email] [nvarchar](200) NULL,
	[nifcif] [nvarchar](15) NULL,
	[observaciones] [ntext] NULL,
	[fktipodireccion_direccion] [int] NULL,
	[fkentidad_direccion] [varchar](15) NULL,
	[fkid_direccion] [int] NULL,
	[fktipoidentificacion_nif] [varchar](3) NULL,
 CONSTRAINT [PK_Contactos] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[tipotercero] ASC,
	[fkentidad] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Contadores]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Contadores](
	[empresa] [varchar](4) NOT NULL,
	[id] [varchar](12) NOT NULL,
	[descripcion] [nvarchar](40) NULL,
	[tipoinicio] [int] NULL,
	[primerdocumento] [int] NULL,
	[tipocontador] [int] NULL,
 CONSTRAINT [PK_Contador] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContadoresContabilidad]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContadoresContabilidad](
	[empresa] [varchar](4) NOT NULL,
	[id] [varchar](12) NOT NULL,
	[descripcion] [nvarchar](40) NULL,
	[tipoinicio] [int] NULL,
	[primerdocumento] [int] NULL,
	[tipocontador] [int] NULL,
	[tipodocumento] [int] NOT NULL,
 CONSTRAINT [PK_ContadorContabilidad] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContadoresContabilidadLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContadoresContabilidadLin](
	[empresa] [varchar](4) NOT NULL,
	[fkcontadores] [varchar](12) NOT NULL,
	[id] [int] NOT NULL,
	[tiposegmento] [int] NULL,
	[longitud] [int] NULL,
	[valor] [nvarchar](20) NULL,
 CONSTRAINT [PK_ContadoresContabilidadLin] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkcontadores] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContadoresLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContadoresLin](
	[empresa] [varchar](4) NOT NULL,
	[fkcontadores] [varchar](12) NOT NULL,
	[id] [int] NOT NULL,
	[tiposegmento] [int] NULL,
	[longitud] [int] NULL,
	[valor] [nvarchar](20) NULL,
 CONSTRAINT [PK_ContadoresLin] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkcontadores] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContadoresLotes]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContadoresLotes](
	[empresa] [varchar](4) NOT NULL,
	[id] [varchar](12) NOT NULL,
	[descripcion] [nvarchar](40) NULL,
	[tipoinicio] [int] NULL,
	[primerdocumento] [int] NULL,
	[tipocontador] [int] NULL,
	[offset] [int] NULL DEFAULT ((0)),
 CONSTRAINT [PK_ContadorLotes] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContadoresLotesLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContadoresLotesLin](
	[empresa] [varchar](4) NOT NULL,
	[fkcontadores] [varchar](12) NOT NULL,
	[id] [int] NOT NULL,
	[tiposegmento] [int] NULL,
	[longitud] [int] NULL,
	[valor] [nvarchar](20) NULL,
 CONSTRAINT [PK_ContadoresLotesLin] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkcontadores] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Criteriosagrupacion]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Criteriosagrupacion](
	[id] [varchar](4) NOT NULL,
	[nombre] [nvarchar](150) NULL,
	[ordenaralbaranes] [bit] NULL,
 CONSTRAINT [PK_Criteriosagrupacion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CriteriosagrupacionLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CriteriosagrupacionLin](
	[fkcriteriosagrupacion] [varchar](4) NOT NULL,
	[id] [int] NOT NULL,
	[campo] [int] NOT NULL,
	[orden] [int] NULL,
 CONSTRAINT [PK_CriteriosagrupacionLin] PRIMARY KEY CLUSTERED 
(
	[fkcriteriosagrupacion] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cuentas]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cuentas](
	[empresa] [varchar](4) NOT NULL,
	[id] [varchar](15) NOT NULL,
	[descripcion] [nvarchar](200) NULL,
	[descripcion2] [nvarchar](200) NULL,
	[nivel] [int] NULL,
	[nif] [nvarchar](15) NULL,
	[fkPais] [varchar](3) NULL,
	[bloqueada] [bit] NULL,
	[fkMotivosbloqueo] [varchar](3) NULL,
	[tipocuenta] [int] NULL,
	[fechaalta] [datetime] NULL,
	[fechamodificacion] [datetime] NULL,
	[fkUsuarios] [uniqueidentifier] NULL,
	[fechamodificacionbloqueo] [datetime] NULL,
	[fkUsuariobloqueo] [uniqueidentifier] NULL,
	[contrapartida] [nvarchar](10) NULL,
	[fktipoidentificacion_nif] [varchar](3) NULL,
	[categoria] [int] NULL,
 CONSTRAINT [PK_Cuentas] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cuentastesoreria]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cuentastesoreria](
	[empresa] [varchar](4) NOT NULL,
	[fkcuentas] [varchar](15) NOT NULL,
 CONSTRAINT [PK_Cuentastesoreria] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkcuentas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Direcciones]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Direcciones](
	[empresa] [varchar](4) NOT NULL,
	[tipotercero] [int] NOT NULL,
	[fkentidad] [varchar](15) NOT NULL,
	[id] [int] NOT NULL,
	[defecto] [bit] NULL,
	[descripcion] [nvarchar](100) NULL,
	[fktipovia] [varchar](3) NULL,
	[direccion] [ntext] NULL,
	[poblacion] [nvarchar](100) NULL,
	[cp] [nvarchar](10) NULL,
	[fkpais] [varchar](3) NULL,
	[fkprovincia] [varchar](2) NULL,
	[personacontacto] [nvarchar](30) NULL,
	[telefono] [nvarchar](15) NULL,
	[telefonomovil] [nvarchar](15) NULL,
	[fax] [nvarchar](15) NULL,
	[email] [nvarchar](200) NULL,
	[web] [ntext] NULL,
	[notas] [ntext] NULL,
	[fktipodireccion] [varchar](3) NULL,
 CONSTRAINT [PK_Direcciones] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[tipotercero] ASC,
	[fkentidad] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DocumentosUsuario]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DocumentosUsuario](
	[fkusuario] [uniqueidentifier] NOT NULL,
	[tipo] [int] NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[tipoprivacidad] [int] NOT NULL,
	[tiporeport] [int] NOT NULL,
	[datos] [varbinary](max) NULL,
 CONSTRAINT [PK_DocumentosUsuario_1] PRIMARY KEY CLUSTERED 
(
	[fkusuario] ASC,
	[tipo] ASC,
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ejercicios]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ejercicios](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [nvarchar](120) NULL,
	[descripcioncorta] [nvarchar](10) NULL,
	[desde] [datetime] NULL,
	[hasta] [datetime] NULL,
	[estado] [int] NULL,
	[contabilidadcerradahasta] [datetime] NULL,
	[registroivacerradohasta] [datetime] NULL,
	[criterioiva] [int] NULL,
	[fkejercicios] [int] NULL,
	[fkseriescontables] [varchar](3) NULL,
 CONSTRAINT [PK_Ejercicios] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Empresas]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empresas](
	[id] [varchar](4) NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[nif] [nvarchar](15) NULL,
	[fktipoidentificacion_nif] [varchar](3) NULL,
	[razonsocial] [nvarchar](200) NULL,
	[fkPais] [varchar](3) NULL,
	[Fkplangeneralcontable] [uniqueidentifier] NULL,
	[administrador] [nvarchar](100) NULL,
	[nifcifadministrador] [nvarchar](15) NULL,
	[fktipoidentificacion_nifcifadministrador] [varchar](3) NULL,
	[actividadprincipal] [nvarchar](100) NULL,
	[cnae] [nvarchar](10) NULL,
	[nivel] [int] NULL,
	[fkMonedabase] [int] NULL,
	[fkMonedaadicional] [int] NULL,
	[digitoscuentas] [int] NULL,
	[nivelcuentas] [int] NULL,
	[cuentasanuales] [nvarchar](100) NULL,
	[cuentasperdidas] [nvarchar](100) NULL,
	[criterioiva] [int] NULL,
	[liquidacioniva] [int] NULL,
	[tipoempresa] [nvarchar](3) NULL,
	[datosregistrales] [ntext] NULL,
	[fktarifasventas] [varchar](12) NULL,
	[fktarifascompras] [varchar](12) NULL,
	[fkregimeniva] [varchar](5) NULL,
	[fkCuentaEntradasVariasAlmacen] [varchar](15) NULL,
	[fkCuentaSalidasVariasAlmacen] [varchar](15) NULL,
 CONSTRAINT [PK_Empresas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Estados]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Estados](
	[documento] [int] NOT NULL,
	[id] [varchar](3) NOT NULL,
	[descripcion] [nvarchar](25) NULL,
	[imputariesgo] [bit] NULL,
	[tipoestado] [int] NULL,
	[notas] [ntext] NULL,
	[tipomovimiento] [int] NULL,
 CONSTRAINT [PK_Estados] PRIMARY KEY CLUSTERED 
(
	[documento] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Facturas](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkejercicio] [int] NOT NULL CONSTRAINT [DF__Facturas__fkejer__31A25463]  DEFAULT ((1)),
	[fkseries] [varchar](3) NOT NULL,
	[identificadorsegmento] [nvarchar](12) NULL,
	[referencia] [nvarchar](30) NULL,
	[fechadocumento] [datetime] NULL,
	[fkalmacen] [varchar](4) NULL,
	[fkclientes] [varchar](15) NULL,
	[nombrecliente] [nvarchar](200) NULL,
	[clientedireccion] [nvarchar](100) NULL,
	[clientepoblacion] [nvarchar](100) NULL,
	[clientecp] [nvarchar](10) NULL,
	[clientepais] [nvarchar](50) NULL,
	[clienteprovincia] [nvarchar](50) NULL,
	[clientetelefono] [nvarchar](50) NULL,
	[clientefax] [nvarchar](15) NULL,
	[clienteemail] [nvarchar](200) NULL,
	[clientenif] [nvarchar](15) NULL,
	[fkformaspago] [int] NULL,
	[fkmonedas] [int] NULL,
	[cambioadicional] [float] NULL,
	[cobrado] [bit] NULL,
	[facturarectificativa] [bit] NULL,
	[fkfacturarectificada] [varchar](30) NULL,
	[fkmotivorectificacion] [varchar](3) NULL,
	[importebruto] [float] NULL,
	[importebaseimponible] [float] NULL,
	[importeportes] [float] NULL,
	[porcentajedescuentocomercial] [float] NULL,
	[importedescuentocomercial] [float] NULL,
	[porcentajedescuentoprontopago] [float] NULL,
	[importedescuentoprontopago] [float] NULL,
	[importetotaldoc] [float] NULL,
	[importetotalmonedabase] [float] NULL,
	[notas] [ntext] NULL,
	[fkestados] [varchar](10) NULL,
	[fkobras] [varchar](15) NULL,
	[incoterm] [nvarchar](3) NULL,
	[descripcionincoterm] [nvarchar](30) NULL,
	[peso] [int] NULL,
	[confianza] [int] NULL,
	[costemateriales] [float] NULL,
	[tiempooficinatecnica] [float] NULL,
	[fkregimeniva] [varchar](5) NULL,
	[fktransportista] [varchar](15) NULL,
	[tipocambio] [float] NULL,
	[fkpuertosfkpaises] [varchar](3) NULL,
	[fkpuertosid] [varchar](4) NULL,
	[unidadnegocio] [nvarchar](3) NULL,
	[referenciadocumento] [nvarchar](30) NULL,
	[fkbancosmandatos] [varchar](3) NULL,
	[cartacredito] [nvarchar](25) NULL,
	[vencimientocartacredito] [datetime] NULL,
	[contenedores] [int] NULL,
	[fkcuentastesoreria] [varchar](15) NULL,
	[numerodocumentoproveedor] [nvarchar](30) NULL,
	[fechadocumentoproveedor] [datetime] NULL,
	[fkclientesreserva] [varchar](15) NULL,
	[tipoalbaran] [int] NOT NULL,
	[fkmotivosdevolucion] [varchar](3) NULL,
	[nombretransportista] [nvarchar](40) NULL,
	[conductor] [nvarchar](20) NULL,
	[matricula] [nvarchar](12) NULL,
	[bultos] [int] NULL,
	[pesoneto] [float] NULL,
	[pesobruto] [float] NULL,
	[volumen] [float] NULL,
	[envio] [ntext] NULL,
	[fkoperarios] [varchar](15) NULL,
	[fkoperadortransporte] [varchar](15) NULL,
	[fkzonas] [varchar](3) NULL,
	[fkdireccionfacturacion] [int] NULL,
	[brutocomision] [float] NULL,
	[comisiondescontardescuentocomercial] [bit] NULL,
	[comsiondescontardescuentoprontopago] [bit] NULL,
	[cuotadescuentocomercialcomision] [float] NULL,
	[cuotadescuentoprontopagocomision] [float] NULL,
	[basecomision] [float] NULL,
	[comisiondescontarportesincluidosprecio] [bit] NULL,
	[cuotadescuentoportesincluidospreciocomision] [float] NULL,
	[comisiondescontarrecargofinancieroformapago] [bit] NULL,
	[cuotadescuentorecargofinancieroformapagocomision] [float] NULL,
	[netobasecomision] [float] NULL,
	[importecomisionagente] [float] NULL,
	[fksituacioncomision] [varchar](3) NULL,
	[fkaseguradoras] [varchar](15) NULL,
	[suplemento] [nvarchar](20) NULL,
	[fktiposretenciones] [varchar](4) NULL,
	[porcentajeretencion] [float] NULL,
	[fkagentes] [varchar](15) NULL,
	[fkcomerciales] [varchar](15) NULL,
	[comisionagente] [float] NULL,
	[comisioncomercial] [float] NULL,
	[idmandato] [nvarchar](35) NULL,
	[fkusuarioalta] [uniqueidentifier] NOT NULL CONSTRAINT [DF__Facturas__fkusua__2DD1C37F]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechaalta] [datetime] NOT NULL CONSTRAINT [DF__Facturas__fechaa__2EC5E7B8]  DEFAULT (getdate()),
	[fkusuariomodificacion] [uniqueidentifier] NOT NULL CONSTRAINT [DF__Facturas__fkusua__2FBA0BF1]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechamodificacion] [datetime] NOT NULL CONSTRAINT [DF__Facturas__fecham__30AE302A]  DEFAULT (getdate()),
	[fkcarpetas] [uniqueidentifier] NULL,
	[importecomisioncomercial] [float] NULL,
	[criterioiva] [int] NULL,
	[canalcontable] [nvarchar](3) NULL,
	[fkasiento] [int] NULL,
 CONSTRAINT [PK_Facturas_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FacturasCompras]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FacturasCompras](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkejercicio] [int] NOT NULL CONSTRAINT [DF__FacturasC__fkeje__5D4BCC77]  DEFAULT ((1)),
	[fkseries] [varchar](3) NOT NULL,
	[identificadorsegmento] [nvarchar](12) NULL,
	[referencia] [nvarchar](30) NULL,
	[fechadocumento] [datetime] NULL,
	[fkalmacen] [varchar](4) NULL,
	[fkproveedores] [varchar](15) NULL,
	[nombrecliente] [nvarchar](200) NULL,
	[clientedireccion] [nvarchar](100) NULL,
	[clientepoblacion] [nvarchar](100) NULL,
	[clientecp] [nvarchar](10) NULL,
	[clientepais] [nvarchar](50) NULL,
	[clienteprovincia] [nvarchar](50) NULL,
	[clientetelefono] [nvarchar](50) NULL,
	[clientefax] [nvarchar](15) NULL,
	[clienteemail] [nvarchar](200) NULL,
	[clientenif] [nvarchar](15) NULL,
	[fkformaspago] [int] NULL,
	[fkmonedas] [int] NULL,
	[cambioadicional] [float] NULL,
	[cobrado] [bit] NULL,
	[facturarectificativa] [bit] NULL,
	[fkfacturarectificada] [varchar](30) NULL,
	[fkmotivorectificacion] [varchar](3) NULL,
	[importebruto] [float] NULL,
	[importebaseimponible] [float] NULL,
	[importeportes] [float] NULL,
	[porcentajedescuentocomercial] [float] NULL,
	[importedescuentocomercial] [float] NULL,
	[porcentajedescuentoprontopago] [float] NULL,
	[importedescuentoprontopago] [float] NULL,
	[importetotaldoc] [float] NULL,
	[importetotalmonedabase] [float] NULL,
	[notas] [ntext] NULL,
	[fkestados] [varchar](10) NULL,
	[fkobras] [varchar](15) NULL,
	[incoterm] [nvarchar](3) NULL,
	[descripcionincoterm] [nvarchar](30) NULL,
	[peso] [int] NULL,
	[confianza] [int] NULL,
	[costemateriales] [float] NULL,
	[tiempooficinatecnica] [float] NULL,
	[fkregimeniva] [varchar](5) NULL,
	[fktransportista] [varchar](15) NULL,
	[tipocambio] [float] NULL,
	[fkpuertosfkpaises] [varchar](3) NULL,
	[fkpuertosid] [varchar](4) NULL,
	[unidadnegocio] [nvarchar](3) NULL,
	[referenciadocumento] [nvarchar](30) NULL,
	[fkbancosmandatos] [varchar](3) NULL,
	[cartacredito] [nvarchar](25) NULL,
	[vencimientocartacredito] [datetime] NULL,
	[contenedores] [int] NULL,
	[fkcuentastesoreria] [varchar](15) NULL,
	[numerodocumentoproveedor] [nvarchar](30) NULL,
	[fechadocumentoproveedor] [datetime] NULL,
	[fkclientesreserva] [varchar](15) NULL,
	[tipoalbaran] [int] NOT NULL,
	[fkmotivosdevolucion] [varchar](3) NULL,
	[nombretransportista] [nvarchar](40) NULL,
	[conductor] [nvarchar](20) NULL,
	[matricula] [nvarchar](12) NULL,
	[bultos] [int] NULL,
	[pesoneto] [float] NULL,
	[pesobruto] [float] NULL,
	[volumen] [float] NULL,
	[envio] [ntext] NULL,
	[fkoperarios] [varchar](15) NULL,
	[fkoperadortransporte] [varchar](15) NULL,
	[fkzonas] [varchar](3) NULL,
	[fkdireccionfacturacion] [int] NULL,
	[brutocomision] [float] NULL,
	[comisiondescontardescuentocomercial] [bit] NULL,
	[comsiondescontardescuentoprontopago] [bit] NULL,
	[cuotadescuentocomercialcomision] [float] NULL,
	[cuotadescuentoprontopagocomision] [float] NULL,
	[basecomision] [float] NULL,
	[comisiondescontarportesincluidosprecio] [bit] NULL,
	[cuotadescuentoportesincluidospreciocomision] [float] NULL,
	[comisiondescontarrecargofinancieroformapago] [bit] NULL,
	[cuotadescuentorecargofinancieroformapagocomision] [float] NULL,
	[netobasecomision] [float] NULL,
	[importecomisionagente] [float] NULL,
	[fksituacioncomision] [varchar](3) NULL,
	[fkaseguradoras] [varchar](15) NULL,
	[suplemento] [nvarchar](20) NULL,
	[fktiposretenciones] [varchar](4) NULL,
	[porcentajeretencion] [float] NULL,
	[fkagentes] [varchar](15) NULL,
	[fkcomerciales] [varchar](15) NULL,
	[comisionagente] [float] NULL,
	[comisioncomercial] [float] NULL,
	[idmandato] [nvarchar](35) NULL,
	[fkusuarioalta] [uniqueidentifier] NOT NULL CONSTRAINT [DF__FacturasC__fkusu__5E3FF0B0]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechaalta] [datetime] NOT NULL CONSTRAINT [DF__FacturasC__fecha__5F3414E9]  DEFAULT (getdate()),
	[fkusuariomodificacion] [uniqueidentifier] NOT NULL CONSTRAINT [DF__FacturasC__fkusu__60283922]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechamodificacion] [datetime] NOT NULL CONSTRAINT [DF__FacturasC__fecha__611C5D5B]  DEFAULT (getdate()),
	[fkcarpetas] [uniqueidentifier] NULL,
	[importecomisioncomercial] [float] NULL,
	[valorredondeo] [float] NULL,
	[fkguiascontables] [varchar](12) NULL,
	[importefacturaproveedor] [float] NULL,
	[criterioiva] [int] NULL,
	[canalcontable] [nvarchar](3) NULL,
	[fkasiento] [int] NULL,
 CONSTRAINT [PK_Facturascompras_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FacturasComprasLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FacturasComprasLin](
	[empresa] [varchar](4) NOT NULL,
	[fkfacturascompras] [int] NOT NULL DEFAULT ((1)),
	[id] [int] NOT NULL,
	[fkarticulos] [varchar](15) NULL,
	[descripcion] [nvarchar](120) NULL,
	[lote] [nvarchar](12) NULL,
	[tabla] [int] NULL,
	[cantidad] [float] NULL,
	[cantidadpedida] [float] NULL,
	[largo] [float] NULL,
	[ancho] [float] NULL,
	[grueso] [float] NULL,
	[fkunidades] [varchar](2) NULL,
	[metros] [float] NULL,
	[precio] [float] NULL,
	[porcentajedescuento] [float] NULL,
	[importedescuento] [float] NULL,
	[fktiposiva] [varchar](3) NULL,
	[porcentajeiva] [float] NULL,
	[cuotaiva] [float] NULL,
	[porcentajerecargoequivalencia] [float] NULL,
	[cuotarecargoequivalencia] [float] NULL,
	[importe] [float] NULL,
	[importenetolinea] [float] NULL,
	[notas] [ntext] NULL,
	[documentoorigen] [nvarchar](15) NULL,
	[documentodestino] [nvarchar](15) NULL,
	[canal] [nvarchar](3) NULL,
	[precioanterior] [float] NULL,
	[revision] [nvarchar](1) NULL,
	[decimalesmonedas] [int] NULL,
	[decimalesmedidas] [int] NULL,
	[bundle] [nvarchar](2) NULL,
	[tblnum] [int] NULL,
	[contenedor] [nvarchar](12) NULL,
	[sello] [nvarchar](10) NULL,
	[caja] [int] NULL,
	[fkalbaranesfecha] [datetime] NULL,
	[fkalbaranesreferencia] [varchar](30) NULL,
	[fkalbaranesfkcriteriosagrupacion] [varchar](4) NULL,
	[pesoneto] [float] NULL,
	[pesobruto] [float] NULL,
	[seccion] [nvarchar](4) NULL,
	[costeadicionalmaterial] [float] NULL,
	[costeadicionalportes] [float] NULL,
	[costeadicionalotro] [float] NULL,
	[costeacicionalvariable] [float] NULL,
	[orden] [int] NULL,
	[porcentajecomision] [float] NULL,
	[fkalbaranes] [int] NULL,
	[fkalbaranesid] [int] NULL,
 CONSTRAINT [PK_FacturasComprasLin_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkfacturascompras] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FacturasComprasTotales]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FacturasComprasTotales](
	[empresa] [varchar](4) NOT NULL,
	[fkfacturascompras] [int] NOT NULL DEFAULT ((1)),
	[fktiposiva] [varchar](3) NOT NULL,
	[brutototal] [float] NULL,
	[porcentajerecargoequivalencia] [float] NULL,
	[importerecargoequivalencia] [float] NULL,
	[porcentajedescuentoprontopago] [float] NULL,
	[importedescuentoprontopago] [float] NULL,
	[porcentajedescuentocomercial] [float] NULL,
	[importedescuentocomercial] [float] NULL,
	[basetotal] [float] NULL,
	[porcentajeiva] [float] NULL,
	[cuotaiva] [float] NULL,
	[subtotal] [float] NULL,
	[decimalesmonedas] [int] NULL,
	[baseretencion] [float] NULL,
	[porcentajeretencion] [float] NULL,
	[importeretencion] [float] NULL,
 CONSTRAINT [PK_FacturasComprasTotales_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkfacturascompras] ASC,
	[fktiposiva] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FacturasComprasVencimientos]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FacturasComprasVencimientos](
	[empresa] [varchar](4) NOT NULL,
	[fkfacturascompras] [int] NOT NULL DEFAULT ((1)),
	[id] [int] NOT NULL,
	[diasvencimiento] [int] NULL,
	[fechavencimiento] [datetime] NULL,
	[importevencimiento] [float] NULL,
 CONSTRAINT [PK_FacturasComprasVencimientos_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkfacturascompras] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FacturasLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FacturasLin](
	[empresa] [varchar](4) NOT NULL,
	[fkfacturas] [int] NOT NULL CONSTRAINT [DF__FacturasL__fkfac__3296789C]  DEFAULT ((1)),
	[id] [int] NOT NULL,
	[fkarticulos] [varchar](15) NULL,
	[descripcion] [nvarchar](120) NULL,
	[lote] [nvarchar](12) NULL,
	[tabla] [int] NULL,
	[cantidad] [float] NULL,
	[cantidadpedida] [float] NULL,
	[largo] [float] NULL,
	[ancho] [float] NULL,
	[grueso] [float] NULL,
	[fkunidades] [varchar](2) NULL,
	[metros] [float] NULL,
	[precio] [float] NULL,
	[porcentajedescuento] [float] NULL,
	[importedescuento] [float] NULL,
	[fktiposiva] [varchar](3) NULL,
	[porcentajeiva] [float] NULL,
	[cuotaiva] [float] NULL,
	[porcentajerecargoequivalencia] [float] NULL,
	[cuotarecargoequivalencia] [float] NULL,
	[importe] [float] NULL,
	[importenetolinea] [float] NULL,
	[notas] [ntext] NULL,
	[documentoorigen] [nvarchar](15) NULL,
	[documentodestino] [nvarchar](15) NULL,
	[canal] [nvarchar](3) NULL,
	[precioanterior] [float] NULL,
	[revision] [nvarchar](1) NULL,
	[decimalesmonedas] [int] NULL,
	[decimalesmedidas] [int] NULL,
	[bundle] [nvarchar](2) NULL,
	[tblnum] [int] NULL,
	[contenedor] [nvarchar](12) NULL,
	[sello] [nvarchar](10) NULL,
	[caja] [int] NULL,
	[fkalbaranesfecha] [datetime] NULL,
	[fkalbaranesreferencia] [varchar](30) NULL,
	[fkalbaranesfkcriteriosagrupacion] [varchar](4) NULL,
	[pesoneto] [float] NULL,
	[pesobruto] [float] NULL,
	[seccion] [nvarchar](4) NULL,
	[costeadicionalmaterial] [float] NULL,
	[costeadicionalportes] [float] NULL,
	[costeadicionalotro] [float] NULL,
	[costeacicionalvariable] [float] NULL,
	[orden] [int] NULL,
	[porcentajecomision] [float] NULL,
	[fkalbaranes] [int] NULL,
	[fkalbaranesid] [int] NULL,
 CONSTRAINT [PK_FacturasLin_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkfacturas] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FacturasTotales]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FacturasTotales](
	[empresa] [varchar](4) NOT NULL,
	[fkfacturas] [int] NOT NULL CONSTRAINT [DF__FacturasT__fkfac__338A9CD5]  DEFAULT ((1)),
	[fktiposiva] [varchar](3) NOT NULL,
	[brutototal] [float] NULL,
	[porcentajerecargoequivalencia] [float] NULL,
	[importerecargoequivalencia] [float] NULL,
	[porcentajedescuentoprontopago] [float] NULL,
	[importedescuentoprontopago] [float] NULL,
	[porcentajedescuentocomercial] [float] NULL,
	[importedescuentocomercial] [float] NULL,
	[basetotal] [float] NULL,
	[porcentajeiva] [float] NULL,
	[cuotaiva] [float] NULL,
	[subtotal] [float] NULL,
	[decimalesmonedas] [int] NULL,
	[baseretencion] [float] NULL,
	[porcentajeretencion] [float] NULL,
	[importeretencion] [float] NULL,
 CONSTRAINT [PK_FacturasTotales_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkfacturas] ASC,
	[fktiposiva] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FacturasVencimientos]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FacturasVencimientos](
	[empresa] [varchar](4) NOT NULL,
	[fkfacturas] [int] NOT NULL CONSTRAINT [DF__FacturasV__fkfac__347EC10E]  DEFAULT ((1)),
	[id] [int] NOT NULL,
	[diasvencimiento] [int] NULL,
	[fechavencimiento] [datetime] NULL,
	[importevencimiento] [float] NULL,
 CONSTRAINT [PK_FacturasVencimientos_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkfacturas] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Familiasproductos]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Familiasproductos](
	[empresa] [varchar](4) NOT NULL,
	[id] [varchar](2) NOT NULL,
	[descripcion] [nvarchar](40) NULL,
	[descripcion2] [nvarchar](40) NULL,
	[descripcionabreviada] [nvarchar](20) NULL,
	[fkcontador] [varchar](10) NULL,
	[fkguiascontables] [varchar](12) NULL,
	[tipofamilia] [int] NULL,
	[gestionstock] [bit] NULL,
	[articulonegocio] [bit] NULL,
	[fkunidadesmedida] [varchar](2) NULL,
	[editarlargo] [bit] NULL,
	[editarancho] [bit] NULL,
	[editargrueso] [bit] NULL,
	[validarmaterial] [bit] NULL,
	[validarcaracteristica] [bit] NULL,
	[validargrosor] [bit] NULL,
	[validaracabado] [bit] NULL,
	[descripcion1generada] [nvarchar](12) NULL,
	[descripcion2generada] [nvarchar](12) NULL,
	[descripcionabreviadagenerada] [nvarchar](12) NULL,
	[fkgruposiva] [varchar](4) NULL,
	[tipogestionlotes] [int] NULL,
	[stocknegativoautorizado] [bit] NULL,
	[existenciasminimasmetros] [float] NULL,
	[existenciasmaximasmetros] [float] NULL,
	[existenciasminimasunidades] [float] NULL,
	[existenciasmaximasunidades] [float] NULL,
	[web] [bit] NULL,
	[gestionarcaducidad] [bit] NULL,
	[lotefraccionable] [bit] NOT NULL DEFAULT ((0)),
	[categoria] [int] NOT NULL DEFAULT ((0)),
	[minlargo] [float] NULL,
	[maxlargo] [float] NULL,
	[minancho] [float] NULL,
	[maxancho] [float] NULL,
	[mingrueso] [float] NULL,
	[maxgrueso] [float] NULL,
	[validardimensiones] [bit] NULL,
 CONSTRAINT [PK_Familiasproductos] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ficheros]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ficheros](
	[empresa] [varchar](4) NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[nombre] [nvarchar](200) NULL,
	[descripcion] [ntext] NULL,
	[ruta] [nvarchar](max) NULL,
	[tipo] [nvarchar](10) NULL,
	[fkcarpetas] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Ficheros] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FormasPago]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FormasPago](
	[id] [int] NOT NULL,
	[nombre] [nvarchar](100) NULL,
	[nombre2] [nvarchar](100) NULL,
	[fkModosPago] [varchar](3) NULL,
	[imprimirvencimientos] [bit] NULL,
	[recargofinanciero] [float] NULL,
	[efectivo] [bit] NULL,
	[remesable] [bit] NULL,
	[mandato] [bit] NULL,
	[excluirfestivos] [bit] NULL,
	[bloqueada] [bit] NULL,
	[fkMotivosbloqueo] [varchar](3) NULL,
	[fechamodificacionbloqueo] [datetime] NULL,
	[fkUsuariobloqueo] [uniqueidentifier] NULL,
	[fkgruposformaspago] [varchar](3) NULL,
 CONSTRAINT [PK_FormasPago] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FormasPagoLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FormasPagoLin](
	[fkFormasPago] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[diasvencimiento] [smallint] NULL,
	[porcentajerecargo] [float] NULL,
 CONSTRAINT [PK_FormasPagoLin] PRIMARY KEY CLUSTERED 
(
	[fkFormasPago] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Grosores]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Grosores](
	[id] [varchar](2) NOT NULL,
	[grosor] [float] NULL,
	[descripcion] [nvarchar](40) NULL,
	[descripcion2] [nvarchar](40) NULL,
	[descripcionabreviada] [nvarchar](20) NULL,
	[coficientecortabloques] [float] NULL,
	[coeficientetelares] [float] NULL,
 CONSTRAINT [PK_Grosores] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GruposIva]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GruposIva](
	[empresa] [varchar](4) NOT NULL,
	[id] [varchar](4) NOT NULL,
	[descripcion] [nvarchar](50) NULL,
 CONSTRAINT [PK_GruposIva_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GruposIvaLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GruposIvaLin](
	[empresa] [varchar](4) NOT NULL,
	[fkgruposiva] [varchar](4) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[desde] [datetime] NOT NULL,
	[fktiposivasinrecargo] [varchar](3) NULL,
	[fktiposivaconrecargo] [varchar](3) NULL,
	[fktiposivaexentoiva] [varchar](3) NULL,
 CONSTRAINT [PK_gruposiva] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkgruposiva] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Guiascontables]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Guiascontables](
	[empresa] [varchar](4) NOT NULL,
	[id] [varchar](12) NOT NULL,
	[descripcion] [nvarchar](40) NULL,
	[fkcuentascompras] [varchar](15) NULL,
	[fkcuentasventas] [varchar](15) NULL,
	[fkcuentasdevolucioncompras] [varchar](15) NULL,
	[fkcuentasdevolucionventas] [varchar](15) NULL,
	[defecto] [bit] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_Guiascontables] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GuiascontablesLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GuiascontablesLin](
	[empresa] [varchar](4) NOT NULL,
	[fkguiascontables] [varchar](12) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkregimeniva] [varchar](5) NULL,
	[fkcuentascompras] [varchar](15) NULL,
	[fkcuentasventas] [varchar](15) NULL,
	[fkcuentasdevolucioncompras] [varchar](15) NULL,
	[fkcuentasdevolucionventas] [varchar](15) NULL,
 CONSTRAINT [PK_GuiascontablesLin] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkguiascontables] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Incidencias]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Incidencias](
	[empresa] [varchar](4) NOT NULL,
	[id] [varchar](3) NOT NULL,
	[descripcion] [nvarchar](50) NULL,
	[tipomaterial] [int] NOT NULL,
	[documento] [int] NULL,
	[fkgrupo] [varchar](3) NULL,
 CONSTRAINT [PK_Incidencias] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[IncidenciasCRM]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IncidenciasCRM](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] NOT NULL,
	[fkseries] [varchar](3) NOT NULL,
	[identificadorsegmento] [nvarchar](12) NULL,
	[referencia] [varchar](15) NULL,
	[fechadocumento] [datetime] NULL,
	[asunto] [varchar](100) NULL,
	[fechaultimoseguimiento] [datetime] NULL,
	[fechaproximoseguimiento] [datetime] NULL,
	[fkempresa] [varchar](15) NULL,
	[fkcontacto] [varchar](15) NULL,
	[fkorigen] [varchar](3) NULL,
	[fketapa] [varchar](10) NULL,
	[prioridad] [int] NULL,
	[fkmargen] [varchar](3) NULL,
	[probabilidadcierre] [float] NULL,
	[fkoperario] [varchar](15) NULL,
	[fkcomercial] [varchar](15) NULL,
	[fkagente] [varchar](15) NULL,
	[notas] [varchar](max) NULL,
	[coste] [int] NULL,
	[cerrado] [bit] NULL,
	[fechacierre] [datetime] NULL,
	[fkreaccion] [varchar](3) NULL,
 CONSTRAINT [PK_IncidenciasCRM] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Inventarios]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Inventarios](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fechadocumento] [datetime] NOT NULL,
	[fkseries] [varchar](3) NOT NULL,
	[fkejercicio] [int] NOT NULL,
	[identificadorsegmento] [varchar](12) NULL,
	[fkalmacenes] [varchar](4) NOT NULL,
	[descripcion] [varchar](100) NULL,
	[fkalmaceneszonas] [int] NULL,
	[fkarticulosdesde] [varchar](15) NULL,
	[fkarticuloshasta] [varchar](15) NULL,
	[fkfamiliamaterial] [varchar](3) NULL,
	[fkfamiliaproductodesde] [varchar](2) NULL,
	[fkfamiliaproductohasta] [varchar](2) NULL,
	[fkmaterialdesde] [varchar](3) NULL,
	[fkmaterialhasta] [varchar](3) NULL,
	[fkgrosordesde] [varchar](2) NULL,
	[fkgrosorhasta] [varchar](2) NULL,
	[fkacabadodesde] [varchar](2) NULL,
	[fkacabadohasta] [varchar](2) NULL,
	[integridadreferencial] [uniqueidentifier] NULL,
	[fkcaracteristicadesde] [varchar](2) NULL,
	[fkcaracteristicahasta] [varchar](2) NULL,
	[referencia] [varchar](15) NOT NULL,
	[tipoalmacenlote] [int] NULL,
 CONSTRAINT [PK_Inventarios] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InventariosLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InventariosLin](
	[empresa] [varchar](4) NOT NULL,
	[fkinventarios] [int] NOT NULL,
	[id] [int] NOT NULL,
	[fkarticulos] [varchar](15) NOT NULL,
	[descripcion] [varchar](200) NULL,
	[lote] [varchar](15) NOT NULL,
	[loteid] [varchar](5) NOT NULL,
	[referenciaproveedor] [nvarchar](50) NULL,
	[tag] [nvarchar](50) NULL,
	[fkunidadesmedida] [varchar](2) NOT NULL,
	[cantidad] [float] NOT NULL,
	[largo] [float] NOT NULL,
	[ancho] [float] NOT NULL,
	[grueso] [float] NOT NULL,
	[metros] [float] NULL,
	[fkcalificacioncomercial] [varchar](3) NULL,
	[fktipograno] [varchar](3) NULL,
	[fktonomaterial] [varchar](3) NULL,
	[pesonetolote] [float] NULL,
	[fkincidenciasmaterial] [varchar](3) NULL,
	[fkvariedades] [varchar](20) NULL,
	[estado] [int] NOT NULL,
	[decimalesmedidas] [int] NULL,
 CONSTRAINT [PK_InventariosLin] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkinventarios] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Kit]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Kit](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkseries] [varchar](3) NOT NULL,
	[identificadorsegmento] [varchar](12) NOT NULL,
	[referencia] [varchar](30) NULL,
	[fechadocumento] [datetime] NOT NULL,
	[fkoperarios] [varchar](15) NULL,
	[fkalmacen] [varchar](4) NOT NULL,
	[fkzonalamacen] [int] NULL,
	[notas] [ntext] NULL,
	[descripcion] [nvarchar](200) NULL,
	[estado] [int] NOT NULL CONSTRAINT [DF__Kit__estado__0D2FE9C3]  DEFAULT ((0)),
	[pesoneto] [float] NULL,
	[pesobruto] [float] NULL,
 CONSTRAINT [PK_Kit] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KitLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KitLin](
	[empresa] [varchar](4) NOT NULL,
	[fkkit] [int] NOT NULL,
	[id] [int] NOT NULL,
	[lote] [varchar](15) NOT NULL,
	[loteid] [varchar](15) NOT NULL,
	[fkarticulos] [varchar](15) NOT NULL,
	[descripcion] [varchar](200) NOT NULL,
	[coste] [float] NOT NULL,
	[largo] [float] NOT NULL,
	[ancho] [float] NOT NULL,
	[grueso] [float] NOT NULL,
	[metros] [float] NOT NULL,
	[fkunidades] [varchar](2) NOT NULL,
	[decimalesunidades] [int] NOT NULL,
	[decimalesprecio] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[fkalmacenes] [varchar](4) NULL,
 CONSTRAINT [PK_KitLin] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkkit] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Maes]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Maes](
	[empresa] [varchar](4) NOT NULL,
	[fkejercicio] [int] NOT NULL DEFAULT ((1)),
	[fkcuentas] [varchar](15) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[debe] [money] NULL DEFAULT ((0)),
	[haber] [money] NULL DEFAULT ((0)),
	[saldo] [money] NULL DEFAULT ((0)),
 CONSTRAINT [PK_Maes] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkejercicio] ASC,
	[fkcuentas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Materiales]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Materiales](
	[empresa] [varchar](4) NOT NULL,
	[id] [varchar](3) NOT NULL,
	[descripcion] [nvarchar](40) NULL,
	[descripcion2] [nvarchar](40) NULL,
	[descripcionabreviada] [nvarchar](40) NULL,
	[fkfamiliamateriales] [varchar](3) NULL,
	[fkgruposmateriales] [varchar](3) NULL,
	[dureza] [nvarchar](1) NULL,
	[fkcarpetas] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Materiales] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MaterialesLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MaterialesLin](
	[empresa] [varchar](4) NOT NULL,
	[fkmateriales] [varchar](3) NOT NULL,
	[codigovariedad] [varchar](20) NOT NULL,
	[descripcion] [nvarchar](30) NULL,
	[descripcion2] [nvarchar](30) NULL,
 CONSTRAINT [PK_MaterialesLin_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkmateriales] ASC,
	[codigovariedad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Monedas]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Monedas](
	[id] [int] NOT NULL,
	[descripcion] [nvarchar](50) NULL,
	[abreviatura] [nvarchar](3) NULL,
	[decimales] [int] NULL,
	[cambiomonedabase] [float] NULL,
	[cambiomonedaadicional] [float] NULL,
	[fechamodificacion] [datetime] NULL,
	[fkUsuarios] [uniqueidentifier] NULL,
	[fkUsuariosnombre] [varchar](20) NULL,
	[activado] [bit] NULL,
 CONSTRAINT [PK_Monedas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MonedasLog]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MonedasLog](
	[fkMonedas] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cambiomonedabase] [float] NULL,
	[cambiomonedaadicional] [float] NULL,
	[fechamodificacion] [datetime] NULL,
	[fkUsuarios] [uniqueidentifier] NULL,
	[fkUsuariosnombre] [varchar](20) NULL,
 CONSTRAINT [PK_MonedasLog] PRIMARY KEY CLUSTERED 
(
	[fkMonedas] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Movimientosstock]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Movimientosstock](
	[empresa] [varchar](4) NOT NULL,
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[fkalmacenes] [varchar](4) NOT NULL,
	[fkarticulos] [varchar](15) NOT NULL,
	[referenciaproveedor] [nvarchar](50) NULL,
	[lote] [nvarchar](15) NULL,
	[loteid] [nvarchar](5) NULL,
	[tag] [nvarchar](50) NULL,
	[fkunidadesmedida] [varchar](2) NOT NULL,
	[cantidad] [float] NOT NULL,
	[largo] [float] NOT NULL,
	[ancho] [float] NOT NULL,
	[grueso] [float] NOT NULL,
	[documentomovimiento] [xml] NOT NULL,
	[integridadreferencialflag] [uniqueidentifier] NOT NULL,
	[fkcontadorlote] [varchar](12) NULL,
	[fkusuarios] [uniqueidentifier] NULL,
	[tipooperacion] [int] NULL,
	[fkalmaceneszona] [int] NULL,
	[fkcalificacioncomercial] [varchar](3) NULL,
	[fktipograno] [varchar](3) NULL,
	[fktonomaterial] [varchar](3) NULL,
	[fkincidenciasmaterial] [varchar](3) NULL,
	[fkvariedades] [varchar](20) NULL,
	[costeadicionalmaterial] [float] NULL,
	[costeadicionalportes] [float] NULL,
	[costeadicionalotro] [float] NULL,
	[costeacicionalvariable] [float] NULL,
	[categoriamovimiento] [int] NOT NULL DEFAULT ((1)),
	[tipoalmacenlote] [int] NULL,
	[Tipomovimiento] [int] NULL,
 CONSTRAINT [PK_movimientosstock] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Movs]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Movs](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkejercicio] [int] NOT NULL DEFAULT ((1)),
	[fkseriescontables] [varchar](3) NOT NULL,
	[identificadorsegmento] [varchar](12) NOT NULL,
	[referencialibre] [varchar](15) NULL,
	[integridadreferencial] [uniqueidentifier] NULL,
	[referencia] [varchar](30) NULL,
	[fecha] [datetime] NULL,
	[codigodescripcionasiento] [varchar](3) NULL,
	[tipoasiento] [varchar](2) NOT NULL,
	[descripcionasiento] [varchar](100) NOT NULL,
	[vinculo] [varchar](3) NULL,
	[canalcontable] [varchar](3) NULL,
	[traza] [varchar](100) NULL,
	[fkusuarioalta] [uniqueidentifier] NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechaalta] [datetime] NOT NULL DEFAULT (getdate()),
	[fkusuariomodificacion] [uniqueidentifier] NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechamodificacion] [datetime] NOT NULL DEFAULT (getdate()),
	[fkmonedas] [int] NOT NULL,
	[tipocambio] [float] NULL,
	[bloqueado] [bit] NULL,
	[debe] [money] NOT NULL CONSTRAINT [DF_Movs_debe]  DEFAULT ((0)),
	[haber] [money] NOT NULL CONSTRAINT [DF_Movs_haber]  DEFAULT ((0)),
	[saldo] [money] NOT NULL CONSTRAINT [DF_Movs_saldo]  DEFAULT ((0)),
 CONSTRAINT [PK_Movs] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MovsLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MovsLin](
	[empresa] [varchar](4) NOT NULL,
	[fkmovs] [int] NOT NULL DEFAULT ((1)),
	[id] [int] NOT NULL,
	[flagidentifier] [uniqueidentifier] NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[orden] [int] NULL,
	[esdebe] [smallint] NOT NULL,
	[fkcuentas] [varchar](15) NULL,
	[fkseccionesanaliticas] [varchar](4) NULL,
	[importe] [money] NOT NULL,
	[importemonedadocumento] [money] NULL,
	[codigocomentario] [varchar](3) NULL,
	[comentario] [nvarchar](100) NULL,
	[conciliado] [bit] NULL DEFAULT ((0)),
 CONSTRAINT [PK_MovsLin] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkmovs] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Municipios]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Municipios](
	[codigopais] [varchar](3) NOT NULL,
	[codigoprovincia] [varchar](2) NOT NULL,
	[id] [varchar](3) NOT NULL,
	[nombre] [nvarchar](100) NULL,
 CONSTRAINT [PK_Municipios] PRIMARY KEY CLUSTERED 
(
	[codigopais] ASC,
	[codigoprovincia] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Obras]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Obras](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] NOT NULL,
	[fkclientes] [varchar](15) NULL,
	[nombreobra] [nvarchar](50) NULL,
	[fkdirecciones] [int] NULL,
	[fktiposobra] [varchar](3) NULL,
	[fkagentes] [varchar](15) NULL,
	[fkcomerciales] [varchar](15) NULL,
	[fkregimeniva] [varchar](5) NULL,
	[retencion] [float] NULL,
	[fechainicio] [datetime] NULL,
	[fechafin] [datetime] NULL,
	[fecharevision] [datetime] NULL,
	[certificado] [nvarchar](10) NULL,
	[notas] [ntext] NULL,
	[email] [nvarchar](200) NULL,
	[finalizada] [bit] NULL,
 CONSTRAINT [PK_Obras] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Operarios]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Operarios](
	[empresa] [varchar](4) NOT NULL,
	[fkcuentas] [varchar](15) NOT NULL,
	[fechanacimiento] [datetime] NULL,
	[fkestadocivil] [varchar](3) NULL,
	[numerohijos] [int] NULL,
	[fechaingreso] [datetime] NULL,
	[fkcargo] [varchar](3) NULL,
	[numeroseguridadsocial] [nvarchar](20) NULL,
	[fkcontratoactual] [varchar](3) NULL,
	[fechaalta] [datetime] NULL,
	[vencimientocontrato] [datetime] NULL,
	[ultimafechabaja] [datetime] NULL,
	[ultimafechaalta] [datetime] NULL,
	[tallacamisa] [nvarchar](4) NULL,
	[tallapantalon] [nvarchar](4) NULL,
	[tallacalzado] [nvarchar](4) NULL,
	[notas] [ntext] NULL,
	[fkcuentatesoreria] [varchar](15) NULL,
 CONSTRAINT [PK_Operarios] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkcuentas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Oportunidades]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Oportunidades](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] NOT NULL,
	[fkseries] [varchar](3) NOT NULL,
	[identificadorsegmento] [nvarchar](12) NULL,
	[referencia] [varchar](15) NULL,
	[fechadocumento] [datetime] NULL,
	[asunto] [varchar](100) NULL,
	[fechaultimoseguimiento] [datetime] NULL,
	[fechaproximoseguimiento] [datetime] NULL,
	[fkempresa] [varchar](15) NULL,
	[fkcontacto] [varchar](15) NULL,
	[fkorigen] [varchar](3) NULL,
	[fketapa] [varchar](10) NULL,
	[prioridad] [int] NULL,
	[fkmargen] [varchar](3) NULL,
	[probabilidadcierre] [float] NULL,
	[fkoperario] [varchar](15) NULL,
	[fkcomercial] [varchar](15) NULL,
	[fkagente] [varchar](15) NULL,
	[notas] [varchar](max) NULL,
	[fechacierre] [datetime] NULL,
	[coste] [int] NULL,
	[cerrado] [bit] NULL,
	[fkreaccion] [varchar](3) NULL,
 CONSTRAINT [PK_Oportunidades] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Pedidos]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pedidos](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkejercicio] [int] NOT NULL CONSTRAINT [DF__Pedidos__fkejerc__24485945]  DEFAULT ((1)),
	[fkseries] [varchar](3) NOT NULL,
	[identificadorsegmento] [nvarchar](12) NULL,
	[referencia] [nvarchar](30) NULL,
	[fechadocumento] [datetime] NULL,
	[fechavalidez] [datetime] NULL,
	[fechaentrega] [datetime] NULL,
	[fecharevision] [datetime] NULL,
	[fkalmacen] [int] NULL,
	[fkclientes] [varchar](15) NULL,
	[nombrecliente] [nvarchar](200) NULL,
	[clientedireccion] [nvarchar](100) NULL,
	[clientepoblacion] [nvarchar](100) NULL,
	[clientecp] [nvarchar](10) NULL,
	[clientepais] [nvarchar](50) NULL,
	[clienteprovincia] [nvarchar](50) NULL,
	[clientetelefono] [nvarchar](50) NULL,
	[clientefax] [nvarchar](15) NULL,
	[clienteemail] [nvarchar](200) NULL,
	[clientenif] [nvarchar](15) NULL,
	[fkformaspago] [int] NULL,
	[fkagentes] [varchar](15) NULL,
	[fkcomerciales] [varchar](15) NULL,
	[comisionagente] [float] NULL,
	[comisioncomercial] [float] NULL,
	[fkmonedas] [int] NULL,
	[cambioadicional] [float] NULL,
	[importebruto] [float] NULL,
	[importebaseimponible] [float] NULL,
	[importeportes] [float] NULL,
	[porcentajedescuentocomercial] [float] NULL,
	[importedescuentocomercial] [float] NULL,
	[porcentajedescuentoprontopago] [float] NULL,
	[importedescuentoprontopago] [float] NULL,
	[importetotaldoc] [float] NULL,
	[importetotalmonedabase] [float] NULL,
	[notas] [ntext] NULL,
	[fkestados] [varchar](10) NULL,
	[fkobras] [varchar](15) NULL,
	[incoterm] [nvarchar](3) NULL,
	[descripcionincoterm] [nvarchar](30) NULL,
	[peso] [int] NULL,
	[confianza] [int] NULL,
	[costemateriales] [float] NULL,
	[tiempooficinatecnica] [float] NULL,
	[fkregimeniva] [varchar](5) NULL,
	[fktransportista] [varchar](15) NULL,
	[tipocambio] [float] NULL,
	[fkpuertosfkpaises] [varchar](3) NULL,
	[fkpuertosid] [varchar](4) NULL,
	[unidadnegocio] [nvarchar](3) NULL,
	[referenciadocumento] [nvarchar](30) NULL,
	[fkbancosmandatos] [varchar](3) NULL,
	[cartacredito] [nvarchar](25) NULL,
	[vencimientocartacredito] [datetime] NULL,
	[contenedores] [int] NULL,
	[fkcuentastesoreria] [varchar](15) NULL,
	[fkusuarioalta] [uniqueidentifier] NOT NULL CONSTRAINT [DF__Pedidos__fkusuar__2077C861]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechaalta] [datetime] NOT NULL CONSTRAINT [DF__Pedidos__fechaal__216BEC9A]  DEFAULT (getdate()),
	[fkusuariomodificacion] [uniqueidentifier] NOT NULL CONSTRAINT [DF__Pedidos__fkusuar__226010D3]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechamodificacion] [datetime] NOT NULL CONSTRAINT [DF__Pedidos__fechamo__2354350C]  DEFAULT (getdate()),
	[fkcarpetas] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Pedidos] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PedidosCompras]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PedidosCompras](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkejercicio] [int] NOT NULL CONSTRAINT [DF__PedidosCompras__fkejerc__24485945]  DEFAULT ((1)),
	[fkseries] [varchar](3) NOT NULL,
	[identificadorsegmento] [nvarchar](12) NULL,
	[referencia] [nvarchar](30) NULL,
	[fechadocumento] [datetime] NULL,
	[fechavalidez] [datetime] NULL,
	[fechaentrega] [datetime] NULL,
	[fecharevision] [datetime] NULL,
	[fkalmacen] [int] NULL,
	[fkproveedores] [varchar](15) NULL,
	[nombrecliente] [nvarchar](200) NULL,
	[clientedireccion] [nvarchar](100) NULL,
	[clientepoblacion] [nvarchar](100) NULL,
	[clientecp] [nvarchar](10) NULL,
	[clientepais] [nvarchar](50) NULL,
	[clienteprovincia] [nvarchar](50) NULL,
	[clientetelefono] [nvarchar](50) NULL,
	[clientefax] [nvarchar](15) NULL,
	[clienteemail] [nvarchar](200) NULL,
	[clientenif] [nvarchar](15) NULL,
	[fkformaspago] [int] NULL,
	[fkagentes] [varchar](15) NULL,
	[fkcomerciales] [varchar](15) NULL,
	[comisionagente] [float] NULL,
	[comisioncomercial] [float] NULL,
	[fkmonedas] [int] NULL,
	[cambioadicional] [float] NULL,
	[importebruto] [float] NULL,
	[importebaseimponible] [float] NULL,
	[importeportes] [float] NULL,
	[porcentajedescuentocomercial] [float] NULL,
	[importedescuentocomercial] [float] NULL,
	[porcentajedescuentoprontopago] [float] NULL,
	[importedescuentoprontopago] [float] NULL,
	[importetotaldoc] [float] NULL,
	[importetotalmonedabase] [float] NULL,
	[notas] [ntext] NULL,
	[fkestados] [varchar](10) NULL,
	[fkobras] [varchar](15) NULL,
	[incoterm] [nvarchar](3) NULL,
	[descripcionincoterm] [nvarchar](30) NULL,
	[peso] [int] NULL,
	[confianza] [int] NULL,
	[costemateriales] [float] NULL,
	[tiempooficinatecnica] [float] NULL,
	[fkregimeniva] [varchar](5) NULL,
	[fktransportista] [varchar](15) NULL,
	[tipocambio] [float] NULL,
	[fkpuertosfkpaises] [varchar](3) NULL,
	[fkpuertosid] [varchar](4) NULL,
	[unidadnegocio] [nvarchar](3) NULL,
	[referenciadocumento] [nvarchar](30) NULL,
	[fkbancosmandatos] [varchar](3) NULL,
	[cartacredito] [nvarchar](25) NULL,
	[vencimientocartacredito] [datetime] NULL,
	[contenedores] [int] NULL,
	[fkcuentastesoreria] [varchar](15) NULL,
	[fkusuarioalta] [uniqueidentifier] NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechaalta] [datetime] NOT NULL DEFAULT (getdate()),
	[fkusuariomodificacion] [uniqueidentifier] NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechamodificacion] [datetime] NOT NULL DEFAULT (getdate()),
	[fkcarpetas] [uniqueidentifier] NULL,
	[numerodocumentoproveedor] [nvarchar](30) NULL,
	[fechadocumentoproveedor] [datetime] NULL,
 CONSTRAINT [PK_PedidosCompras] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PedidosComprasLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PedidosComprasLin](
	[empresa] [varchar](4) NOT NULL,
	[fkpedidoscompras] [int] NOT NULL CONSTRAINT [DF__PedidosComprasLi__fkped__253C7D7E]  DEFAULT ((1)),
	[id] [int] NOT NULL,
	[fkarticulos] [varchar](15) NULL,
	[descripcion] [varchar](120) NULL,
	[lote] [varchar](12) NULL,
	[tabla] [int] NULL,
	[cantidad] [float] NULL,
	[cantidadpedida] [float] NULL,
	[largo] [float] NULL,
	[ancho] [float] NULL,
	[grueso] [float] NULL,
	[fkunidades] [varchar](2) NULL,
	[metros] [float] NULL,
	[precio] [float] NULL,
	[porcentajedescuento] [float] NULL,
	[importedescuento] [float] NULL,
	[fktiposiva] [varchar](3) NULL,
	[porcentajeiva] [float] NULL,
	[cuotaiva] [float] NULL,
	[porcentajerecargoequivalencia] [float] NULL,
	[cuotarecargoequivalencia] [float] NULL,
	[importe] [float] NULL,
	[notas] [ntext] NULL,
	[documentoorigen] [varchar](15) NULL,
	[documentodestino] [varchar](15) NULL,
	[canal] [varchar](3) NULL,
	[precioanterior] [float] NULL,
	[revision] [varchar](1) NULL,
	[decimalesmonedas] [int] NULL,
	[decimalesmedidas] [int] NULL,
	[labor1l1] [int] NULL,
	[labor2l1] [varchar](3) NULL,
	[labor3l1] [varchar](3) NULL,
	[labor4l1] [varchar](3) NULL,
	[labor1l2] [int] NULL,
	[labor2l2] [varchar](3) NULL,
	[labor3l2] [varchar](3) NULL,
	[labor4l2] [varchar](3) NULL,
	[labor1l3] [int] NULL,
	[labor2l3] [varchar](3) NULL,
	[labor3l3] [varchar](3) NULL,
	[labor4l3] [varchar](3) NULL,
	[labor1l4] [int] NULL,
	[labor2l4] [varchar](3) NULL,
	[labor3l4] [varchar](3) NULL,
	[labor4l4] [varchar](3) NULL,
	[bundle] [varchar](2) NULL,
	[tblnum] [int] NULL,
	[caja] [int] NULL,
	[fkpresupuestos] [int] NULL,
	[fkpresupuestosid] [int] NULL,
	[fkpresupuestosreferencia] [varchar](30) NULL,
	[orden] [int] NULL,
	[fkpedidosventas] [int] NULL,
	[fkpedidosventasreferencia] [nvarchar](30) NULL,
 CONSTRAINT [PK_PedidosComprasLin_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkpedidoscompras] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PedidosComprasTotales]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PedidosComprasTotales](
	[empresa] [varchar](4) NOT NULL,
	[fkpedidoscompras] [int] NOT NULL CONSTRAINT [DF__PedidosComprasTo__fkped__2630A1B7]  DEFAULT ((1)),
	[fktiposiva] [varchar](3) NOT NULL,
	[brutototal] [float] NULL,
	[porcentajerecargoequivalencia] [float] NULL,
	[importerecargoequivalencia] [float] NULL,
	[porcentajedescuentoprontopago] [float] NULL,
	[importedescuentoprontopago] [float] NULL,
	[porcentajedescuentocomercial] [float] NULL,
	[importedescuentocomercial] [float] NULL,
	[basetotal] [float] NULL,
	[porcentajeiva] [float] NULL,
	[cuotaiva] [float] NULL,
	[subtotal] [float] NULL,
	[decimalesmonedas] [int] NULL,
 CONSTRAINT [PK_PedidosComprasTotales_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkpedidoscompras] ASC,
	[fktiposiva] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PedidosCostesFabricacion]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PedidosCostesFabricacion](
	[empresa] [varchar](4) NOT NULL,
	[fkpedido] [int] NOT NULL,
	[id] [int] NOT NULL,
	[fecha] [datetime] NULL,
	[fkoperario] [varchar](15) NULL,
	[fktarea] [varchar](5) NULL,
	[descripcion] [varchar](100) NULL,
	[cantidad] [float] NULL,
	[precio] [float] NULL,
	[total] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkpedido] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PedidosLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PedidosLin](
	[empresa] [varchar](4) NOT NULL,
	[fkpedidos] [int] NOT NULL CONSTRAINT [DF__PedidosLi__fkped__253C7D7E]  DEFAULT ((1)),
	[id] [int] NOT NULL,
	[fkarticulos] [varchar](15) NULL,
	[descripcion] [nvarchar](120) NULL,
	[lote] [nvarchar](12) NULL,
	[tabla] [int] NULL,
	[cantidad] [float] NULL,
	[cantidadpedida] [float] NULL,
	[largo] [float] NULL,
	[ancho] [float] NULL,
	[grueso] [float] NULL,
	[fkunidades] [varchar](2) NULL,
	[metros] [float] NULL,
	[precio] [float] NULL,
	[porcentajedescuento] [float] NULL,
	[importedescuento] [float] NULL,
	[fktiposiva] [varchar](3) NULL,
	[porcentajeiva] [float] NULL,
	[cuotaiva] [float] NULL,
	[porcentajerecargoequivalencia] [float] NULL,
	[cuotarecargoequivalencia] [float] NULL,
	[importe] [float] NULL,
	[notas] [ntext] NULL,
	[documentoorigen] [nvarchar](15) NULL,
	[documentodestino] [nvarchar](15) NULL,
	[canal] [nvarchar](3) NULL,
	[precioanterior] [float] NULL,
	[revision] [nvarchar](1) NULL,
	[decimalesmonedas] [int] NULL,
	[decimalesmedidas] [int] NULL,
	[labor1l1] [int] NULL,
	[labor2l1] [nvarchar](3) NULL,
	[labor3l1] [nvarchar](3) NULL,
	[labor4l1] [nvarchar](3) NULL,
	[labor1l2] [int] NULL,
	[labor2l2] [nvarchar](3) NULL,
	[labor3l2] [nvarchar](3) NULL,
	[labor4l2] [nvarchar](3) NULL,
	[labor1l3] [int] NULL,
	[labor2l3] [nvarchar](3) NULL,
	[labor3l3] [nvarchar](3) NULL,
	[labor4l3] [nvarchar](3) NULL,
	[labor1l4] [int] NULL,
	[labor2l4] [nvarchar](3) NULL,
	[labor3l4] [nvarchar](3) NULL,
	[labor4l4] [nvarchar](3) NULL,
	[bundle] [nvarchar](2) NULL,
	[tblnum] [int] NULL,
	[caja] [int] NULL,
	[fkpresupuestos] [int] NULL,
	[fkpresupuestosid] [int] NULL,
	[fkpresupuestosreferencia] [varchar](30) NULL,
	[orden] [int] NULL,
 CONSTRAINT [PK_PedidosLin_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkpedidos] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PedidosTotales]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PedidosTotales](
	[empresa] [varchar](4) NOT NULL,
	[fkpedidos] [int] NOT NULL CONSTRAINT [DF__PedidosTo__fkped__2630A1B7]  DEFAULT ((1)),
	[fktiposiva] [varchar](3) NOT NULL,
	[brutototal] [float] NULL,
	[porcentajerecargoequivalencia] [float] NULL,
	[importerecargoequivalencia] [float] NULL,
	[porcentajedescuentoprontopago] [float] NULL,
	[importedescuentoprontopago] [float] NULL,
	[porcentajedescuentocomercial] [float] NULL,
	[importedescuentocomercial] [float] NULL,
	[basetotal] [float] NULL,
	[porcentajeiva] [float] NULL,
	[cuotaiva] [float] NULL,
	[subtotal] [float] NULL,
	[decimalesmonedas] [int] NULL,
 CONSTRAINT [PK_PedidosTotales_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkpedidos] ASC,
	[fktiposiva] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PeticionesAsincronas]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PeticionesAsincronas](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] NOT NULL,
	[usuario] [varchar](15) NULL,
	[fecha] [datetime] NULL,
	[estado] [int] NULL,
	[tipo] [int] NULL,
	[configuracion] [varchar](500) NULL,
	[resultado] [varchar](max) NULL,
 CONSTRAINT [PK_PeticionesAsincronas] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Planesgenerales]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Planesgenerales](
	[id] [uniqueidentifier] NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[fichero] [nvarchar](300) NULL,
	[defecto] [bit] NULL,
 CONSTRAINT [PK_Plangeneral] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PreferenciasUsuario]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PreferenciasUsuario](
	[fkUsuario] [uniqueidentifier] NOT NULL,
	[tipo] [int] NOT NULL,
	[id] [varchar](100) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[xml] [xml] NULL,
 CONSTRAINT [PK_PreferenciasUsuario] PRIMARY KEY CLUSTERED 
(
	[fkUsuario] ASC,
	[tipo] ASC,
	[id] ASC,
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Presupuestos]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Presupuestos](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkejercicio] [int] NOT NULL CONSTRAINT [DF__Presupues__ejerc__0F4D3C5F]  DEFAULT ((1)),
	[fkseries] [varchar](3) NOT NULL,
	[identificadorsegmento] [nvarchar](12) NULL,
	[referencia] [nvarchar](30) NULL,
	[fechadocumento] [datetime] NULL,
	[fechavalidez] [datetime] NULL,
	[fechaentrega] [datetime] NULL,
	[fecharevision] [datetime] NULL,
	[fkalmacen] [int] NULL,
	[fkclientes] [varchar](15) NULL,
	[nombrecliente] [nvarchar](200) NULL,
	[clientedireccion] [nvarchar](100) NULL,
	[clientepoblacion] [nvarchar](100) NULL,
	[clientecp] [nvarchar](10) NULL,
	[clientepais] [nvarchar](50) NULL,
	[clienteprovincia] [nvarchar](50) NULL,
	[clientetelefono] [nvarchar](50) NULL,
	[clientefax] [nvarchar](15) NULL,
	[clienteemail] [nvarchar](200) NULL,
	[clientenif] [nvarchar](15) NULL,
	[fkformaspago] [int] NULL,
	[fkagentes] [varchar](15) NULL,
	[fkcomerciales] [varchar](15) NULL,
	[comisionagente] [float] NULL,
	[comisioncomercial] [float] NULL,
	[fkmonedas] [int] NULL,
	[cambioadicional] [float] NULL,
	[importebruto] [float] NULL,
	[importebaseimponible] [float] NULL,
	[importeportes] [float] NULL,
	[porcentajedescuentocomercial] [float] NULL,
	[importedescuentocomercial] [float] NULL,
	[porcentajedescuentoprontopago] [float] NULL,
	[importedescuentoprontopago] [float] NULL,
	[importetotaldoc] [float] NULL,
	[importetotalmonedabase] [float] NULL,
	[notas] [ntext] NULL,
	[fkestados] [varchar](10) NULL,
	[fkobras] [varchar](15) NULL,
	[incoterm] [nvarchar](3) NULL,
	[descripcionincoterm] [nvarchar](30) NULL,
	[peso] [int] NULL,
	[confianza] [int] NULL,
	[costemateriales] [float] NULL,
	[tiempooficinatecnica] [float] NULL,
	[fkregimeniva] [varchar](5) NULL,
	[fktransportista] [varchar](15) NULL,
	[tipocambio] [float] NULL,
	[fkpuertosfkpaises] [varchar](3) NULL,
	[fkpuertosid] [varchar](4) NULL,
	[unidadnegocio] [nvarchar](3) NULL,
	[referenciadocumento] [nvarchar](30) NULL,
	[fkbancosmandatos] [varchar](3) NULL,
	[cartacredito] [nvarchar](25) NULL,
	[vencimientocartacredito] [datetime] NULL,
	[contenedores] [int] NULL,
	[fkcuentastesoreria] [varchar](15) NULL,
	[fkusuarioalta] [uniqueidentifier] NOT NULL CONSTRAINT [DF__Presupues__fkusu__0B7CAB7B]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechaalta] [datetime] NOT NULL CONSTRAINT [DF__Presupues__fecha__0C70CFB4]  DEFAULT (getdate()),
	[fkusuariomodificacion] [uniqueidentifier] NOT NULL CONSTRAINT [DF__Presupues__fkusu__0D64F3ED]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechamodificacion] [datetime] NOT NULL CONSTRAINT [DF__Presupues__fecha__0E591826]  DEFAULT (getdate()),
	[fkcarpetas] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Presupuestos] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PresupuestosCompras]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PresupuestosCompras](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkejercicio] [int] NOT NULL DEFAULT ((1)),
	[fkseries] [varchar](3) NOT NULL,
	[identificadorsegmento] [nvarchar](12) NULL,
	[referencia] [nvarchar](30) NULL,
	[fechadocumento] [datetime] NULL,
	[fechavalidez] [datetime] NULL,
	[fechaentrega] [datetime] NULL,
	[fecharevision] [datetime] NULL,
	[fkalmacen] [int] NULL,
	[fkproveedores] [varchar](15) NULL,
	[nombrecliente] [nvarchar](200) NULL,
	[clientedireccion] [nvarchar](100) NULL,
	[clientepoblacion] [nvarchar](100) NULL,
	[clientecp] [nvarchar](10) NULL,
	[clientepais] [nvarchar](50) NULL,
	[clienteprovincia] [nvarchar](50) NULL,
	[clientetelefono] [nvarchar](50) NULL,
	[clientefax] [nvarchar](15) NULL,
	[clienteemail] [nvarchar](200) NULL,
	[clientenif] [nvarchar](15) NULL,
	[fkformaspago] [int] NULL,
	[fkagentes] [varchar](15) NULL,
	[fkcomerciales] [varchar](15) NULL,
	[comisionagente] [float] NULL,
	[comisioncomercial] [float] NULL,
	[fkmonedas] [int] NULL,
	[cambioadicional] [float] NULL,
	[importebruto] [float] NULL,
	[importebaseimponible] [float] NULL,
	[importeportes] [float] NULL,
	[porcentajedescuentocomercial] [float] NULL,
	[importedescuentocomercial] [float] NULL,
	[porcentajedescuentoprontopago] [float] NULL,
	[importedescuentoprontopago] [float] NULL,
	[importetotaldoc] [float] NULL,
	[importetotalmonedabase] [float] NULL,
	[notas] [ntext] NULL,
	[fkestados] [varchar](10) NULL,
	[fkobras] [varchar](15) NULL,
	[incoterm] [nvarchar](3) NULL,
	[descripcionincoterm] [nvarchar](30) NULL,
	[peso] [int] NULL,
	[confianza] [int] NULL,
	[costemateriales] [float] NULL,
	[tiempooficinatecnica] [float] NULL,
	[fkregimeniva] [varchar](5) NULL,
	[fktransportista] [varchar](15) NULL,
	[tipocambio] [float] NULL,
	[fkpuertosfkpaises] [varchar](3) NULL,
	[fkpuertosid] [varchar](4) NULL,
	[unidadnegocio] [nvarchar](3) NULL,
	[referenciadocumento] [nvarchar](30) NULL,
	[fkbancosmandatos] [varchar](3) NULL,
	[cartacredito] [nvarchar](25) NULL,
	[vencimientocartacredito] [datetime] NULL,
	[contenedores] [int] NULL,
	[fkcuentastesoreria] [varchar](15) NULL,
	[fkusuarioalta] [uniqueidentifier] NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechaalta] [datetime] NOT NULL DEFAULT (getdate()),
	[fkusuariomodificacion] [uniqueidentifier] NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechamodificacion] [datetime] NOT NULL DEFAULT (getdate()),
	[fkcarpetas] [uniqueidentifier] NULL,
	[numerodocumentoproveedor] [nvarchar](30) NULL,
	[fechadocumentoproveedor] [datetime] NULL,
 CONSTRAINT [PK_PresupuestosCompras] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PresupuestosComprasLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PresupuestosComprasLin](
	[empresa] [varchar](4) NOT NULL,
	[fkpresupuestoscompras] [int] NOT NULL,
	[id] [int] NOT NULL,
	[fkarticulos] [varchar](15) NULL,
	[descripcion] [nvarchar](120) NULL,
	[lote] [nvarchar](12) NULL,
	[tabla] [int] NULL,
	[cantidad] [float] NULL,
	[cantidadpedida] [float] NULL,
	[largo] [float] NULL,
	[ancho] [float] NULL,
	[grueso] [float] NULL,
	[fkunidades] [varchar](2) NULL,
	[metros] [float] NULL,
	[precio] [float] NULL,
	[porcentajedescuento] [float] NULL,
	[importedescuento] [float] NULL,
	[fktiposiva] [varchar](3) NULL,
	[porcentajeiva] [float] NULL,
	[cuotaiva] [float] NULL,
	[porcentajerecargoequivalencia] [float] NULL,
	[cuotarecargoequivalencia] [float] NULL,
	[importe] [float] NULL,
	[notas] [ntext] NULL,
	[documentoorigen] [nvarchar](15) NULL,
	[documentodestino] [nvarchar](15) NULL,
	[canal] [nvarchar](3) NULL,
	[precioanterior] [float] NULL,
	[revision] [nvarchar](1) NULL,
	[decimalesmonedas] [int] NULL,
	[decimalesmedidas] [int] NULL,
	[labor1l1] [int] NULL,
	[labor2l1] [nvarchar](3) NULL,
	[labor3l1] [nvarchar](3) NULL,
	[labor4l1] [nvarchar](3) NULL,
	[labor1l2] [int] NULL,
	[labor2l2] [nvarchar](3) NULL,
	[labor3l2] [nvarchar](3) NULL,
	[labor4l2] [nvarchar](3) NULL,
	[labor1l3] [int] NULL,
	[labor2l3] [nvarchar](3) NULL,
	[labor3l3] [nvarchar](3) NULL,
	[labor4l3] [nvarchar](3) NULL,
	[labor1l4] [int] NULL,
	[labor2l4] [nvarchar](3) NULL,
	[labor3l4] [nvarchar](3) NULL,
	[labor4l4] [nvarchar](3) NULL,
	[bundle] [nvarchar](2) NULL,
	[tblnum] [int] NULL,
	[caja] [int] NULL,
	[orden] [int] NULL,
 CONSTRAINT [PK_PresupuestosComprasLin_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkpresupuestoscompras] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PresupuestosComprasTotales]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PresupuestosComprasTotales](
	[empresa] [varchar](4) NOT NULL,
	[fkpresupuestoscompras] [int] NOT NULL DEFAULT ((1)),
	[fktiposiva] [varchar](3) NOT NULL,
	[brutototal] [float] NULL,
	[porcentajerecargoequivalencia] [float] NULL,
	[importerecargoequivalencia] [float] NULL,
	[porcentajedescuentoprontopago] [float] NULL,
	[importedescuentoprontopago] [float] NULL,
	[porcentajedescuentocomercial] [float] NULL,
	[importedescuentocomercial] [float] NULL,
	[basetotal] [float] NULL,
	[porcentajeiva] [float] NULL,
	[cuotaiva] [float] NULL,
	[subtotal] [float] NULL,
	[decimalesmonedas] [int] NULL,
 CONSTRAINT [PK_PresupuestosComprasTotales_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkpresupuestoscompras] ASC,
	[fktiposiva] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PresupuestosLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PresupuestosLin](
	[empresa] [varchar](4) NOT NULL,
	[fkpresupuestos] [int] NOT NULL,
	[id] [int] NOT NULL,
	[fkarticulos] [varchar](15) NULL,
	[descripcion] [nvarchar](120) NULL,
	[lote] [nvarchar](12) NULL,
	[tabla] [int] NULL,
	[cantidad] [float] NULL,
	[cantidadpedida] [float] NULL,
	[largo] [float] NULL,
	[ancho] [float] NULL,
	[grueso] [float] NULL,
	[fkunidades] [varchar](2) NULL,
	[metros] [float] NULL,
	[precio] [float] NULL,
	[porcentajedescuento] [float] NULL,
	[importedescuento] [float] NULL,
	[fktiposiva] [varchar](3) NULL,
	[porcentajeiva] [float] NULL,
	[cuotaiva] [float] NULL,
	[porcentajerecargoequivalencia] [float] NULL,
	[cuotarecargoequivalencia] [float] NULL,
	[importe] [float] NULL,
	[notas] [ntext] NULL,
	[documentoorigen] [nvarchar](15) NULL,
	[documentodestino] [nvarchar](15) NULL,
	[canal] [nvarchar](3) NULL,
	[precioanterior] [float] NULL,
	[revision] [nvarchar](1) NULL,
	[decimalesmonedas] [int] NULL,
	[decimalesmedidas] [int] NULL,
	[labor1l1] [int] NULL,
	[labor2l1] [nvarchar](3) NULL,
	[labor3l1] [nvarchar](3) NULL,
	[labor4l1] [nvarchar](3) NULL,
	[labor1l2] [int] NULL,
	[labor2l2] [nvarchar](3) NULL,
	[labor3l2] [nvarchar](3) NULL,
	[labor4l2] [nvarchar](3) NULL,
	[labor1l3] [int] NULL,
	[labor2l3] [nvarchar](3) NULL,
	[labor3l3] [nvarchar](3) NULL,
	[labor4l3] [nvarchar](3) NULL,
	[labor1l4] [int] NULL,
	[labor2l4] [nvarchar](3) NULL,
	[labor3l4] [nvarchar](3) NULL,
	[labor4l4] [nvarchar](3) NULL,
	[bundle] [nvarchar](2) NULL,
	[tblnum] [int] NULL,
	[caja] [int] NULL,
	[orden] [int] NULL,
 CONSTRAINT [PK_PresupuestosLin_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkpresupuestos] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PresupuestosTotales]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PresupuestosTotales](
	[empresa] [varchar](4) NOT NULL,
	[fkpresupuestos] [int] NOT NULL CONSTRAINT [DF__Presupues__fkpre__19CACAD2]  DEFAULT ((1)),
	[fktiposiva] [varchar](3) NOT NULL,
	[brutototal] [float] NULL,
	[porcentajerecargoequivalencia] [float] NULL,
	[importerecargoequivalencia] [float] NULL,
	[porcentajedescuentoprontopago] [float] NULL,
	[importedescuentoprontopago] [float] NULL,
	[porcentajedescuentocomercial] [float] NULL,
	[importedescuentocomercial] [float] NULL,
	[basetotal] [float] NULL,
	[porcentajeiva] [float] NULL,
	[cuotaiva] [float] NULL,
	[subtotal] [float] NULL,
	[decimalesmonedas] [int] NULL,
 CONSTRAINT [PK_PresupuestosTotales_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkpresupuestos] ASC,
	[fktiposiva] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Prospectos]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Prospectos](
	[empresa] [varchar](4) NOT NULL,
	[fkcuentas] [varchar](15) NOT NULL,
	[fkfamiliacliente] [varchar](3) NULL,
	[fkzonacliente] [varchar](3) NULL,
	[fktipoempresa] [varchar](3) NULL,
	[fkunidadnegocio] [varchar](3) NULL,
	[fkincoterm] [varchar](3) NULL,
	[fkpuertosfkpaises] [varchar](3) NULL,
	[fkpuertosid] [varchar](4) NULL,
	[fkidiomas] [varchar](50) NULL,
	[fkregimeniva] [varchar](5) NOT NULL,
	[fkformaspago] [int] NOT NULL,
	[fkmodocontacto] [varchar](3) NULL,
	[observaciones] [ntext] NULL,
	[fktarifas] [varchar](12) NULL,
	[fkmonedas] [varchar](3) NULL,
	[fkcuentasagente] [varchar](15) NULL,
	[fkcuentascomercial] [varchar](15) NULL,
 CONSTRAINT [PK_Prospectos] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkcuentas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Proveedores]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Proveedores](
	[empresa] [varchar](4) NOT NULL,
	[fkcuentas] [varchar](15) NOT NULL,
	[fkidiomas] [varchar](3) NOT NULL,
	[fkfamiliaproveedor] [varchar](3) NULL,
	[fkzonaproveedor] [varchar](3) NULL,
	[fktipoempresa] [varchar](3) NULL,
	[fkunidadnegocio] [varchar](3) NULL,
	[fkincoterm] [varchar](3) NULL,
	[fkpuertosfkpaises] [varchar](3) NULL,
	[fkpuertosid] [varchar](4) NULL,
	[fkmonedas] [int] NOT NULL,
	[fkregimeniva] [varchar](5) NOT NULL,
	[fkgruposiva] [varchar](4) NULL,
	[criterioiva] [int] NOT NULL,
	[fktiposretencion] [varchar](4) NULL,
	[fktransportistahabitual] [varchar](15) NULL,
	[tipoportes] [int] NULL,
	[cuentatesoreria] [nvarchar](15) NULL,
	[fkformaspago] [int] NOT NULL,
	[descuentoprontopago] [float] NULL,
	[descuentocomercial] [float] NULL,
	[diafijopago1] [int] NULL,
	[diafijopago2] [int] NULL,
	[periodonopagodesde] [nvarchar](5) NULL,
	[periodonopagohasta] [nvarchar](5) NULL,
	[notas] [ntext] NULL,
	[tarifa] [nvarchar](50) NULL,
	[fkcriteriosagrupacion] [varchar](4) NULL,
	[previsionpagosperiodicos] [int] NULL,
 CONSTRAINT [PK_Proveedores] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkcuentas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Provincias]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Provincias](
	[codigopais] [varchar](3) NOT NULL,
	[id] [varchar](2) NOT NULL,
	[nombre] [nvarchar](100) NULL,
 CONSTRAINT [PK_Provincias] PRIMARY KEY CLUSTERED 
(
	[codigopais] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Proyectos]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Proyectos](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] NOT NULL,
	[fkseries] [varchar](3) NOT NULL,
	[identificadorsegmento] [nvarchar](12) NULL,
	[referencia] [varchar](15) NULL,
	[fechadocumento] [datetime] NULL,
	[asunto] [varchar](100) NULL,
	[fechaultimoseguimiento] [datetime] NULL,
	[fechaproximoseguimiento] [datetime] NULL,
	[fkempresa] [varchar](15) NULL,
	[fkcontacto] [varchar](15) NULL,
	[fkorigen] [varchar](3) NULL,
	[fketapa] [varchar](10) NULL,
	[prioridad] [int] NULL,
	[fkmargen] [varchar](3) NULL,
	[probabilidadcierre] [float] NULL,
	[fkoperario] [varchar](15) NULL,
	[fkcomercial] [varchar](15) NULL,
	[fkagente] [varchar](15) NULL,
	[notas] [varchar](max) NULL,
	[fkobra] [varchar](15) NULL,
	[coste] [int] NULL,
	[cerrado] [bit] NULL,
	[fechacierre] [datetime] NULL,
	[fkreaccion] [varchar](3) NULL,
 CONSTRAINT [PK_Proyectos] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Puertos]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Puertos](
	[fkpaises] [varchar](3) NOT NULL,
	[id] [varchar](4) NOT NULL,
	[descripcion] [nvarchar](100) NULL,
 CONSTRAINT [PK_puertos] PRIMARY KEY CLUSTERED 
(
	[fkpaises] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RegimenIva]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RegimenIva](
	[empresa] [varchar](4) NOT NULL,
	[id] [varchar](5) NOT NULL,
	[descripcion] [nvarchar](50) NULL,
	[normal] [bit] NULL,
	[recargo] [bit] NULL,
	[exportacion] [bit] NULL,
	[exentotasa] [bit] NULL,
	[operacionue] [bit] NULL,
	[inversionsujetopasivo] [bit] NULL,
	[operacionesnosujetas] [bit] NULL,
	[zonaespecial] [bit] NULL,
	[canariasigic] [bit] NULL,
	[extranjero] [bit] NULL,
	[ivadiferido] [bit] NULL,
	[ivaimportacion] [bit] NULL,
	[incompatiblecriteriocaja] [int] NULL,
	[soportadorepercutidoambos] [int] NULL,
	[bieninversion] [bit] NULL,
	[exentosventas] [bit] NULL,
	[claveoperacion340] [nvarchar](3) NULL,
	[incluirmodelo347] [bit] NULL,
	[tipofacturaemitida] [nvarchar](3) NULL,
	[regimenespecialemitida] [nvarchar](3) NULL,
	[tipofacturarecibida] [nvarchar](3) NULL,
	[regimenespecialrecibida] [nvarchar](3) NULL,
 CONSTRAINT [PK_RegimenIva] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Reservasstock]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Reservasstock](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkejercicio] [int] NOT NULL CONSTRAINT [DF__Reservasstock__fkeje__2AF556D4]  DEFAULT ((1)),
	[fkseries] [varchar](3) NOT NULL,
	[identificadorsegmento] [varchar](12) NOT NULL,
	[referencia] [varchar](30) NULL,
	[fechadocumento] [datetime] NULL,
	[fechavalidez] [datetime] NULL,
	[fechaentrega] [datetime] NULL,
	[fecharevision] [datetime] NULL,
	[fkalmacen] [varchar](4) NULL,
	[fkclientes] [varchar](15) NULL,
	[nombrecliente] [varchar](200) NULL,
	[clientedireccion] [varchar](100) NULL,
	[clientepoblacion] [varchar](100) NULL,
	[clientecp] [varchar](10) NULL,
	[clientepais] [varchar](50) NULL,
	[clienteprovincia] [varchar](50) NULL,
	[clientetelefono] [varchar](50) NULL,
	[clientefax] [varchar](15) NULL,
	[clienteemail] [varchar](200) NULL,
	[clientenif] [varchar](15) NULL,
	[fkformaspago] [int] NULL,
	[fkagentes] [varchar](15) NULL,
	[fkcomerciales] [varchar](15) NULL,
	[comisionagente] [float] NULL,
	[comisioncomercial] [float] NULL,
	[fkmonedas] [int] NULL,
	[cambioadicional] [float] NULL,
	[importebruto] [float] NULL,
	[importebaseimponible] [float] NULL,
	[importeportes] [float] NULL,
	[porcentajedescuentocomercial] [float] NULL,
	[importedescuentocomercial] [float] NULL,
	[porcentajedescuentoprontopago] [float] NULL,
	[importedescuentoprontopago] [float] NULL,
	[importetotaldoc] [float] NULL,
	[importetotalmonedabase] [float] NULL,
	[notas] [ntext] NULL,
	[fkestados] [varchar](10) NULL,
	[fkobras] [varchar](15) NULL,
	[incoterm] [varchar](3) NULL,
	[descripcionincoterm] [varchar](30) NULL,
	[peso] [int] NULL,
	[confianza] [int] NULL,
	[costemateriales] [float] NULL,
	[tiempooficinatecnica] [float] NULL,
	[fkregimeniva] [varchar](5) NULL,
	[fktransportista] [varchar](15) NULL,
	[tipocambio] [float] NULL,
	[fkpuertosfkpaises] [varchar](3) NULL,
	[fkpuertosid] [varchar](4) NULL,
	[unidadnegocio] [varchar](3) NULL,
	[referenciadocumento] [varchar](30) NULL,
	[fkbancosmandatos] [varchar](3) NULL,
	[cartacredito] [varchar](25) NULL,
	[vencimientocartacredito] [datetime] NULL,
	[contenedores] [int] NULL,
	[fkcuentastesoreria] [varchar](15) NULL,
	[numerodocumentoproveedor] [varchar](30) NULL,
	[fechadocumentoproveedor] [datetime] NULL,
	[fkclientesreserva] [varchar](15) NULL,
	[tipoalbaran] [int] NOT NULL,
	[fkmotivosdevolucion] [varchar](3) NULL,
	[nombretransportista] [varchar](40) NULL,
	[conductor] [varchar](20) NULL,
	[matricula] [varchar](12) NULL,
	[bultos] [int] NULL,
	[pesoneto] [float] NULL,
	[pesobruto] [float] NULL,
	[volumen] [float] NULL,
	[envio] [ntext] NULL,
	[fkoperarios] [varchar](15) NULL,
	[fkoperadortransporte] [varchar](15) NULL,
	[fkzonas] [varchar](3) NULL,
	[fkdireccionfacturacion] [int] NULL,
	[fkcriteriosagrupacion] [varchar](4) NULL,
	[tipoportes] [int] NULL,
	[costeportes] [float] NULL,
	[fkusuarioalta] [uniqueidentifier] NOT NULL CONSTRAINT [DF__Reservasstock__fkusu__2724C5F0]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechaalta] [datetime] NOT NULL CONSTRAINT [DF__Reservasstock__fecha__2818EA29]  DEFAULT (getdate()),
	[fkusuariomodificacion] [uniqueidentifier] NOT NULL CONSTRAINT [DF__Reservasstock__fkusu__290D0E62]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechamodificacion] [datetime] NOT NULL CONSTRAINT [DF__Reservasstock__fecha__2A01329B]  DEFAULT (getdate()),
	[fkcarpetas] [uniqueidentifier] NULL,
	[modo] [int] NOT NULL DEFAULT ((0)),
	[integridadreferencial] [uniqueidentifier] NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
 CONSTRAINT [PK_Reservasstock_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ReservasstockLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ReservasstockLin](
	[empresa] [varchar](4) NOT NULL,
	[fkreservasstock] [int] NOT NULL CONSTRAINT [DF__Reservasstock__fkalb__2BE97B0D]  DEFAULT ((1)),
	[id] [int] NOT NULL,
	[fkarticulos] [varchar](15) NULL,
	[descripcion] [nvarchar](120) NULL,
	[lote] [nvarchar](12) NULL,
	[tabla] [int] NULL,
	[cantidad] [float] NULL,
	[cantidadpedida] [float] NULL,
	[largo] [float] NULL,
	[ancho] [float] NULL,
	[grueso] [float] NULL,
	[fkunidades] [varchar](2) NULL,
	[metros] [float] NULL,
	[precio] [float] NULL,
	[porcentajedescuento] [float] NULL,
	[importedescuento] [float] NULL,
	[fktiposiva] [varchar](3) NULL,
	[porcentajeiva] [float] NULL,
	[cuotaiva] [float] NULL,
	[porcentajerecargoequivalencia] [float] NULL,
	[cuotarecargoequivalencia] [float] NULL,
	[importe] [float] NULL,
	[importenetolinea] [float] NULL,
	[notas] [ntext] NULL,
	[documentoorigen] [nvarchar](15) NULL,
	[documentodestino] [nvarchar](15) NULL,
	[canal] [nvarchar](3) NULL,
	[precioanterior] [float] NULL,
	[revision] [nvarchar](1) NULL,
	[decimalesmonedas] [int] NULL,
	[decimalesmedidas] [int] NULL,
	[bundle] [nvarchar](2) NULL,
	[tblnum] [int] NULL,
	[contenedor] [nvarchar](12) NULL,
	[sello] [nvarchar](10) NULL,
	[caja] [int] NULL,
	[pesoneto] [float] NULL,
	[pesobruto] [float] NULL,
	[seccion] [nvarchar](4) NULL,
	[costeadicionalmaterial] [float] NULL,
	[costeadicionalportes] [float] NULL,
	[costeadicionalotro] [float] NULL,
	[costeacicionalvariable] [float] NULL,
	[orden] [int] NULL,
	[fkpedidos] [int] NULL,
	[fkpedidosid] [int] NULL,
	[fkpedidosreferencia] [varchar](30) NULL,
	[flagidentifier] [uniqueidentifier] NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
 CONSTRAINT [PK_ReservasstockLin_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkreservasstock] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ReservasstockTotales]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ReservasstockTotales](
	[empresa] [varchar](4) NOT NULL,
	[fkreservasstock] [int] NOT NULL CONSTRAINT [DF__Reservasstock__fkalb__2CDD9F46]  DEFAULT ((1)),
	[fktiposiva] [varchar](3) NOT NULL,
	[brutototal] [float] NULL,
	[porcentajerecargoequivalencia] [float] NULL,
	[importerecargoequivalencia] [float] NULL,
	[porcentajedescuentoprontopago] [float] NULL,
	[importedescuentoprontopago] [float] NULL,
	[porcentajedescuentocomercial] [float] NULL,
	[importedescuentocomercial] [float] NULL,
	[basetotal] [float] NULL,
	[porcentajeiva] [float] NULL,
	[cuotaiva] [float] NULL,
	[subtotal] [float] NULL,
	[decimalesmonedas] [int] NULL,
 CONSTRAINT [PK_ReservasstockTotales_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkreservasstock] ASC,
	[fktiposiva] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[id] [uniqueidentifier] NOT NULL,
	[role] [nvarchar](30) NULL,
	[permisos] [xml] NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RolesUsuarios]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RolesUsuarios](
	[FkUsuarios] [uniqueidentifier] NOT NULL,
	[FkRoles] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_RolesUsuarios] PRIMARY KEY CLUSTERED 
(
	[FkUsuarios] ASC,
	[FkRoles] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Seccionesanaliticas]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Seccionesanaliticas](
	[empresa] [varchar](4) NOT NULL,
	[id] [varchar](4) NOT NULL,
	[nombre] [nvarchar](100) NULL,
	[grupo] [nvarchar](3) NULL,
 CONSTRAINT [PK_Seccionesanaliticas] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Seguimientos]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Seguimientos](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] NOT NULL,
	[origen] [varchar](15) NOT NULL,
	[tipo] [int] NULL,
	[usuario] [varchar](15) NULL,
	[asunto] [varchar](100) NULL,
	[fechadocumento] [datetime] NULL,
	[fkempresa] [varchar](15) NULL,
	[fkcontacto] [varchar](15) NULL,
	[fketapa] [varchar](10) NULL,
	[fkaccion] [varchar](3) NULL,
	[fkclavecoste] [varchar](3) NULL,
	[coste] [int] NULL,
	[notas] [varchar](max) NULL,
	[fkdocumentorelacionado] [varchar](3) NULL,
	[cerrado] [bit] NULL,
	[fecharesolucion] [datetime] NULL,
	[fkreaccion] [varchar](3) NULL,
	[fkreferenciadocumentorelacionado] [varchar](30) NULL,
	[fechaproximoseguimiento] [datetime] NULL,
 CONSTRAINT [PK_Seguimientos] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[empresa] ASC,
	[origen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Series]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Series](
	[empresa] [varchar](4) NOT NULL,
	[tipodocumento] [varchar](3) NOT NULL,
	[id] [varchar](3) NOT NULL,
	[descripcion] [nvarchar](50) NULL,
	[fkmonedas] [int] NULL,
	[fkregimeniva] [varchar](5) NULL,
	[fkcontadores] [varchar](12) NULL,
	[fkejercicios] [varchar](4) NULL,
	[tipoimpresion] [int] NULL,
	[riesgo] [bit] NULL,
	[exentoiva] [bit] NULL,
	[borrador] [bit] NULL,
	[rectificativa] [bit] NULL,
	[fkseriesasociada] [varchar](3) NULL,
	[fechamodificacionbloqueo] [datetime] NULL,
	[fkusuariobloqueo] [uniqueidentifier] NULL,
	[bloqueada] [bit] NULL,
	[fkmotivosbloqueo] [varchar](3) NULL,
	[tipoalmacenlote] [int] NULL,
	[entradasvarias] [bit] NULL DEFAULT ((0)),
	[salidasvarias] [bit] NULL DEFAULT ((0)),
 CONSTRAINT [PK_Series] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[tipodocumento] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SeriesContables]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SeriesContables](
	[empresa] [varchar](4) NOT NULL,
	[tipodocumento] [varchar](3) NOT NULL,
	[id] [varchar](3) NOT NULL,
	[descripcion] [nvarchar](50) NULL,
	[fkmonedas] [int] NULL,
	[fkcontadores] [varchar](12) NULL,
	[fkejercicios] [varchar](4) NULL,
	[fechamodificacionbloqueo] [datetime] NULL,
	[fkusuariobloqueo] [uniqueidentifier] NULL,
	[bloqueada] [bit] NULL,
	[fkmotivosbloqueo] [varchar](3) NULL,
 CONSTRAINT [PK_SeriesContables] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[tipodocumento] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Stockactual]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Stockactual](
	[empresa] [varchar](4) NOT NULL,
	[fkalmacenes] [varchar](4) NOT NULL,
	[fkarticulos] [varchar](15) NOT NULL,
	[lote] [varchar](15) NOT NULL,
	[loteid] [varchar](5) NOT NULL,
	[referenciaproveedor] [nvarchar](50) NULL,
	[tag] [nvarchar](50) NULL,
	[fkunidadesmedida] [varchar](2) NOT NULL,
	[largo] [float] NOT NULL,
	[ancho] [float] NOT NULL,
	[grueso] [float] NOT NULL,
	[cantidadtotal] [float] NOT NULL,
	[cantidaddisponible] [float] NOT NULL,
	[fkalmaceneszona] [int] NULL,
	[fkcalificacioncomercial] [varchar](3) NULL,
	[fktipograno] [varchar](3) NULL,
	[fktonomaterial] [varchar](3) NULL,
	[pesonetolote] [float] NULL,
	[fecha] [datetime] NOT NULL,
	[fechacaducidad] [datetime] NULL,
	[integridadreferencialflag] [uniqueidentifier] NOT NULL,
	[metros] [float] NULL,
	[fkincidenciasmaterial] [varchar](3) NULL,
	[fkvariedades] [varchar](20) NULL,
	[costeadicionalmaterial] [float] NULL,
	[costeadicionalportes] [float] NULL,
	[costeadicionalotro] [float] NULL,
	[costeacicionalvariable] [float] NULL,
	[tipoalmacenlote] [int] NULL,
 CONSTRAINT [PK_Stockactual] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkalmacenes] ASC,
	[fkarticulos] ASC,
	[lote] ASC,
	[loteid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Stockhistorico]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Stockhistorico](
	[empresa] [varchar](4) NOT NULL,
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[fkalmacenes] [varchar](4) NOT NULL,
	[fkarticulos] [varchar](15) NOT NULL,
	[lote] [varchar](15) NOT NULL,
	[loteid] [varchar](5) NOT NULL,
	[referenciaproveedor] [nvarchar](50) NULL,
	[tag] [nvarchar](50) NULL,
	[fkunidadesmedida] [varchar](2) NOT NULL,
	[largo] [float] NOT NULL,
	[ancho] [float] NOT NULL,
	[grueso] [float] NOT NULL,
	[cantidadtotal] [float] NOT NULL,
	[cantidaddisponible] [float] NOT NULL,
	[fkalmaceneszona] [int] NULL,
	[fkcalificacioncomercial] [varchar](3) NULL,
	[fktipograno] [varchar](3) NULL,
	[fktonomaterial] [varchar](3) NULL,
	[pesonetolote] [float] NULL,
	[fecha] [datetime] NOT NULL,
	[fechacaducidad] [datetime] NULL,
	[integridadreferencialflag] [uniqueidentifier] NOT NULL,
	[metros] [float] NULL,
	[fkincidenciasmaterial] [varchar](3) NULL,
	[fkvariedades] [varchar](20) NULL,
	[fkcarpetas] [uniqueidentifier] NULL,
	[costeadicionalmaterial] [float] NULL,
	[costeadicionalportes] [float] NULL,
	[costeadicionalotro] [float] NULL,
	[costeacicionalvariable] [float] NULL,
	[tipoalmacenlote] [int] NULL,
	[codigoproveedor] [varchar](15) NULL,
	[fechaentrada] [date] NULL,
	[precioentrada] [float] NULL,
	[referenciaentrada] [varchar](30) NULL,
	[codigodocumentoentrada] [int] NULL,
	[cantidadentrada] [float] NULL,
	[largoentrada] [float] NULL,
	[anchoentrada] [float] NULL,
	[gruesoentrada] [float] NULL,
	[metrosentrada] [float] NULL,
	[netocompra] [float] NULL,
	[codigocliente] [varchar](15) NULL,
	[fechasalida] [date] NULL,
	[preciosalida] [float] NULL,
	[referenciasalida] [varchar](30) NULL,
	[codigodocumentosalida] [int] NULL,
	[cantidadsalida] [float] NULL,
	[largosalida] [float] NULL,
	[anchosalida] [float] NULL,
	[gruesosalida] [float] NULL,
	[metrossalida] [float] NULL,
	[preciovaloracion] [float] NULL,
 CONSTRAINT [PK_Stockhistorico] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tablasvarias]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tablasvarias](
	[id] [int] NOT NULL,
	[nombre] [nvarchar](100) NULL,
	[clase] [nvarchar](300) NULL,
	[tipo] [int] NULL,
	[noeditable] [bit] NULL,
 CONSTRAINT [PK_Tablasvarias_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TablasvariasLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TablasvariasLin](
	[fkTablasvarias] [int] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[xml] [xml] NULL,
 CONSTRAINT [PK_TablasvariasLin_1] PRIMARY KEY CLUSTERED 
(
	[fkTablasvarias] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tareas]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tareas](
	[empresa] [varchar](4) NOT NULL,
	[id] [varchar](5) NOT NULL,
	[descripcion] [nvarchar](100) NULL,
	[seccionproduccion] [varchar](5) NULL,
	[imputacion] [int] NOT NULL,
	[capacidad] [float] NULL,
	[precio] [float] NULL,
	[unidad] [int] NOT NULL,
 CONSTRAINT [PK_Tareas] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TareasLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TareasLin](
	[empresa] [varchar](4) NOT NULL,
	[fktareas] [varchar](5) NOT NULL,
	[id] [int] NOT NULL,
	[año] [smallint] NULL,
	[precio] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fktareas] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tarifas]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tarifas](
	[empresa] [varchar](4) NOT NULL,
	[id] [varchar](12) NOT NULL,
	[descripcion] [nvarchar](40) NULL,
	[tipoflujo] [int] NULL,
	[tipotarifa] [int] NULL,
	[fkcuentas] [varchar](15) NULL,
	[fkmonedas] [int] NULL,
	[asignartarifaalcreararticulos] [bit] NULL,
	[precioobligatorio] [bit] NULL,
	[validodesde] [datetime] NULL,
	[validohasta] [datetime] NULL,
	[ivaincluido] [bit] NULL,
	[observaciones] [ntext] NULL,
	[precioautomaticobase] [nvarchar](12) NULL,
	[precioautomaticoporcentajebase] [float] NULL,
	[precioautomaticoporcentajefijo] [float] NULL,
	[precioautomaticofkfamiliasproductosdesde] [nvarchar](2) NULL,
	[precioautomaticofkfamiliasproductoshasta] [nvarchar](2) NULL,
	[precioautomaticofkmaterialesdesde] [nvarchar](3) NULL,
	[precioautomaticofkmaterialeshasta] [nvarchar](3) NULL,
	[fkMotivosbloqueo] [varchar](3) NULL,
	[fechamodificacionbloqueo] [datetime] NULL,
	[fkUsuariobloqueo] [uniqueidentifier] NULL,
	[bloqueada] [bit] NULL,
 CONSTRAINT [PK_Tarifas] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tarifasbase]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tarifasbase](
	[fktarifa] [varchar](12) NOT NULL,
	[tipoflujo] [int] NOT NULL,
	[descripcion] [nvarchar](40) NULL,
 CONSTRAINT [PK_Tarifasbase_1] PRIMARY KEY CLUSTERED 
(
	[fktarifa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TarifasLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TarifasLin](
	[empresa] [varchar](4) NOT NULL,
	[fktarifas] [varchar](12) NOT NULL,
	[fkarticulos] [varchar](15) NOT NULL,
	[precio] [float] NULL,
	[descuento] [float] NULL,
	[Unidades] [nvarchar](2) NULL,
 CONSTRAINT [PK_TarifasLin] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fktarifas] ASC,
	[fkarticulos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tiposcuentas]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tiposcuentas](
	[empresa] [varchar](4) NOT NULL,
	[tipos] [int] NOT NULL,
	[cuenta] [nvarchar](10) NULL,
	[descripcion] [nvarchar](100) NULL,
	[nifobligatorio] [bit] NULL,
	[categoria] [int] NOT NULL,
 CONSTRAINT [PK_Gestioncuentas] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[tipos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TiposcuentasLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TiposcuentasLin](
	[empresa] [varchar](4) NOT NULL,
	[fkTiposcuentas] [int] NOT NULL,
	[cuenta] [varchar](10) NOT NULL,
	[descripcion] [nvarchar](100) NULL,
 CONSTRAINT [PK_GestioncuentasLin] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkTiposcuentas] ASC,
	[cuenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TiposIva]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TiposIva](
	[empresa] [varchar](4) NOT NULL,
	[id] [varchar](3) NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[fkgruposiva] [varchar](3) NULL,
	[porcentajeiva] [float] NULL,
	[porcentajerecargoequivalente] [float] NULL,
	[fkcuentasivasoportado] [varchar](10) NULL,
	[fkcuentasivarepercutido] [varchar](10) NULL,
	[fkcuentasivanodeducible] [varchar](10) NULL,
	[fkcuentasrecargoequivalenciarepercutido] [varchar](10) NULL,
	[fkcuentasivasoportadocriteriocaja] [varchar](10) NULL,
	[fkcuentasivarepercutidocriteriocaja] [varchar](10) NULL,
	[fkcuentasrecargoequivalenciarepercutidocriteriocaja] [varchar](10) NULL,
	[ivasoportado] [bit] NULL,
	[ivadeducible] [bit] NULL,
	[porcentajededucible] [float] NULL,
 CONSTRAINT [PK_TiposIva] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tiposretenciones]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tiposretenciones](
	[empresa] [varchar](4) NOT NULL,
	[id] [varchar](4) NOT NULL,
	[descripcion] [nvarchar](100) NULL,
	[porcentajeretencion] [float] NULL,
	[fkcuentascargo] [varchar](15) NULL,
	[fkcuentasabono] [varchar](15) NULL,
	[tiporendimiento] [int] NULL,
 CONSTRAINT [PK_retenciones] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Trabajos]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Trabajos](
	[empresa] [varchar](4) NOT NULL,
	[id] [varchar](5) NOT NULL,
	[descripcion] [nvarchar](100) NULL,
	[tipotrabajo] [int] NOT NULL,
	[tipoimputacion] [int] NOT NULL,
	[fkacabadoinicial] [varchar](2) NULL,
	[fkacabadofinal] [varchar](2) NULL,
	[fkarticulofacturable] [varchar](15) NULL,
 CONSTRAINT [PK_Trabajos] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Transformaciones]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Transformaciones](
	[empresa] [nvarchar](4) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkejercicio] [int] NOT NULL DEFAULT ((1)),
	[fkseries] [nvarchar](3) NOT NULL,
	[identificadorsegmento] [nvarchar](12) NULL,
	[referencia] [nvarchar](30) NULL,
	[fechadocumento] [datetime] NULL,
	[fkalmacen] [nvarchar](4) NULL,
	[fkproveedores] [varchar](15) NULL,
	[nombreproveedor] [nvarchar](200) NULL,
	[notas] [ntext] NULL,
	[fktransportista] [varchar](15) NULL,
	[referenciadocumentoproveedor] [nvarchar](30) NULL,
	[fechadocumentoproveedor] [datetime] NULL,
	[nombretransportista] [nvarchar](40) NULL,
	[conductor] [nvarchar](20) NULL,
	[matricula] [nvarchar](12) NULL,
	[fkoperarios] [varchar](15) NULL,
	[fkoperadortransporte] [varchar](15) NULL,
	[fkzonas] [varchar](3) NULL,
	[fkusuarioalta] [uniqueidentifier] NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechaalta] [datetime] NOT NULL DEFAULT (getdate()),
	[fkusuariomodificacion] [uniqueidentifier] NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechamodificacion] [datetime] NOT NULL DEFAULT (getdate()),
	[integridadreferencialflag] [uniqueidentifier] NULL,
	[fkestados] [nvarchar](10) NOT NULL DEFAULT ('99-002'),
	[tipoalmacenlote] [int] NULL,
 CONSTRAINT [PK_Transformaciones_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Transformacionescostesadicionales]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transformacionescostesadicionales](
	[empresa] [nvarchar](4) NOT NULL,
	[fktransformaciones] [int] NOT NULL,
	[id] [int] NOT NULL,
	[tipodocumento] [int] NOT NULL,
	[referenciadocumento] [nvarchar](30) NULL,
	[importe] [float] NULL,
	[porcentaje] [float] NULL,
	[total] [float] NULL,
	[tipocoste] [int] NOT NULL,
	[tiporeparto] [int] NOT NULL,
	[notas] [ntext] NULL,
 CONSTRAINT [PK_Transformacionescostesadicionales] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fktransformaciones] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transformacionesentradalin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Transformacionesentradalin](
	[empresa] [nvarchar](4) NOT NULL,
	[fktransformaciones] [int] NOT NULL CONSTRAINT [DF_Transformacionesentradalin_fktransformaciones]  DEFAULT ((1)),
	[id] [int] NOT NULL,
	[fkarticulos] [nvarchar](15) NULL,
	[descripcion] [nvarchar](120) NULL,
	[lote] [nvarchar](12) NULL,
	[tabla] [int] NULL,
	[cantidad] [float] NULL,
	[largo] [float] NULL,
	[ancho] [float] NULL,
	[grueso] [float] NULL,
	[fkunidades] [nvarchar](2) NULL,
	[metros] [float] NULL,
	[notas] [ntext] NULL,
	[documentoorigen] [nvarchar](15) NULL,
	[documentodestino] [nvarchar](15) NULL,
	[canal] [nvarchar](3) NULL,
	[revision] [nvarchar](1) NULL,
	[decimalesmonedas] [int] NULL,
	[decimalesmedidas] [int] NULL,
	[bundle] [nvarchar](2) NULL,
	[tblnum] [int] NULL,
	[contenedor] [nvarchar](12) NULL,
	[sello] [nvarchar](10) NULL,
	[caja] [int] NULL,
	[pesoneto] [float] NULL,
	[pesobruto] [float] NULL,
	[seccion] [nvarchar](4) NULL,
	[costeadicionalmaterial] [float] NULL,
	[costeadicionalportes] [float] NULL,
	[costeadicionalotro] [float] NULL,
	[costeacicionalvariable] [float] NULL,
	[orden] [int] NULL,
	[flagidentifier] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Transformacionesentradalin_flagidentifier]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fkcontadoreslotes] [varchar](12) NULL,
	[precio] [float] NULL,
	[nuevo] [bit] NULL,
	[loteautomaticoid] [varchar](40) NULL,
	[lotenuevocontador] [int] NULL,
	[tipoalmacenlote] [int] NULL,
 CONSTRAINT [PK_Transformacionesentradalin] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fktransformaciones] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Transformacioneslotes]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Transformacioneslotes](
	[empresa] [nvarchar](4) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkejercicio] [int] NOT NULL DEFAULT ((1)),
	[fkseries] [nvarchar](3) NOT NULL,
	[fkestados] [nvarchar](10) NOT NULL,
	[fktrabajos] [nvarchar](5) NOT NULL,
	[identificadorsegmento] [nvarchar](12) NULL,
	[referencia] [nvarchar](30) NULL,
	[fechadocumento] [datetime] NULL,
	[fkalmacen] [nvarchar](4) NULL,
	[fkproveedores] [varchar](15) NULL,
	[nombreproveedor] [nvarchar](200) NULL,
	[notas] [ntext] NULL,
	[fktransportista] [varchar](15) NULL,
	[referenciadocumentoproveedor] [nvarchar](30) NULL,
	[fechadocumentoproveedor] [datetime] NULL,
	[nombretransportista] [nvarchar](40) NULL,
	[conductor] [nvarchar](20) NULL,
	[matricula] [nvarchar](12) NULL,
	[fkoperarios] [varchar](15) NULL,
	[fkoperadortransporte] [varchar](15) NULL,
	[fkzonas] [varchar](3) NULL,
	[fkusuarioalta] [uniqueidentifier] NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechaalta] [datetime] NOT NULL DEFAULT (getdate()),
	[fkusuariomodificacion] [uniqueidentifier] NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechamodificacion] [datetime] NOT NULL DEFAULT (getdate()),
	[integridadreferencialflag] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Transformacioneslotes_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Transformacioneslotescostesadicionales]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transformacioneslotescostesadicionales](
	[empresa] [nvarchar](4) NOT NULL,
	[fkTransformacioneslotes] [int] NOT NULL,
	[id] [int] NOT NULL,
	[tipodocumento] [int] NOT NULL,
	[referenciadocumento] [nvarchar](30) NULL,
	[importe] [float] NULL,
	[porcentaje] [float] NULL,
	[total] [float] NULL,
	[tipocoste] [int] NOT NULL,
	[tiporeparto] [int] NOT NULL,
	[notas] [ntext] NULL,
 CONSTRAINT [PK_Transformacioneslotescostesadicionales] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkTransformacioneslotes] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transformacionesloteslin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Transformacionesloteslin](
	[empresa] [nvarchar](4) NOT NULL,
	[fkTransformacioneslotes] [int] NOT NULL CONSTRAINT [DF_Transformacionesloteslin_fkTransformacioneslotes]  DEFAULT ((1)),
	[id] [int] NOT NULL,
	[fkarticulos] [nvarchar](15) NULL,
	[descripcion] [nvarchar](120) NULL,
	[lote] [nvarchar](12) NULL,
	[tabla] [int] NULL,
	[cantidad] [float] NULL,
	[largo] [float] NULL,
	[ancho] [float] NULL,
	[grueso] [float] NULL,
	[fkunidades] [nvarchar](2) NULL,
	[metros] [float] NULL,
	[notas] [ntext] NULL,
	[documentoorigen] [nvarchar](15) NULL,
	[documentodestino] [nvarchar](15) NULL,
	[canal] [nvarchar](3) NULL,
	[revision] [nvarchar](1) NULL,
	[decimalesmonedas] [int] NULL,
	[decimalesmedidas] [int] NULL,
	[bundle] [nvarchar](2) NULL,
	[tblnum] [int] NULL,
	[contenedor] [nvarchar](12) NULL,
	[sello] [nvarchar](10) NULL,
	[caja] [int] NULL,
	[pesoneto] [float] NULL,
	[pesobruto] [float] NULL,
	[seccion] [nvarchar](4) NULL,
	[costeadicionalmaterial] [float] NULL,
	[costeadicionalportes] [float] NULL,
	[costeadicionalotro] [float] NULL,
	[costeacicionalvariable] [float] NULL,
	[orden] [int] NULL,
	[flagidentifier] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Transformacionesloteslin_flagidentifier]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fkcontadoreslotes] [varchar](12) NULL,
	[precio] [float] NULL,
 CONSTRAINT [PK_Transformacionesloteslin] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkTransformacioneslotes] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Transformacionessalidalin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transformacionessalidalin](
	[empresa] [nvarchar](4) NOT NULL,
	[fktransformaciones] [int] NOT NULL CONSTRAINT [DF_Table_1_fkalbaranes]  DEFAULT ((1)),
	[id] [int] NOT NULL,
	[fkarticulos] [nvarchar](15) NULL,
	[descripcion] [nvarchar](120) NULL,
	[lote] [nvarchar](12) NULL,
	[tabla] [int] NULL,
	[cantidad] [float] NULL,
	[largo] [float] NULL,
	[ancho] [float] NULL,
	[grueso] [float] NULL,
	[fkunidades] [nvarchar](2) NULL,
	[metros] [float] NULL,
	[notas] [ntext] NULL,
	[documentoorigen] [nvarchar](15) NULL,
	[documentodestino] [nvarchar](15) NULL,
	[canal] [nvarchar](3) NULL,
	[revision] [nvarchar](1) NULL,
	[decimalesmonedas] [int] NULL,
	[decimalesmedidas] [int] NULL,
	[bundle] [nvarchar](2) NULL,
	[tblnum] [int] NULL,
	[contenedor] [nvarchar](12) NULL,
	[sello] [nvarchar](10) NULL,
	[caja] [int] NULL,
	[pesoneto] [float] NULL,
	[pesobruto] [float] NULL,
	[seccion] [nvarchar](4) NULL,
	[orden] [int] NULL,
	[flagidentifier] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Transformacionessalidalin_flagidentifier]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[precio] [float] NULL,
	[tipoalmacenlote] [int] NULL,
 CONSTRAINT [PK_Transformacionessalidalin] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fktransformaciones] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transportistas]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Transportistas](
	[empresa] [varchar](4) NOT NULL,
	[fkcuentas] [varchar](15) NOT NULL,
	[fkidiomas] [varchar](3) NOT NULL,
	[fkfamiliaacreedor] [varchar](3) NULL,
	[fkzonaacreedor] [varchar](3) NULL,
	[fktipoempresa] [varchar](3) NULL,
	[fkunidadnegocio] [varchar](3) NULL,
	[fkincoterm] [varchar](3) NULL,
	[fkpuertosfkpaises] [varchar](3) NULL,
	[fkpuertosid] [varchar](4) NULL,
	[fkmonedas] [int] NOT NULL,
	[fkregimeniva] [varchar](5) NOT NULL,
	[fkgruposiva] [varchar](4) NULL,
	[criterioiva] [int] NOT NULL,
	[fktiposretencion] [varchar](4) NULL,
	[fktransportistahabitual] [varchar](15) NULL,
	[tipoportes] [int] NULL,
	[cuentatesoreria] [nvarchar](15) NULL,
	[fkformaspago] [int] NOT NULL,
	[descuentoprontopago] [float] NULL,
	[descuentocomercial] [float] NULL,
	[diafijopago1] [int] NULL,
	[diafijopago2] [int] NULL,
	[periodonopagodesde] [nvarchar](5) NULL,
	[periodonopagohasta] [nvarchar](5) NULL,
	[notas] [ntext] NULL,
	[tarifa] [nvarchar](50) NULL,
	[conductorhabitual] [nvarchar](30) NULL,
	[matricula] [nvarchar](12) NULL,
	[remolque] [nvarchar](12) NULL,
	[tipotransporte] [nvarchar](3) NULL,
 CONSTRAINT [PK_Transportistas] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fkcuentas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Traspasosalmacen]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Traspasosalmacen](
	[empresa] [varchar](4) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fkejercicio] [int] NOT NULL CONSTRAINT [DF__Traspasosalmacen__fkeje__2AF556D4]  DEFAULT ((1)),
	[fkseries] [varchar](3) NOT NULL,
	[identificadorsegmento] [nvarchar](12) NULL,
	[referencia] [nvarchar](30) NULL,
	[fechadocumento] [datetime] NULL,
	[fechavalidez] [datetime] NULL,
	[fechaentrega] [datetime] NULL,
	[fecharevision] [datetime] NULL,
	[fkalmacen] [varchar](4) NULL,
	[fkproveedores] [varchar](15) NULL,
	[nombreproveedor] [nvarchar](200) NULL,
	[proveedordireccion] [nvarchar](100) NULL,
	[proveedorpoblacion] [nvarchar](100) NULL,
	[proveedorcp] [nvarchar](10) NULL,
	[proveedorpais] [nvarchar](50) NULL,
	[proveedorprovincia] [nvarchar](50) NULL,
	[proveedortelefono] [nvarchar](50) NULL,
	[proveedorfax] [nvarchar](15) NULL,
	[proveedoremail] [nvarchar](200) NULL,
	[proveedornif] [nvarchar](15) NULL,
	[fkformaspago] [int] NULL,
	[fkagentes] [varchar](15) NULL,
	[fkcomerciales] [varchar](15) NULL,
	[comisionagente] [float] NULL,
	[comisioncomercial] [float] NULL,
	[fkmonedas] [int] NULL,
	[cambioadicional] [float] NULL,
	[importebruto] [float] NULL,
	[importebaseimponible] [float] NULL,
	[importeportes] [float] NULL,
	[porcentajedescuentocomercial] [float] NULL,
	[importedescuentocomercial] [float] NULL,
	[porcentajedescuentoprontopago] [float] NULL,
	[importedescuentoprontopago] [float] NULL,
	[importetotaldoc] [float] NULL,
	[importetotalmonedabase] [float] NULL,
	[notas] [ntext] NULL,
	[fkestados] [varchar](10) NULL,
	[fkobras] [varchar](15) NULL,
	[incoterm] [nvarchar](3) NULL,
	[descripcionincoterm] [nvarchar](30) NULL,
	[peso] [int] NULL,
	[confianza] [int] NULL,
	[costemateriales] [float] NULL,
	[tiempooficinatecnica] [float] NULL,
	[fkregimeniva] [varchar](5) NULL,
	[fktransportista] [varchar](15) NULL,
	[tipocambio] [float] NULL,
	[fkpuertosfkpaises] [varchar](3) NULL,
	[fkpuertosid] [varchar](4) NULL,
	[unidadnegocio] [nvarchar](3) NULL,
	[referenciadocumento] [nvarchar](30) NULL,
	[fkbancosmandatos] [varchar](3) NULL,
	[cartacredito] [nvarchar](25) NULL,
	[vencimientocartacredito] [datetime] NULL,
	[contenedores] [int] NULL,
	[fkcuentastesoreria] [varchar](15) NULL,
	[numerodocumentoproveedor] [nvarchar](30) NULL,
	[fechadocumentoproveedor] [datetime] NULL,
	[fkclientesreserva] [varchar](15) NULL,
	[tipoalbaran] [int] NOT NULL,
	[fkmotivosdevolucion] [varchar](3) NULL,
	[nombretransportista] [nvarchar](40) NULL,
	[conductor] [nvarchar](20) NULL,
	[matricula] [nvarchar](12) NULL,
	[bultos] [int] NULL,
	[pesoneto] [float] NULL,
	[pesobruto] [float] NULL,
	[volumen] [float] NULL,
	[envio] [ntext] NULL,
	[fkoperarios] [varchar](15) NULL,
	[fkoperadortransporte] [varchar](15) NULL,
	[fkzonas] [varchar](3) NULL,
	[fkdireccionfacturacion] [int] NULL,
	[fkcriteriosagrupacion] [varchar](4) NULL,
	[tipoportes] [int] NULL,
	[costeportes] [float] NULL,
	[fkusuarioalta] [uniqueidentifier] NOT NULL CONSTRAINT [DF__Traspasosalmacen__fkusu__2724C5F0]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechaalta] [datetime] NOT NULL CONSTRAINT [DF__Traspasosalmacen__fecha__2818EA29]  DEFAULT (getdate()),
	[fkusuariomodificacion] [uniqueidentifier] NOT NULL CONSTRAINT [DF__Traspasosalmacen__fkusu__290D0E62]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[fechamodificacion] [datetime] NOT NULL CONSTRAINT [DF__Traspasosalmacen__fecha__2A01329B]  DEFAULT (getdate()),
	[fkcarpetas] [uniqueidentifier] NULL,
	[integridadreferenciaflag] [uniqueidentifier] NULL,
	[fkalmacendestino] [varchar](4) NULL,
 CONSTRAINT [PK_Traspasosalmacen_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TraspasosalmacenCostesadicionales]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TraspasosalmacenCostesadicionales](
	[empresa] [varchar](4) NOT NULL,
	[fktraspasosalmacen] [int] NOT NULL,
	[id] [int] NOT NULL,
	[tipodocumento] [int] NOT NULL,
	[referenciadocumento] [nvarchar](30) NULL,
	[importe] [float] NULL,
	[porcentaje] [float] NULL,
	[total] [float] NULL,
	[tipocoste] [int] NOT NULL,
	[tiporeparto] [int] NOT NULL,
	[notas] [ntext] NULL,
 CONSTRAINT [PK_TraspasosalmacenCostesadicionales] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fktraspasosalmacen] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TraspasosalmacenLin]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TraspasosalmacenLin](
	[empresa] [varchar](4) NOT NULL,
	[fktraspasosalmacen] [int] NOT NULL CONSTRAINT [DF__Traspasosalmacen__fkalb__2BE97B0D]  DEFAULT ((1)),
	[id] [int] NOT NULL,
	[fkarticulos] [varchar](15) NULL,
	[descripcion] [nvarchar](120) NULL,
	[lote] [nvarchar](12) NULL,
	[tabla] [int] NULL,
	[cantidad] [float] NULL,
	[cantidadpedida] [float] NULL,
	[largo] [float] NULL,
	[ancho] [float] NULL,
	[grueso] [float] NULL,
	[fkunidades] [varchar](2) NULL,
	[metros] [float] NULL,
	[precio] [float] NULL,
	[porcentajedescuento] [float] NULL,
	[importedescuento] [float] NULL,
	[fktiposiva] [varchar](3) NULL,
	[porcentajeiva] [float] NULL,
	[cuotaiva] [float] NULL,
	[porcentajerecargoequivalencia] [float] NULL,
	[cuotarecargoequivalencia] [float] NULL,
	[importe] [float] NULL,
	[importenetolinea] [float] NULL,
	[notas] [ntext] NULL,
	[documentoorigen] [nvarchar](15) NULL,
	[documentodestino] [nvarchar](15) NULL,
	[canal] [nvarchar](3) NULL,
	[precioanterior] [float] NULL,
	[revision] [nvarchar](1) NULL,
	[decimalesmonedas] [int] NULL,
	[decimalesmedidas] [int] NULL,
	[bundle] [nvarchar](2) NULL,
	[tblnum] [int] NULL,
	[contenedor] [nvarchar](12) NULL,
	[sello] [nvarchar](10) NULL,
	[caja] [int] NULL,
	[pesoneto] [float] NULL,
	[pesobruto] [float] NULL,
	[seccion] [nvarchar](4) NULL,
	[costeadicionalmaterial] [float] NULL,
	[costeadicionalportes] [float] NULL,
	[costeadicionalotro] [float] NULL,
	[costeacicionalvariable] [float] NULL,
	[orden] [int] NULL,
	[flagidentifier] [uniqueidentifier] NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
 CONSTRAINT [PK_TraspasosalmacenLin_1] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fktraspasosalmacen] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Unidades]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Unidades](
	[empresa] [varchar](4) NOT NULL,
	[id] [varchar](2) NOT NULL,
	[codigounidad] [nvarchar](2) NULL,
	[descripcion] [nvarchar](100) NULL,
	[descripcion2] [nvarchar](100) NULL,
	[textocorto] [nvarchar](10) NULL,
	[textocorto2] [nvarchar](10) NULL,
	[formula] [int] NOT NULL,
	[tiposmovimientostock] [int] NOT NULL,
	[tipostock] [int] NOT NULL,
	[tipototal] [int] NOT NULL,
	[decimalestotales] [int] NOT NULL,
 CONSTRAINT [PK_Unidades] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[id] [uniqueidentifier] NOT NULL,
	[usuario] [nvarchar](20) NULL,
	[password] [nvarchar](15) NULL,
	[puedecambiarempresa] [bit] NULL,
	[usuariomail] [nvarchar](100) NULL,
	[passwordmail] [nvarchar](100) NULL,
	[smtp] [nvarchar](400) NULL,
	[puerto] [int] NULL,
	[ssl] [bit] NULL,
	[email] [nvarchar](400) NULL,
	[firma] [ntext] NULL,
	[nombre] [nvarchar](200) NULL,
	[copiaremitente] [int] NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Usuariosactivos]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuariosactivos](
	[fkusuarios] [uniqueidentifier] NOT NULL,
	[idconexion] [uniqueidentifier] NOT NULL,
	[fechaconexion] [datetime] NOT NULL,
	[fechaultimaoperacion] [datetime] NOT NULL,
	[ip] [varchar](50) NULL,
 CONSTRAINT [PK_Usuariosactivos] PRIMARY KEY CLUSTERED 
(
	[fkusuarios] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[Familiamateriales]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Familiamateriales]
AS
SELECT     xml.value('(/TablasVariasGeneralModel/Valor/text())[1]', 'varchar(40)') AS Valor, xml.value('(/TablasVariasGeneralModel/Descripcion/text())[1]', 'varchar(40)') 
                      AS Descripcion, xml.value('(/TablasVariasGeneralModel/Descripcion2/text())[1]', 'varchar(40)') AS Descripcion2
FROM         dbo.TablasvariasLin
WHERE     (fkTablasvarias = '20')

GO
/****** Object:  View [dbo].[ListadoStockValorado]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ListadoStockValorado]
AS
select 
 s.fkarticulos as [Cod. Artículo],a.descripcion as [Artículo],fp.descripcion as [Familia],ml.descripcion as [Material],
fm.Descripcion as [Familia material],s.lote as [Lote],dbo._fn_enum_TipoAlmacenlote(s.tipoalmacenlote) as [Tipo de Lote],s.loteid as [Tabla],
s.cantidaddisponible as [Cant. Disponible],s.largo as [L],s.ancho as [A],s.grueso as [G],s.metros as [Metros],u.codigounidad as [UM],
u.decimalestotales as [_decimales]  


		,ISNULL(alcolin.importe,0) + ISNULL(TrEnLin.precio,0)	 AS PrecioNetoCompra
		,ISNULL(alcolin.importe,0) + ISNULL(TrEnLin.precio,0)	 +
		ISNULL(alcolin.costeacicionalvariable,0) + ISNULL(TrEnLin.costeacicionalvariable,0)	 +
		ISNULL(alcolin.costeadicionalmaterial,0) + ISNULL(TrEnLin.costeadicionalmaterial,0)	 +
		ISNULL(alcolin.costeadicionalotro,0) + ISNULL(TrEnLin.costeadicionalotro,0)	 +
		ISNULL(alcolin.costeadicionalportes,0) + ISNULL(TrEnLin.costeadicionalportes,0)	 AS CosteTotal
		,case ISNULL(alcolin.metros,0) + ISNULL(TrEnLin.metros,0)	-- AS metros
			when 0 then 0
			else ( ISNULL(alcolin.importe,0) + ISNULL(TrEnLin.precio,0))
					/
				   (ISNULL(alcolin.metros,0) + ISNULL(TrEnLin.metros,0)) 
		 end AS PrecioNetoCompraUM
		 


		 ,case ISNULL(alcolin.metros,0) + ISNULL(TrEnLin.metros,0)	-- AS metros
			when 0 then 0
			else ( ISNULL(alcolin.importe,0) + ISNULL(TrEnLin.precio,0)	 +
					ISNULL(alcolin.costeacicionalvariable,0) + ISNULL(TrEnLin.costeacicionalvariable,0)	 +
					ISNULL(alcolin.costeadicionalmaterial,0) + ISNULL(TrEnLin.costeadicionalmaterial,0)	 +
					ISNULL(alcolin.costeadicionalotro,0) + ISNULL(TrEnLin.costeadicionalotro,0)	 +
					ISNULL(alcolin.costeadicionalportes,0) + ISNULL(TrEnLin.costeadicionalportes,0)
    				)
					/
				   (ISNULL(alcolin.metros,0) + ISNULL(TrEnLin.metros,0)) 
		 end AS CosteTotalUM

		 		--,if (ISNULL(alcolin.metros,0) + ISNULL(TrEnLin.metros,0)) =0
		   


from stockactual as s  
  inner join articulos as a on a.id = s.fkarticulos and a.empresa= s.empresa  

  inner join familiasproductos as fp on fp.id = substring(s.fkarticulos, 0, 3) and fp.empresa= a.empresa  
  inner join unidades as u on u.id = fp.fkunidadesmedida and u.empresa=fp.empresa  
     left join materiales as ml on ml.id = substring(s.fkarticulos, 3, 3) and ml.empresa= a.empresa  
	 left join Familiamateriales  as fm on fm.valor=ml.fkfamiliamateriales 

 

 
  LEFT JOIN AlbaranesComprasLin AlCoLin on AlCoLin.empresa=s.empresa 
	and AlCoLin.lote=s.lote
	and AlCoLin.fkarticulos=s.fkarticulos and AlCoLin.tabla=s.loteid
  LEFT JOIN Transformacionesentradalin TrEnLin on TrEnLin.empresa=s.empresa 
	and TrEnLin.lote=s.lote
	and TrEnLin.fkarticulos=s.fkarticulos and TrEnLin.tabla=s.loteid


GO
/****** Object:  View [dbo].[Calificacioncomercial]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Calificacioncomercial]
AS
SELECT        xml.value('(/TablasVariasGeneralModel/Valor/text())[1]', 'varchar(40)') AS Valor, xml.value('(/TablasVariasGeneralModel/Descripcion/text())[1]', 'varchar(40)') AS Descripcion, 
                         xml.value('(/TablasVariasGeneralModel/Descripcion2/text())[1]', 'varchar(40)') AS Descripcion2
FROM            dbo.TablasvariasLin
WHERE        (fkTablasvarias = '710')

GO
/****** Object:  View [dbo].[Tipograno]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Tipograno]
AS
SELECT        xml.value('(/TablasVariasGeneralModel/Valor/text())[1]', 'varchar(40)') AS Valor, xml.value('(/TablasVariasGeneralModel/Descripcion/text())[1]', 'varchar(40)') AS Descripcion, 
                         xml.value('(/TablasVariasGeneralModel/Descripcion2/text())[1]', 'varchar(40)') AS Descripcion2
FROM            dbo.TablasvariasLin
WHERE        (fkTablasvarias = '700')

GO
/****** Object:  View [dbo].[Tonomaterial]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Tonomaterial]
AS
SELECT        xml.value('(/TablasVariasGeneralModel/Valor/text())[1]', 'varchar(40)') AS Valor, xml.value('(/TablasVariasGeneralModel/Descripcion/text())[1]', 'varchar(40)') AS Descripcion, 
                         xml.value('(/TablasVariasGeneralModel/Descripcion2/text())[1]', 'varchar(40)') AS Descripcion2
FROM            dbo.TablasvariasLin
WHERE        (fkTablasvarias = '705')

GO
/****** Object:  View [dbo].[Diariostock]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
use marfilestable
go
*/
CREATE VIEW [dbo].[Diariostock]
AS
SELECT        SUBSTRING(m.fkarticulos, 3, 3) AS Expr1, m.empresa, m.id, m.fecha, m.fkalmacenes, m.fkarticulos, m.referenciaproveedor, m.lote, m.loteid, m.tag, m.fkunidadesmedida, m.cantidad, m.largo, m.ancho, m.grueso, 
                         m.documentomovimiento, m.integridadreferencialflag, m.fkcontadorlote, m.fkusuarios, m.tipooperacion, m.fkalmaceneszona, m.fkcalificacioncomercial, m.fktipograno, m.fktonomaterial, m.fkincidenciasmaterial, m.fkvariedades, 
                         m.categoriamovimiento, a.descripcion AS Almacendescripcion, ISNULL(u.usuario, 'admin') AS Usuario, un.codigounidad AS Um, az.descripcion AS Almaceneszonas, cc.Descripcion AS Calificacioncomercial, 
                         tg.Descripcion AS Tipograno, tn.Descripcion AS Tonomaterial, inc.descripcion AS Incidencia, ml.descripcion AS Variedad, CAST(m.fecha AS time) AS Hora, art.descripcion AS Descripcionarticulos, 
                         ISNULL(m.documentomovimiento.value('(/*/Referencia/text())[1]', 'varchar(40)'), '') AS Documentoreferencia, m.tipoalmacenlote
FROM            dbo.Movimientosstock AS m INNER JOIN
                         dbo.Almacenes AS a ON a.empresa = m.empresa AND a.id = m.fkalmacenes INNER JOIN
                         dbo.Unidades AS un ON un.empresa = m.empresa AND un.id = m.fkunidadesmedida INNER JOIN
                         dbo.Articulos AS art ON art.empresa = m.empresa AND art.id = m.fkarticulos LEFT OUTER JOIN
                         dbo.Usuarios AS u ON m.fkusuarios = u.id LEFT OUTER JOIN
                         dbo.AlmacenesZona AS az ON az.empresa = m.empresa AND az.fkalmacenes = m.fkalmacenes AND az.id = m.fkalmaceneszona LEFT OUTER JOIN
                         dbo.Calificacioncomercial AS cc ON cc.Valor = m.fkcalificacioncomercial LEFT OUTER JOIN
                         dbo.Tipograno AS tg ON tg.Valor = m.fktipograno LEFT OUTER JOIN
                         dbo.Tonomaterial AS tn ON tn.Valor = m.fktonomaterial LEFT OUTER JOIN
                         dbo.Incidencias AS inc ON inc.empresa = m.empresa AND inc.id = m.fkincidenciasmaterial LEFT OUTER JOIN
                         dbo.MaterialesLin AS ml ON ml.empresa = m.empresa AND ml.codigovariedad = m.fkvariedades AND ml.fkmateriales = SUBSTRING(m.fkarticulos, 3, 3)

--EXEC sp_refreshview 'Diariostock'
GO
/****** Object:  View [dbo].[Canales]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Canales]
AS
SELECT     xml.value('(/TablasVariasGeneralModel/Valor/text())[1]', 'varchar(40)') AS Valor, xml.value('(/TablasVariasGeneralModel/Descripcion/text())[1]', 'varchar(40)') 
                      AS Descripcion, xml.value('(/TablasVariasGeneralModel/Descripcion2/text())[1]', 'varchar(40)') AS Descripcion2
FROM         dbo.TablasvariasLin
WHERE     (fkTablasvarias = '30')

GO
/****** Object:  View [dbo].[FamiliasClientes]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[FamiliasClientes]
AS
SELECT     xml.value('(/TablasVariasGeneralModel/Valor/text())[1]', 'varchar(40)') AS Valor, xml.value('(/TablasVariasGeneralModel/Descripcion/text())[1]', 'varchar(40)') 
                      AS Descripcion, xml.value('(/TablasVariasGeneralModel/Descripcion2/text())[1]', 'varchar(40)') AS Descripcion2
FROM         dbo.TablasvariasLin
WHERE     (fkTablasvarias = '1')

GO
/****** Object:  View [dbo].[Gruposmateriales]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Gruposmateriales]
AS
SELECT     xml.value('(/TablasVariasGeneralModel/Valor/text())[1]', 'varchar(40)') AS Valor, xml.value('(/TablasVariasGeneralModel/Descripcion/text())[1]', 'varchar(40)') 
                      AS Descripcion, xml.value('(/TablasVariasGeneralModel/Descripcion2/text())[1]', 'varchar(40)') AS Descripcion2
FROM         dbo.TablasvariasLin
WHERE     (fkTablasvarias = '21')

GO
/****** Object:  View [dbo].[Lotes]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[Lotes]
AS

SELECT	h.empresa, h.id, a.descripcionabreviada AS Articulo, h.fkarticulos AS Codarticulo, h.lote, h.loteid, 
		h.cantidaddisponible AS CantidadProduccion, h.largo AS LargoProduccion, h.ancho AS AnchoProduccion, 
        h.grueso AS GruesoProduccion, h.metros AS MetrosProduccion, u.codigounidad AS Unidades, 
		u.decimalestotales AS Decimales, k.referencia AS Kit, b.fkbundle AS Bundle, 
		h.codigoproveedor, h.fechaentrada, h.precioentrada, 
		h.codigodocumentoentrada, h.cantidadentrada, 
		h.largoentrada, h.anchoentrada, h.gruesoentrada,
		h.metrosentrada AS MetrosEntrada, h.netocompra, h.preciovaloracion,
		h.codigocliente, h.fechasalida, h.preciosalida, 
		h.codigodocumentosalida, h.cantidadsalida,
		h.largosalida, h.anchosalida, h.gruesosalida,
		h.metrossalida AS MetrosSalida,
		h.cantidadentrada - h.cantidadsalida AS CantidadDisponible, 
		h.metrosentrada - h.metrossalida AS MetrosDisponibles, 
		CASE WHEN h.cantidaddisponible > 0 THEN 1 ELSE 0 END AS EnStock, 
		h.tipoalmacenlote
						 
FROM	dbo.Stockhistorico AS h INNER JOIN
		dbo.Articulos AS a ON a.empresa = h.empresa AND a.id = h.fkarticulos INNER JOIN
        dbo.Unidades AS u ON u.empresa = h.empresa AND h.fkunidadesmedida = u.id LEFT OUTER JOIN
        dbo.KitLin AS kl ON kl.empresa = h.empresa AND kl.lote = h.lote AND kl.loteid = h.loteid LEFT OUTER JOIN
        dbo.Kit AS k ON k.empresa = kl.empresa AND k.id = kl.fkkit LEFT OUTER JOIN
        dbo.BundleLin AS b ON b.empresa = h.empresa AND b.lote = h.lote AND b.loteid = h.loteid
                       
GO
/****** Object:  View [dbo].[Paises]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Paises]
AS
SELECT     xml.value('(/TablasVariasPaisesModel/Valor/text())[1]', 'varchar(40)') AS Valor, xml.value('(/TablasVariasPaisesModel/Descripcion/text())[1]', 'varchar(40)') 
                      AS Descripcion, xml.value('(/TablasVariasPaisesModel/Descripcion2/text())[1]', 'varchar(40)') AS Descripcion2, 
                      xml.value('(/TablasVariasPaisesModel/CodigoIsoAlfa2/text())[1]', 'varchar(40)') AS CodigoIsoAlfa2, xml.value('(/TablasVariasPaisesModel/CodigoIsoAlfa3/text())[1]', 
                      'varchar(40)') AS CodigoIsoAlfa3, xml.value('(/TablasVariasPaisesModel/CodigoIsoNumerico/text())[1]', 'varchar(40)') AS CodigoIsoNumerico, 
                      xml.value('(/TablasVariasPaisesModel/NifEuropeo/text())[1]', 'varchar(40)') AS NifEuropeo
FROM         dbo.TablasvariasLin
WHERE     (fkTablasvarias = '3166')

GO
/****** Object:  View [dbo].[TiposAsientos]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE VIEW [dbo].[TiposAsientos]
AS
 SELECT     xml.value('(/TablasVariasTiposAsientosModel/Valor/text())[1]', 'varchar(40)') AS Valor, xml.value('(/TablasVariasTiposAsientosModel/Descripcion/text())[1]', 'varchar(40)') 
                      AS Descripcion
FROM         dbo.TablasvariasLin
WHERE     (fkTablasvarias = '72');
GO
/****** Object:  View [dbo].[Tiposempresas]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Tiposempresas]
AS
SELECT     xml.value('(/TablasVariasGeneralModel/Valor/text())[1]', 'varchar(40)') AS Valor, xml.value('(/TablasVariasGeneralModel/Descripcion/text())[1]', 'varchar(40)') 
                      AS Descripcion, xml.value('(/TablasVariasGeneralModel/Descripcion2/text())[1]', 'varchar(40)') AS Descripcion2
FROM         dbo.TablasvariasLin
WHERE     (fkTablasvarias = '2023')

GO
/****** Object:  View [dbo].[Unidadesnegocio]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Unidadesnegocio]
AS
SELECT     xml.value('(/TablasVariasGeneralModel/Valor/text())[1]', 'varchar(40)') AS Valor, xml.value('(/TablasVariasGeneralModel/Descripcion/text())[1]', 'varchar(40)') 
                      AS Descripcion, xml.value('(/TablasVariasGeneralModel/Descripcion2/text())[1]', 'varchar(40)') AS Descripcion2
FROM         dbo.TablasvariasLin
WHERE     (fkTablasvarias = '15')

GO
/****** Object:  View [dbo].[ZonasClientes]    Script Date: 15/05/2019 15:42:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ZonasClientes]
AS
SELECT     xml.value('(/TablasVariasGeneralModel/Valor/text())[1]', 'varchar(40)') AS Valor, xml.value('(/TablasVariasGeneralModel/Descripcion/text())[1]', 'varchar(40)') 
                      AS Descripcion, xml.value('(/TablasVariasGeneralModel/Descripcion2/text())[1]', 'varchar(40)') AS Descripcion2
FROM         dbo.TablasvariasLin
WHERE     (fkTablasvarias = '2')

GO
ALTER TABLE [dbo].[AlbaranesComprasCostesadicionales]  WITH CHECK ADD  CONSTRAINT [FK_AlbaranesComprasCostesadicionales_AlbaranesCompras] FOREIGN KEY([empresa], [fkalbaranescompras])
REFERENCES [dbo].[AlbaranesCompras] ([empresa], [id])
GO
ALTER TABLE [dbo].[AlbaranesComprasCostesadicionales] CHECK CONSTRAINT [FK_AlbaranesComprasCostesadicionales_AlbaranesCompras]
GO
ALTER TABLE [dbo].[AlbaranesComprasLin]  WITH CHECK ADD  CONSTRAINT [FK_AlbaranesComprasLin_AlbaranesCompras] FOREIGN KEY([empresa], [fkalbaranes])
REFERENCES [dbo].[AlbaranesCompras] ([empresa], [id])
GO
ALTER TABLE [dbo].[AlbaranesComprasLin] CHECK CONSTRAINT [FK_AlbaranesComprasLin_AlbaranesCompras]
GO
ALTER TABLE [dbo].[AlbaranesComprasTotales]  WITH CHECK ADD  CONSTRAINT [FK_AlbaranesComprasTotales_AlbaranesCompras] FOREIGN KEY([empresa], [fkalbaranes])
REFERENCES [dbo].[AlbaranesCompras] ([empresa], [id])
GO
ALTER TABLE [dbo].[AlbaranesComprasTotales] CHECK CONSTRAINT [FK_AlbaranesComprasTotales_AlbaranesCompras]
GO
ALTER TABLE [dbo].[AlbaranesLin]  WITH CHECK ADD  CONSTRAINT [FK_AlbaranesLin_Albaranes] FOREIGN KEY([empresa], [fkalbaranes])
REFERENCES [dbo].[Albaranes] ([empresa], [id])
GO
ALTER TABLE [dbo].[AlbaranesLin] CHECK CONSTRAINT [FK_AlbaranesLin_Albaranes]
GO
ALTER TABLE [dbo].[AlbaranesTotales]  WITH CHECK ADD  CONSTRAINT [FK_AlbaranesTotales_Albaranes] FOREIGN KEY([empresa], [fkalbaranes])
REFERENCES [dbo].[Albaranes] ([empresa], [id])
GO
ALTER TABLE [dbo].[AlbaranesTotales] CHECK CONSTRAINT [FK_AlbaranesTotales_Albaranes]
GO
ALTER TABLE [dbo].[AlmacenesZona]  WITH CHECK ADD  CONSTRAINT [FK_AlmacenesZona_Almacenes] FOREIGN KEY([empresa], [fkalmacenes])
REFERENCES [dbo].[Almacenes] ([empresa], [id])
GO
ALTER TABLE [dbo].[AlmacenesZona] CHECK CONSTRAINT [FK_AlmacenesZona_Almacenes]
GO
ALTER TABLE [dbo].[AppPermisosRoles]  WITH CHECK ADD  CONSTRAINT [FK_AppPermisosRoles_AppPermisos] FOREIGN KEY([fkAppPermisos])
REFERENCES [dbo].[AppPermisos] ([id])
GO
ALTER TABLE [dbo].[AppPermisosRoles] CHECK CONSTRAINT [FK_AppPermisosRoles_AppPermisos]
GO
ALTER TABLE [dbo].[AppPermisosRoles]  WITH CHECK ADD  CONSTRAINT [FK_AppPermisosRoles_Roles] FOREIGN KEY([fkRoles])
REFERENCES [dbo].[Roles] ([id])
GO
ALTER TABLE [dbo].[AppPermisosRoles] CHECK CONSTRAINT [FK_AppPermisosRoles_Roles]
GO
ALTER TABLE [dbo].[AppPermisosUsuarios]  WITH CHECK ADD  CONSTRAINT [FK_AppPermisosUsuarios_AppPermisos] FOREIGN KEY([fkAppPermisos])
REFERENCES [dbo].[AppPermisos] ([id])
GO
ALTER TABLE [dbo].[AppPermisosUsuarios] CHECK CONSTRAINT [FK_AppPermisosUsuarios_AppPermisos]
GO
ALTER TABLE [dbo].[AppPermisosUsuarios]  WITH CHECK ADD  CONSTRAINT [FK_AppPermisosUsuarios_Usuarios] FOREIGN KEY([fkUsuarios])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[AppPermisosUsuarios] CHECK CONSTRAINT [FK_AppPermisosUsuarios_Usuarios]
GO
ALTER TABLE [dbo].[BundleLin]  WITH CHECK ADD  CONSTRAINT [FK_BundleLin_Bundle] FOREIGN KEY([empresa], [fkbundlelote], [fkbundle])
REFERENCES [dbo].[Bundle] ([empresa], [lote], [id])
GO
ALTER TABLE [dbo].[BundleLin] CHECK CONSTRAINT [FK_BundleLin_Bundle]
GO
ALTER TABLE [dbo].[CaracteristicasLin]  WITH CHECK ADD  CONSTRAINT [FK_CaracteristicasLin_Caracteristicas] FOREIGN KEY([empresa], [fkcaracteristicas])
REFERENCES [dbo].[Caracteristicas] ([empresa], [id])
GO
ALTER TABLE [dbo].[CaracteristicasLin] CHECK CONSTRAINT [FK_CaracteristicasLin_Caracteristicas]
GO
ALTER TABLE [dbo].[ContadoresContabilidadLin]  WITH CHECK ADD  CONSTRAINT [FK_ContadoresContabilidadLin_ContadoresContabilidad] FOREIGN KEY([empresa], [fkcontadores])
REFERENCES [dbo].[ContadoresContabilidad] ([empresa], [id])
GO
ALTER TABLE [dbo].[ContadoresContabilidadLin] CHECK CONSTRAINT [FK_ContadoresContabilidadLin_ContadoresContabilidad]
GO
ALTER TABLE [dbo].[ContadoresLin]  WITH CHECK ADD  CONSTRAINT [FK_ContadoresLin_Contadores] FOREIGN KEY([empresa], [fkcontadores])
REFERENCES [dbo].[Contadores] ([empresa], [id])
GO
ALTER TABLE [dbo].[ContadoresLin] CHECK CONSTRAINT [FK_ContadoresLin_Contadores]
GO
ALTER TABLE [dbo].[ContadoresLotesLin]  WITH CHECK ADD  CONSTRAINT [FK_ContadoresLotesLin_ContadoresLotes] FOREIGN KEY([empresa], [fkcontadores])
REFERENCES [dbo].[ContadoresLotes] ([empresa], [id])
GO
ALTER TABLE [dbo].[ContadoresLotesLin] CHECK CONSTRAINT [FK_ContadoresLotesLin_ContadoresLotes]
GO
ALTER TABLE [dbo].[CostesVariablesPeriodo]  WITH CHECK ADD  CONSTRAINT [fk_costes_variables] FOREIGN KEY([empresa], [fkejercicio])
REFERENCES [dbo].[Ejercicios] ([empresa], [id])
GO
ALTER TABLE [dbo].[CostesVariablesPeriodo] CHECK CONSTRAINT [fk_costes_variables]
GO
ALTER TABLE [dbo].[CostesVariablesPeriodoLin]  WITH CHECK ADD  CONSTRAINT [fk_costes_variables_lin] FOREIGN KEY([empresa], [fkejercicio], [fkcostes])
REFERENCES [dbo].[CostesVariablesPeriodo] ([empresa], [fkejercicio], [id])
GO
ALTER TABLE [dbo].[CostesVariablesPeriodoLin] CHECK CONSTRAINT [fk_costes_variables_lin]
GO
ALTER TABLE [dbo].[CriteriosagrupacionLin]  WITH CHECK ADD  CONSTRAINT [FK_CriteriosagrupacionLin_Criteriosagrupacion] FOREIGN KEY([fkcriteriosagrupacion])
REFERENCES [dbo].[Criteriosagrupacion] ([id])
GO
ALTER TABLE [dbo].[CriteriosagrupacionLin] CHECK CONSTRAINT [FK_CriteriosagrupacionLin_Criteriosagrupacion]
GO
ALTER TABLE [dbo].[FacturasComprasLin]  WITH CHECK ADD  CONSTRAINT [FK_FacturasComprasLin_FacturasCompras] FOREIGN KEY([empresa], [fkfacturascompras])
REFERENCES [dbo].[FacturasCompras] ([empresa], [id])
GO
ALTER TABLE [dbo].[FacturasComprasLin] CHECK CONSTRAINT [FK_FacturasComprasLin_FacturasCompras]
GO
ALTER TABLE [dbo].[FacturasComprasTotales]  WITH CHECK ADD  CONSTRAINT [FK_FacturasComprasTotales_FacturasCompras] FOREIGN KEY([empresa], [fkfacturascompras])
REFERENCES [dbo].[FacturasCompras] ([empresa], [id])
GO
ALTER TABLE [dbo].[FacturasComprasTotales] CHECK CONSTRAINT [FK_FacturasComprasTotales_FacturasCompras]
GO
ALTER TABLE [dbo].[FacturasComprasVencimientos]  WITH CHECK ADD  CONSTRAINT [FK_FacturasComprasVencimientos_FacturasCompras] FOREIGN KEY([empresa], [fkfacturascompras])
REFERENCES [dbo].[FacturasCompras] ([empresa], [id])
GO
ALTER TABLE [dbo].[FacturasComprasVencimientos] CHECK CONSTRAINT [FK_FacturasComprasVencimientos_FacturasCompras]
GO
ALTER TABLE [dbo].[FacturasLin]  WITH CHECK ADD  CONSTRAINT [FK_FacturasLin_Facturas] FOREIGN KEY([empresa], [fkfacturas])
REFERENCES [dbo].[Facturas] ([empresa], [id])
GO
ALTER TABLE [dbo].[FacturasLin] CHECK CONSTRAINT [FK_FacturasLin_Facturas]
GO
ALTER TABLE [dbo].[FacturasTotales]  WITH CHECK ADD  CONSTRAINT [FK_FacturasTotales_Facturas] FOREIGN KEY([empresa], [fkfacturas])
REFERENCES [dbo].[Facturas] ([empresa], [id])
GO
ALTER TABLE [dbo].[FacturasTotales] CHECK CONSTRAINT [FK_FacturasTotales_Facturas]
GO
ALTER TABLE [dbo].[FacturasVencimientos]  WITH CHECK ADD  CONSTRAINT [FK_FacturasVencimientos_Facturas] FOREIGN KEY([empresa], [fkfacturas])
REFERENCES [dbo].[Facturas] ([empresa], [id])
GO
ALTER TABLE [dbo].[FacturasVencimientos] CHECK CONSTRAINT [FK_FacturasVencimientos_Facturas]
GO
ALTER TABLE [dbo].[Ficheros]  WITH CHECK ADD  CONSTRAINT [FK_Ficheros_Carpetas] FOREIGN KEY([empresa], [fkcarpetas])
REFERENCES [dbo].[Carpetas] ([empresa], [id])
GO
ALTER TABLE [dbo].[Ficheros] CHECK CONSTRAINT [FK_Ficheros_Carpetas]
GO
ALTER TABLE [dbo].[FormasPagoLin]  WITH CHECK ADD  CONSTRAINT [FK_FormasPagoLin_FormasPago] FOREIGN KEY([fkFormasPago])
REFERENCES [dbo].[FormasPago] ([id])
GO
ALTER TABLE [dbo].[FormasPagoLin] CHECK CONSTRAINT [FK_FormasPagoLin_FormasPago]
GO
ALTER TABLE [dbo].[GruposIvaLin]  WITH CHECK ADD  CONSTRAINT [FK_GruposIvaLin_GruposIva] FOREIGN KEY([empresa], [fkgruposiva])
REFERENCES [dbo].[GruposIva] ([empresa], [id])
GO
ALTER TABLE [dbo].[GruposIvaLin] CHECK CONSTRAINT [FK_GruposIvaLin_GruposIva]
GO
ALTER TABLE [dbo].[GuiascontablesLin]  WITH CHECK ADD  CONSTRAINT [FK_GuiascontablesLin_Guiascontables] FOREIGN KEY([empresa], [fkguiascontables])
REFERENCES [dbo].[Guiascontables] ([empresa], [id])
GO
ALTER TABLE [dbo].[GuiascontablesLin] CHECK CONSTRAINT [FK_GuiascontablesLin_Guiascontables]
GO
ALTER TABLE [dbo].[InventariosLin]  WITH CHECK ADD  CONSTRAINT [FK_InventariosLin_Inventarios] FOREIGN KEY([empresa], [fkinventarios])
REFERENCES [dbo].[Inventarios] ([empresa], [id])
GO
ALTER TABLE [dbo].[InventariosLin] CHECK CONSTRAINT [FK_InventariosLin_Inventarios]
GO
ALTER TABLE [dbo].[KitLin]  WITH CHECK ADD  CONSTRAINT [FK_KitLin_Kit] FOREIGN KEY([empresa], [fkkit])
REFERENCES [dbo].[Kit] ([empresa], [id])
GO
ALTER TABLE [dbo].[KitLin] CHECK CONSTRAINT [FK_KitLin_Kit]
GO
ALTER TABLE [dbo].[Maes]  WITH CHECK ADD  CONSTRAINT [FK_Maes_Cuentas] FOREIGN KEY([empresa], [fkcuentas])
REFERENCES [dbo].[Cuentas] ([empresa], [id])
GO
ALTER TABLE [dbo].[Maes] CHECK CONSTRAINT [FK_Maes_Cuentas]
GO
ALTER TABLE [dbo].[MaterialesLin]  WITH CHECK ADD  CONSTRAINT [FK_MaterialesLin_Materiales] FOREIGN KEY([empresa], [fkmateriales])
REFERENCES [dbo].[Materiales] ([empresa], [id])
GO
ALTER TABLE [dbo].[MaterialesLin] CHECK CONSTRAINT [FK_MaterialesLin_Materiales]
GO
ALTER TABLE [dbo].[MonedasLog]  WITH CHECK ADD  CONSTRAINT [FK_MonedasLog_Monedas] FOREIGN KEY([fkMonedas])
REFERENCES [dbo].[Monedas] ([id])
GO
ALTER TABLE [dbo].[MonedasLog] CHECK CONSTRAINT [FK_MonedasLog_Monedas]
GO
ALTER TABLE [dbo].[MovsLin]  WITH CHECK ADD  CONSTRAINT [FK_MovsLin_Movs] FOREIGN KEY([empresa], [fkmovs])
REFERENCES [dbo].[Movs] ([empresa], [id])
GO
ALTER TABLE [dbo].[MovsLin] CHECK CONSTRAINT [FK_MovsLin_Movs]
GO
ALTER TABLE [dbo].[PedidosComprasLin]  WITH CHECK ADD  CONSTRAINT [FK_PedidosComprasLin_PedidosCompras] FOREIGN KEY([empresa], [fkpedidoscompras])
REFERENCES [dbo].[PedidosCompras] ([empresa], [id])
GO
ALTER TABLE [dbo].[PedidosComprasLin] CHECK CONSTRAINT [FK_PedidosComprasLin_PedidosCompras]
GO
ALTER TABLE [dbo].[PedidosComprasTotales]  WITH CHECK ADD  CONSTRAINT [FK_PedidosComprasTotales_PedidosCompras] FOREIGN KEY([empresa], [fkpedidoscompras])
REFERENCES [dbo].[PedidosCompras] ([empresa], [id])
GO
ALTER TABLE [dbo].[PedidosComprasTotales] CHECK CONSTRAINT [FK_PedidosComprasTotales_PedidosCompras]
GO
ALTER TABLE [dbo].[PedidosCostesFabricacion]  WITH CHECK ADD FOREIGN KEY([empresa], [fkpedido])
REFERENCES [dbo].[Pedidos] ([empresa], [id])
GO
ALTER TABLE [dbo].[PedidosLin]  WITH CHECK ADD  CONSTRAINT [FK_PedidosLin_Pedidos] FOREIGN KEY([empresa], [fkpedidos])
REFERENCES [dbo].[Pedidos] ([empresa], [id])
GO
ALTER TABLE [dbo].[PedidosLin] CHECK CONSTRAINT [FK_PedidosLin_Pedidos]
GO
ALTER TABLE [dbo].[PedidosTotales]  WITH CHECK ADD  CONSTRAINT [FK_PedidosTotales_Pedidos] FOREIGN KEY([empresa], [fkpedidos])
REFERENCES [dbo].[Pedidos] ([empresa], [id])
GO
ALTER TABLE [dbo].[PedidosTotales] CHECK CONSTRAINT [FK_PedidosTotales_Pedidos]
GO
ALTER TABLE [dbo].[Presupuestos]  WITH CHECK ADD  CONSTRAINT [FK_Presupuestos_Presupuestos] FOREIGN KEY([empresa], [id])
REFERENCES [dbo].[Presupuestos] ([empresa], [id])
GO
ALTER TABLE [dbo].[Presupuestos] CHECK CONSTRAINT [FK_Presupuestos_Presupuestos]
GO
ALTER TABLE [dbo].[PresupuestosCompras]  WITH CHECK ADD  CONSTRAINT [FK_PresupuestosCompras_PresupuestosCompras] FOREIGN KEY([empresa], [id])
REFERENCES [dbo].[PresupuestosCompras] ([empresa], [id])
GO
ALTER TABLE [dbo].[PresupuestosCompras] CHECK CONSTRAINT [FK_PresupuestosCompras_PresupuestosCompras]
GO
ALTER TABLE [dbo].[PresupuestosComprasLin]  WITH CHECK ADD  CONSTRAINT [FK_PresupuestosComprasLin_PresupuestosCompras] FOREIGN KEY([empresa], [fkpresupuestoscompras])
REFERENCES [dbo].[PresupuestosCompras] ([empresa], [id])
GO
ALTER TABLE [dbo].[PresupuestosComprasLin] CHECK CONSTRAINT [FK_PresupuestosComprasLin_PresupuestosCompras]
GO
ALTER TABLE [dbo].[PresupuestosComprasTotales]  WITH CHECK ADD  CONSTRAINT [FK_PresupuestosComprasTotales_PresupuestosCompras] FOREIGN KEY([empresa], [fkpresupuestoscompras])
REFERENCES [dbo].[PresupuestosCompras] ([empresa], [id])
GO
ALTER TABLE [dbo].[PresupuestosComprasTotales] CHECK CONSTRAINT [FK_PresupuestosComprasTotales_PresupuestosCompras]
GO
ALTER TABLE [dbo].[PresupuestosLin]  WITH CHECK ADD  CONSTRAINT [FK_PresupuestosLin_Presupuestos] FOREIGN KEY([empresa], [fkpresupuestos])
REFERENCES [dbo].[Presupuestos] ([empresa], [id])
GO
ALTER TABLE [dbo].[PresupuestosLin] CHECK CONSTRAINT [FK_PresupuestosLin_Presupuestos]
GO
ALTER TABLE [dbo].[PresupuestosTotales]  WITH CHECK ADD  CONSTRAINT [FK_PresupuestosTotales_Presupuestos] FOREIGN KEY([empresa], [fkpresupuestos])
REFERENCES [dbo].[Presupuestos] ([empresa], [id])
GO
ALTER TABLE [dbo].[PresupuestosTotales] CHECK CONSTRAINT [FK_PresupuestosTotales_Presupuestos]
GO
ALTER TABLE [dbo].[ReservasstockLin]  WITH CHECK ADD  CONSTRAINT [FK_ReservasstockLin_Reservasstock] FOREIGN KEY([empresa], [fkreservasstock])
REFERENCES [dbo].[Reservasstock] ([empresa], [id])
GO
ALTER TABLE [dbo].[ReservasstockLin] CHECK CONSTRAINT [FK_ReservasstockLin_Reservasstock]
GO
ALTER TABLE [dbo].[ReservasstockTotales]  WITH CHECK ADD  CONSTRAINT [FK_ReservasstockTotales_Reservasstock] FOREIGN KEY([empresa], [fkreservasstock])
REFERENCES [dbo].[Reservasstock] ([empresa], [id])
GO
ALTER TABLE [dbo].[ReservasstockTotales] CHECK CONSTRAINT [FK_ReservasstockTotales_Reservasstock]
GO
ALTER TABLE [dbo].[RolesUsuarios]  WITH CHECK ADD  CONSTRAINT [FK_RolesUsuarios_Roles] FOREIGN KEY([FkRoles])
REFERENCES [dbo].[Roles] ([id])
GO
ALTER TABLE [dbo].[RolesUsuarios] CHECK CONSTRAINT [FK_RolesUsuarios_Roles]
GO
ALTER TABLE [dbo].[RolesUsuarios]  WITH CHECK ADD  CONSTRAINT [FK_RolesUsuarios_Usuarios] FOREIGN KEY([FkUsuarios])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[RolesUsuarios] CHECK CONSTRAINT [FK_RolesUsuarios_Usuarios]
GO
ALTER TABLE [dbo].[TablasvariasLin]  WITH CHECK ADD  CONSTRAINT [FK_TablasvariasLin_Tablasvarias] FOREIGN KEY([fkTablasvarias])
REFERENCES [dbo].[Tablasvarias] ([id])
GO
ALTER TABLE [dbo].[TablasvariasLin] CHECK CONSTRAINT [FK_TablasvariasLin_Tablasvarias]
GO
ALTER TABLE [dbo].[TareasLin]  WITH CHECK ADD FOREIGN KEY([empresa], [fktareas])
REFERENCES [dbo].[Tareas] ([empresa], [id])
GO
ALTER TABLE [dbo].[TarifasLin]  WITH CHECK ADD  CONSTRAINT [FK_TarifasLin_TarifasLin] FOREIGN KEY([empresa], [fktarifas])
REFERENCES [dbo].[Tarifas] ([empresa], [id])
GO
ALTER TABLE [dbo].[TarifasLin] CHECK CONSTRAINT [FK_TarifasLin_TarifasLin]
GO
ALTER TABLE [dbo].[TiposcuentasLin]  WITH CHECK ADD  CONSTRAINT [FK_GestioncuentasLin_Gestioncuentas] FOREIGN KEY([empresa], [fkTiposcuentas])
REFERENCES [dbo].[Tiposcuentas] ([empresa], [tipos])
GO
ALTER TABLE [dbo].[TiposcuentasLin] CHECK CONSTRAINT [FK_GestioncuentasLin_Gestioncuentas]
GO
ALTER TABLE [dbo].[Transformacionescostesadicionales]  WITH CHECK ADD  CONSTRAINT [FK_Transformacionescostesadicionales_Transformaciones] FOREIGN KEY([empresa], [fktransformaciones])
REFERENCES [dbo].[Transformaciones] ([empresa], [id])
GO
ALTER TABLE [dbo].[Transformacionescostesadicionales] CHECK CONSTRAINT [FK_Transformacionescostesadicionales_Transformaciones]
GO
ALTER TABLE [dbo].[Transformacionesentradalin]  WITH CHECK ADD  CONSTRAINT [FK_Transformacionesentradalin_Transformaciones] FOREIGN KEY([empresa], [fktransformaciones])
REFERENCES [dbo].[Transformaciones] ([empresa], [id])
GO
ALTER TABLE [dbo].[Transformacionesentradalin] CHECK CONSTRAINT [FK_Transformacionesentradalin_Transformaciones]
GO
ALTER TABLE [dbo].[Transformacioneslotescostesadicionales]  WITH CHECK ADD  CONSTRAINT [FK_Transformacioneslotescostesadicionales_Transformacioneslotes] FOREIGN KEY([empresa], [fkTransformacioneslotes])
REFERENCES [dbo].[Transformacioneslotes] ([empresa], [id])
GO
ALTER TABLE [dbo].[Transformacioneslotescostesadicionales] CHECK CONSTRAINT [FK_Transformacioneslotescostesadicionales_Transformacioneslotes]
GO
ALTER TABLE [dbo].[Transformacionesloteslin]  WITH CHECK ADD  CONSTRAINT [FK_Transformacionesloteslin_Transformacioneslotes] FOREIGN KEY([empresa], [fkTransformacioneslotes])
REFERENCES [dbo].[Transformacioneslotes] ([empresa], [id])
GO
ALTER TABLE [dbo].[Transformacionesloteslin] CHECK CONSTRAINT [FK_Transformacionesloteslin_Transformacioneslotes]
GO
ALTER TABLE [dbo].[Transformacionessalidalin]  WITH CHECK ADD  CONSTRAINT [FK_Transformacionessalidalin_Transformacionessalidalin] FOREIGN KEY([empresa], [fktransformaciones])
REFERENCES [dbo].[Transformaciones] ([empresa], [id])
GO
ALTER TABLE [dbo].[Transformacionessalidalin] CHECK CONSTRAINT [FK_Transformacionessalidalin_Transformacionessalidalin]
GO
ALTER TABLE [dbo].[TraspasosalmacenCostesadicionales]  WITH CHECK ADD  CONSTRAINT [FK_TraspasosalmacenCostesadicionales_Traspasosalmacen] FOREIGN KEY([empresa], [fktraspasosalmacen])
REFERENCES [dbo].[Traspasosalmacen] ([empresa], [id])
GO
ALTER TABLE [dbo].[TraspasosalmacenCostesadicionales] CHECK CONSTRAINT [FK_TraspasosalmacenCostesadicionales_Traspasosalmacen]
GO
ALTER TABLE [dbo].[TraspasosalmacenLin]  WITH CHECK ADD  CONSTRAINT [FK_TraspasosalmacenLin_Traspasosalmacen] FOREIGN KEY([empresa], [fktraspasosalmacen])
REFERENCES [dbo].[Traspasosalmacen] ([empresa], [id])
GO
ALTER TABLE [dbo].[TraspasosalmacenLin] CHECK CONSTRAINT [FK_TraspasosalmacenLin_Traspasosalmacen]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TablasvariasLin"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Calificacioncomercial'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Calificacioncomercial'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TablasvariasLin"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 99
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Canales'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Canales'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "m"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 256
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 294
               Bottom = 136
               Right = 503
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "un"
            Begin Extent = 
               Top = 6
               Left = 541
               Bottom = 136
               Right = 750
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "art"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 288
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "u"
            Begin Extent = 
               Top = 138
               Left = 326
               Bottom = 268
               Right = 536
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "az"
            Begin Extent = 
               Top = 138
               Left = 574
               Bottom = 268
               Right = 783
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cc"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 383
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         En' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Diariostock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'd
         Begin Table = "tg"
            Begin Extent = 
               Top = 270
               Left = 285
               Bottom = 383
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tn"
            Begin Extent = 
               Top = 270
               Left = 532
               Bottom = 383
               Right = 741
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "inc"
            Begin Extent = 
               Top = 384
               Left = 38
               Bottom = 514
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ml"
            Begin Extent = 
               Top = 384
               Left = 285
               Bottom = 514
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Diariostock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Diariostock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TablasvariasLin"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 99
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Familiamateriales'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Familiamateriales'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TablasvariasLin"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 99
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'FamiliasClientes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'FamiliasClientes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TablasvariasLin"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 99
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Gruposmateriales'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Gruposmateriales'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TablasvariasLin"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 99
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 2340
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Paises'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Paises'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TablasvariasLin"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Tipograno'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Tipograno'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TablasvariasLin"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 99
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Tiposempresas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Tiposempresas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TablasvariasLin"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Tonomaterial'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Tonomaterial'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TablasvariasLin"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 99
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Unidadesnegocio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Unidadesnegocio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TablasvariasLin"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 99
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ZonasClientes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ZonasClientes'
GO
