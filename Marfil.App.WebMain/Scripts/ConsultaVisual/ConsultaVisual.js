//Raimundo Fenoll Albaladejo. Consulta Visual Controladores Srcipt 

//Configuracion del app angular

//var app = angular.module('VisualangularApp', ['consVisualModule']);

//app.factory("ParamBusqStockVisual", function () {
//    //return {
//    //    data: {}
//    //};
//    var ret = function(){}
//    ret.almacen = "";
//    ret.familia = "";
//    ret.material = "";
//    ret.articulosLote = "";
//    ret.lote = "";
//});


//Almacenes Ctrl
app.controller('AlmacenesCtrl', ['$scope', '$http', '$location', '$window', '$timeout', function ($scope, $http, $location, $window, $timeout) {

    //Atributos de momento
    $scope.myobj;
    $scope.almacenes;
    $scope.AlmacenSeleccionado;
    $scope.AlmacenDescripcion;
    $scope.AlmacenId;

    $scope.init = function (urlBase) {
        
        $scope.urlBase = urlBase;
        comprobarAlmacenesBD(urlBase);

        //ParamBusqStockVisual.almacen = "";
        //ParamBusqStockVisual.familia = "";
        //ParamBusqStockVisual.material = "";
        //ParamBusqStockVisual.articulosLote = "";
        //ParamBusqStockVisual.lote = "";
    }

    //Almacenes
    function comprobarAlmacenesBD(url) {

        var URL = url + "/getAlmacenes";
        console.log(URL);

        $http.get(URL).success(function (data) {
            $scope.almacenes = JSON.parse(data);
        }).error(function (error) {
            console.log(error);
        });
    }

    
    
}]);


//Familias Ctrl
app.controller('FamiliasCtrl', ['$scope', '$http', '$location', '$window', '$timeout', function ($scope, $http, $location, $window, $timeout) {

    //Atributos de momento
    $scope.idAlmacen;
    $scope.familias;
    $scope.DescripcionAlmacen;
    $scope.myobj;

    //init
    $scope.init = function (urlBase) {

        $scope.urlBase = urlBase;

        var urlAlmacenes = window.location.pathname;
        var array = urlAlmacenes.split('/');
        $scope.idAlmacen = array[array.length-1];
        //ParamBusqStockVisual.almacen = $scope.idAlmacen;
        //ParamBusqStockVisual.familia = "";
        //ParamBusqStockVisual.material = "";
        //ParamBusqStockVisual.articulosLote = "";
        //ParamBusqStockVisual.lote = "";
        
        console.log($routeParams);
        comprobarFamiliasBD(urlBase);
        MostrarDescripcionAlmacen(urlBase);

        
    }

    //Familias asociadas a ese almacen
    function comprobarFamiliasBD(previousPaths) {

        var URL = previousPaths + "/ConsultaVisual/getFamilias";
        console.log(URL);
        //console.log("idalmacen: " + ParamBusqStockVisual.almacen);
        $http.get(URL+"?idAlmacen=" + $scope.idAlmacen).success(function (data) {
            $scope.familias = JSON.parse(data);
        }).error(function (error) {
            console.log(error);
        });
    }

    //Familias asociadas a ese almacen
    function MostrarDescripcionAlmacen(previousPaths) {

        var URL = previousPaths + "/ConsultaVisual/getDescripcionAlmacen";
        console.log(URL);

        $http.get(URL + "?idAlmacen=" + $scope.idAlmacen).success(function (data) {
            $scope.DescripcionAlmacen = data;
        }).error(function (error) {
            console.log(error);
        });
    }
}]);

//Grupo Materiales Ctrl
app.controller('GrupoMaterialesCtrl', ['$scope', '$http', '$location', '$window', '$timeout', function ($scope, $http, $location, $window, $timeout) {

    //Atributos de momento
    $scope.myobj;
    $scope.FamiliaSeleccionada;
    $scope.DescripcionFamilia;
    $scope.grupoMateriales;
    //$scope.urlImageAux;

    //init
    $scope.init = function (urlBase, urlImagenDefecto) {

        $scope.urlBase = urlBase;
            var urlGrupo = window.location.pathname;
            var array = urlGrupo.split('/');
            $scope.FamiliaSeleccionada = array[array.length - 1];
            $scope.PathPage = "/ConsultaVisual/ViewMateriales";
            $scope.urlImageAux = urlImagenDefecto;
            comprobarDescripcionFamilia(getUrl($scope.PathPage, $scope.FamiliaSeleccionada));
            comprobarGruposMaterialesBD(getUrl($scope.PathPage, $scope.FamiliaSeleccionada), $scope.FamiliaSeleccionada);


            //ParamBusqStockVisual.material = "";
            //ParamBusqStockVisual.articulosLote = "";
            //ParamBusqStockVisual.lote = "";
    }   
    
    $scope.Getsrc = function (url, ficheros) {

        console.log("url: " + url);

        if (Array.isArray(ficheros)) {

            if (ficheros.length > 0) {
                return url + ficheros[0].Id;
                console.log("si");
            }          
            else {
                return $scope.urlImageAux;
                console.log("img aux: " + $scope.urlImageAux);
            }
        }
    }

    $scope.ViewProd = function(idMat)
    {

    }
    //Familias asociadas a ese almacen
    function comprobarGruposMaterialesBD(previousPaths, familia) {

        var URL = previousPaths + "/ConsultaVisual/getGruposMateriales";

        $http.get(URL + "?idFamilia=" + $scope.FamiliaSeleccionada).success(function (data) {

            //JSON parse data para evitar el error del ng-repeat
            $scope.grupoMateriales = JSON.parse(data);

            console.log("data: " + data);

            $scope.grupoMateriales.forEach(function (pieza) {
                console.log(pieza.Empresa);
            });

        }).error(function (error) {
            console.log(error);
        });
    }

    //Familias asociadas a ese almacen
    function comprobarDescripcionFamilia(previousPaths) {

        var URL = previousPaths + "/ConsultaVisual/getDescripcionFamilia";

        $http.get(URL + "?idFamilia=" + $scope.FamiliaSeleccionada).success(function (data) {
            $scope.DescripcionFamilia = data;
        }).error(function (error) {
            console.log(error);
        });
    }
}]);


