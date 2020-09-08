//Raimundo Fenoll

app.controller('ReclamaralbaranCtrl', ['$scope', '$rootScope', '$http', '$interval', 'uiGridConstants', '$timeout', function ($scope, $rootScope, $http, $interval, $uiGridConstants, $timeout) {

    //configuracion Control
    $scope.campoIdentificador = "";
    $scope.IdComponenteasociado = "";
    $scope.IdFormulariomodal = "";
    $scope.Url = "";
    $scope.Titulo = "";
    $scope.Cuenta = "";
    $scope.Cliente = "";
    $scope.Articulo = "";
    $scope.Descripcion = "";
    $scope.values = [];
    $scope.columns = [];
    $scope.cantidadesPermitidas = [];
    $scope.ErrorCantidadesADevolver = "";
    $scope.articulos = [];
    $scope.articulosduplicados = [];
    $scope.UrlAlbaranes;
    $scope.Id;
    $scope.urlObtenerMedida;
    $scope.urlReclamar;
    $scope.urlValidar;

    $scope.init = function (urlAlbaranes, urlObtenerMedida, urlReclamar, urlValidar) {
        $scope.UrlAlbaranes = urlAlbaranes;
        $scope.urlObtenerMedida = urlObtenerMedida;
        $scope.urlReclamar = urlReclamar;
        $scope.urlValidar = urlValidar;
    }

    eventAggregator.RegisterEvent("_lanzarbusquedareclamaralbaran", function (data) {

        $('#reclamaralbaran').modal('show');
        $scope.values = data.Values;
        $scope.columns = data.Columns;
        $scope.Url = data.Url;
        $scope.Idalbaran = data.Idalbaran;
        $scope.load(data.campoIdentificador, data.IdComponenteasociado, "reclamaralbaran", data.Url, data.Titulo);
    });



    //start grid especificas
    $scope.gridOptions = { enableRowSelection: true, enableRowHeaderSelection: true, enableCellEdit: true };
    $scope.gridOptions.multiSelect = true;
    $scope.gridOptions.modifierKeysToMultiSelect = true;
    $scope.gridOptions.noUnselect = false;
    $scope.gridOptions.selectionRowHeaderWidth = 35;
    $scope.gridOptions.enableFiltering = true;

    $scope.gridOptions.onRegisterApi = function (gridApi) {
        $scope.gridApi = gridApi;
        gridApi.selection.on.rowSelectionChanged($scope, function (row) {
            $scope.selected = $scope.gridApi.selection.getSelectedCount();

        });
        gridApi.selection.on.rowSelectionChangedBatch($scope, function (rows) {
            $scope.selected = $scope.gridApi.selection.getSelectedCount();
        });
    };

    $scope.data = [];
    $scope.selected = 0;
    $scope.params = "";

    //Cancelar pantallas
    $scope.cancelarlineas = function () {
        $('#reclamaralbaran').modal('hide');
    }

    $scope.cancelarduplicadas = function () {
        $('#reclamaralbaransiguiente').modal('hide');
    }

    $scope.anterior = function () {
        $('#reclamaralbaransiguiente').modal('hide');
        $('#reclamaralbaran').modal('show');
    }

    $scope.reclamar = function () {

        var lineas = JSON.stringify($scope.articulosduplicados);
        $('#reclamaralbaransiguiente').modal('hide');

        $("#reclamacionform [name='id']").val($scope.Idalbaran);
        $("#reclamacionform [name='lineas']").val(lineas);
        $("#reclamacionform").submit();
        $('#reclamaralbaransiguiente').modal('hide');
    }

    //Siguiente
    $scope.siguiente = function () {

        $scope.articulos = $scope.gridApi.selection.getSelectedRows();
        var lineas = JSON.stringify($scope.articulos);

        $('#reclamaralbaran').modal('hide');
        $('#reclamaralbaransiguiente').modal('show');

        $.post($scope.UrlAlbaranes, {
            id: $scope.Idalbaran, lineas: lineas
        }).success(function (data) {
            $scope.articulosduplicados = JSON.parse(data).Lineas;
            $scope.articulosduplicados.forEach(function (articulo) {
                if (articulo.Cantidad < 0) {
                    articulo["noeditable"] = true; //Lineas negativas
                }
                articulo["showEdit"] = true;

                $http({
                    url: $scope.urlObtenerMedida, method: "GET", params: { idArticulo: articulo.Fkarticulos }
                }).success(function (data) {
                    var unidad = data.unidad;
                    articulo["unidad"] = unidad;

                    //Precio = Precio * cantidad * Metros (largo * ancho)
                    if (unidad == "02") {

                        articulo["permitelargo"] = true;
                        articulo["permiteancho"] = true;
                        articulo["permitegrueso"] = false;
                    }

                    //Precio = Precio * cantidad * Metros (largo * ancho * grueso)
                    else if (unidad == "03") {

                        articulo["permitelargo"] = true;
                        articulo["permiteancho"] = true;
                        articulo["permitegrueso"] = true;
                    }

                    //Precio = Precio * cantidad * (largo)
                    else if (unidad == "05") {

                        articulo["permitelargo"] = true;
                        articulo["permiteancho"] = false;
                        articulo["permitegrueso"] = false;
                    }

                    else {
                        bootbox.alert("no se ha especificado la medida para el articulo " + articulo.IdComponente);
                    }

                    //$scope.$apply();

                }).error(function (error) {
                    console.log("error call ");
                });
            })
            $scope.$apply();

        }).error(function (jqXHR, textStatus, errorThrown) {
            messagesService.show(TipoMensaje.Error, "Ups!", "Parece que ocurrió un error al importar las líneas");
        });
    };


    //Editar articulo
    $scope.toggleEdit = function (articulo) {

        articulo.showEdit = articulo.showEdit ? false : true;
        //Antes de modificar largo, ancho y grueso tenemos que guardarnos los originales
        if (articulo.showEdit == false) {
            articulo["largooriginal"] = articulo.SLargo.replace(",", ".");
            articulo["anchooriginal"] = articulo.SAncho.replace(",", ".");
            articulo["gruesooriginal"] = articulo.SGrueso.replace(",", ".");
            articulo["metrosoriginal"] = articulo.SMetros.replace(",", ".");
            articulo["preciooriginal"] = articulo.SPrecio.replace(",", ".");
            articulo["descuentooriginal"] = articulo.Porcentajedescuento;
            articulo["importeoriginal"] = articulo.SImporte.replace(",", ".");
        }

        //Validar dimensiones articulo cuando se presione enter o se guarde
        if (articulo.showEdit == true) {
            $scope.ValidarYRecalcular(articulo);
        }
    }

    $scope.MedidasAnteriores = function (articulo) {
        articulo.SLargo = articulo["largooriginal"];
        articulo.SAncho = articulo["anchooriginal"];
        articulo.SGrueso = articulo["gruesooriginal"];
        articulo.SMetros = articulo["metrosoriginal"];
        articulo.SPrecio = articulo["preciooriginal"];
        articulo.Porcentajedescuento = articulo["descuentooriginal"];
        articulo.SImporte = articulo["importeoriginal"];

        articulo.Largo = articulo.SLargo;
        articulo.Ancho = articulo.SAncho;
        articulo.Grueso = articulo.SGrueso;
        articulo.Metros = articulo.SMetros;
        articulo.Precio = articulo.SPrecio;
        articulo.Importe = articulo.SImporte;

        $scope.$apply();
    }

    $scope.ValidarYRecalcular = function (articulo) {

        var familiaArticulo = articulo.Fkarticulos.substring(0, 2);

        $http({
            url: $scope.urlValidar, method: "GET", params: { familia: familiaArticulo }
        }).success(function (data) {

            var familia = JSON.parse(data);
            if (familia.Minlargo > articulo.SLargo || familia.Maxlargo < articulo.SLargo) {  
                bootbox.alert({
                    title: "Largo fuera de rango",
                    message: "El largo debe tener un mínimo de " + familia.Minlargo + " m y un máximo de " + familia.Maxlargo + " m",
                    size: 'large'
                });
                $scope.MedidasAnteriores(articulo);
            }
            if (familia.Minancho > articulo.SAncho || familia.Maxancho < articulo.SAncho) {             
                bootbox.alert({
                    title: "Ancho fuera de rango",
                    message: "El ancho debe tener un mínimo de " + familia.Minancho + " m y un máximo de " + familia.Maxancho + " m",
                    size: 'large'
                });
                $scope.MedidasAnteriores(articulo);
            }
            if (familia.Mingrueso > articulo.SGrueso || familia.Maxgrueso < articulo.SGrueso) {  
                bootbox.alert({
                    title: "Grueso fuera de rango",
                    message: "El grueso debe tener un mínimo de " + familia.Mingrueso + " m y un máximo de " + familia.Maxgrueso + " m",
                    size: 'large'
                });
                $scope.MedidasAnteriores(articulo);
            }
        }).error(function (error) {
            console.log("error call validar dimensiones");
        });

        $scope.CalcularPrecioMetros(articulo);   
    }

    //Recalculamos metros y precio
    $scope.CalcularPrecioMetros = function (articulo) {

        if (articulo["unidad"] == "01") {
            articulo.SLargo = articulo.SLargo.toString().replace(",", ".");
            articulo.SAncho = articulo.SAncho.toString().replace(",", ".");
            articulo.SGrueso = articulo.SGrueso.toString().replace(",", ".");
            articulo.SMetros = articulo.Cantidad;
            var importe = (articulo.SPrecio * articulo.SMetros).toFixed(2);
            var descuento = ((importe * articulo.Porcentajedescuento) / 100).toFixed(2);
            articulo.SImporte = importe - descuento;
        }

        //Precio = Precio * cantidad * Metros (largo * ancho)
        else if (articulo["unidad"] == "02") {
            articulo.SLargo = articulo.SLargo.toString().replace(",", ".");
            articulo.SAncho = articulo.SAncho.toString().replace(",", ".");
            articulo.SGrueso = articulo.SGrueso.toString().replace(",", ".");
            articulo.SMetros = (articulo.Cantidad * articulo.SLargo * articulo.SAncho).toFixed(2);
            var importe = (articulo.SPrecio * articulo.SMetros).toFixed(2);
            var descuento = ((importe * articulo.Porcentajedescuento) / 100).toFixed(2);
            articulo.SImporte = importe - descuento;
        }

        //Precio = Precio * cantidad * Metros (largo * ancho * grueso)
        else if (articulo["unidad"] == "03") {
            articulo.SLargo = articulo.SLargo.toString().replace(",", ".");
            articulo.SAncho = articulo.SAncho.toString().replace(",", ".");
            articulo.SGrueso = articulo.SGrueso.toString().replace(",", ".");
            articulo.SMetros = (articulo.Cantidad * articulo.SLargo * articulo.SAncho * articulo.SGrueso).toFixed(2);
            var importe = (articulo.SPrecio * articulo.SMetros).toFixed(2);
            var descuento = ((importe * articulo.Porcentajedescuento) / 100).toFixed(2);
            articulo.SImporte = importe - descuento;
        }

        //Precio = Precio * cantidad * (largo)
        else if (articulo["unidad"] == "05") {
            articulo.SLargo = articulo.SLargo.toString().replace(",", ".");
            articulo.SAncho = articulo.SAncho.toString().replace(",", ".");
            articulo.SGrueso = articulo.SGrueso.toString().replace(",", ".");
            articulo.SMetros = (articulo.Cantidad * articulo.SLargo).toFixed(2);
            var importe = (articulo.SPrecio * articulo.SMetros).toFixed(2);
            var descuento = ((importe * articulo.Porcentajedescuento) / 100).toFixed(2);
            articulo.SImporte = importe - descuento;
        }

        else {
            bootbox.alert("no se ha especificado la medida para el articulo " + articulo.IdComponente);
        }

        articulo.Largo = articulo.SLargo;
        articulo.Ancho = articulo.SAncho;
        articulo.Grueso = articulo.SGrueso;
        articulo.Metros = articulo.SMetros;
        articulo.Precio = articulo.SPrecio;
        articulo.Importe = articulo.SImporte;

        $scope.$apply();
    }

    $scope.cancelar = function () {
        $('#' + $scope.IdFormulariomodal).modal('hide');
        $('#' + $scope.IdComponenteasociado).focus();
    };

    $scope.scrollToFocus = function (rowIndex, colIndex) {
        var row = $scope.gridApi.grid.getVisibleRows()[rowIndex].entity;
        $scope.gridApi.cellNav.scrollToFocus(row, $scope.gridOptions.columnDefs[colIndex]);
    };

    $scope.loading = true;
    $scope.load = function (campoIdentificador, IdComponenteasociado, IdFormulariomodal, Url, Titulo) {
        $scope.loading = true;
        $scope.campoIdentificador = campoIdentificador;
        $scope.IdComponenteasociado = IdComponenteasociado;
        $scope.IdFormulariomodal = IdFormulariomodal;
        $scope.Titulo = Titulo;
        
        $scope.cantidadesPermitidas = [];
        for (var i = 0; i < $scope.values.length; i++)
        {            
            $scope.cantidadesPermitidas.push($scope.values[i].Cantidad);
        }

        $scope.selected = null;
        $scope.gridApi.grid.clearAllFilters();
        $scope.loading = false;
        $scope.gridOptions.columnDefs = $scope.columns;
        $scope.gridOptions.data = $scope.values;
        $scope.gridApi.grid.enableHorizontalScrollbar = 2;
        $scope.gridOptions.minWidth = 150;
        $scope.gridApi.core.refresh();
        $scope.gridApi.core.handleWindowResize();
        $timeout(function () {
            $("[name='columnheader-0']")[0].focus();
            $("[name='columnheader-0']").on("keydown", function (e) {
                if (e.keyCode === 40) {
                    $scope.scrollToFocus(0, 0);
                }
            });

        });
    }
}]);