//Productos Ctrl
app.controller('ProductosCtrl', ['$scope', '$http', '$location', '$window', '$timeout', function ($scope, $http, $location, $window, $timeout) {

    //Atributos de momento
    $scope.myobj;
    $scope.GrupoMaterialSeleccionado;
    $scope.DescripcionGrupo;
    $scope.productos;

    //init
    $scope.init = function (urlBase, urlImagenDefecto) {
        $scope.urlBase = urlBase;

        $scope.urlImageAux = urlImagenDefecto;
        var urlGrupo = window.location.pathname;
        var array = urlGrupo.split('/');
        $scope.GrupoMaterialSeleccionado = array[array.length - 1];
        console.log("grupo material: " + $scope.GrupoMaterialSeleccionado);
        $scope.PathPage = "/ConsultaVisual/ViewProductos";
        comprobarProductos(getUrl($scope.PathPage, $scope.GrupoMaterialSeleccionado), $scope.GrupoMaterialSeleccionado);
        comprobarDescripcionGrupoMaterial(getUrl($scope.PathPage, $scope.GrupoMaterialSeleccionado));

        ParamBusqStockVisual.articulosLote = "";
        ParamBusqStockVisual.lote = "";
    }

    $scope.Getsrc = function (url, item) {

        console.log("url: " + url);
        console.log("id: " + item[0]);

        if (Array.isArray(item)) {

            if (item.length > 0) {
                console.log("id: " + item[0].Id);
                return url + item[0].Id;
            }
            else {
                return $scope.urlImageAux;
                console.log("img aux: " + $scope.urlImageAux);
            }
        }
    }

    //Comprobamos los productos
    function comprobarProductos(previousPaths) {

        var URL = previousPaths + "/ConsultaVisual/getMateriales";
        console.log("URl: " + URL);

        $http.get(URL + "?CodMaterial=" + $scope.GrupoMaterialSeleccionado).success(function (data) {
            $scope.productos = JSON.parse(data);
            console.log($scope.productos);
        }).error(function (error) {
            console.log(error);
        });
    }

    function comprobarDescripcionGrupoMaterial(previousPaths) {

        var URL = previousPaths + "/ConsultaVisual/getDescripcionGrupoMaterial";
        console.log("URl: " + URL);

        $http.get(URL + "?CodGrupoMaterial=" + $scope.GrupoMaterialSeleccionado).success(function (data) {
            $scope.DescripcionGrupo = data;
        }).error(function (error) {
            console.log(error);
        });
    }
}]);


//Articulos Ctrl
app.controller('ArticulosCtrl', ['$scope', '$http', '$location', '$window', '$timeout', function ($scope, $http, $location, $window, $timeout) {

    //Atributos de momento
    $scope.myobj;
    $scope.ArticuloSeleccionado;
    $scope.DescripcionArticulo;
    $scope.articulos;

    //init
    $scope.init = function (urlBase, urlImagenDefecto) {
        $scope.urlBase = urlBase;
        $scope.urlImageAux = urlImagenDefecto;
        var urlGrupo = window.location.pathname;
        var array = urlGrupo.split('/');
        $scope.ArticuloSeleccionado = array[array.length - 1];
        $scope.PathPage = "/ConsultaVisual/ViewProducto";
        console.log("articulo: " + $scope.ArticuloSeleccionado);
        comprobarArticulos(getUrl($scope.PathPage, $scope.ArticuloSeleccionado), $scope.ArticuloSeleccionado);
        comprobarDescripcionArticulo(getUrl($scope.PathPage, $scope.ArticuloSeleccionado));

        ParamBusqStockVisual.lote = "";
    }

    $scope.Getsrc = function (url, item) {

        console.log("url: " + url);

        if (Array.isArray(item)) {

            if (item.length > 0) {
                return url + item[0].Id;
            }
            else {
                return $scope.urlImageAux;
                console.log("img aux: " + $scope.urlImageAux);
            }
        }
    }

    //Comprobamos los productos
    function comprobarArticulos(previousPaths) {

        var URL = previousPaths + "/ConsultaVisual/getMaterial";
        console.log("URl: " + URL);

        $http.get(URL + "?IdArticulo=" + $scope.ArticuloSeleccionado).success(function (data) {
            $scope.articulos = JSON.parse(data);
            $scope.DescripcionArticulo = $scope.ArticuloSeleccionado;
        }).error(function (error) {
            console.log(error);
        });
    }

    function comprobarDescripcionArticulo(previousPaths) {

        var URL = previousPaths + "/ConsultaVisual/getDescripcionArticulo";
        console.log("URl: " + URL);

        $http.get(URL + "?IdArticulo=" + $scope.ArticuloSeleccionado).success(function (data) {
            $scope.DescripcionArticulo = data;
        }).error(function (error) {
            console.log(error);
        });
    }
}]);