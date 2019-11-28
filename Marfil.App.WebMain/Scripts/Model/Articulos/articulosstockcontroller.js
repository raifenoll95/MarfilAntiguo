app.controller('ArticulosStockCtrl', ['$scope', '$http', '$location', '$window', '$timeout', function ($scope, $http, $location, $window, $timeout) {
   
    $scope.Labor = false;
    $scope.Gestionstock = false;
    $scope.Tipogestionlotes = 0;
    $scope.Stocknegativoautorizado = false;
    $scope.Tipofamilia = 0;
    $scope.Lotefraccionable = false;
    $scope.Gestionstockdisabled = false;
    $scope.Tipogestionlotesdisabled = false;
    $scope.Stocknegativoautorizadodisabled = false;
    $scope.Lotefraccionabledisabled = false;

    $scope.Deshabilitargrosor = false;
    $scope.Deshabilitaracabado = false;
    //$scope.Deshabilitardimensiones = false;
    $scope.Deshabilitarmaterial = false;
    $scope.Deshabilitarcaracteristica = false;
    $scope.Valorgrosor = false;
    $scope.Valoracabado = false;
    $scope.Valormaterial = false;
    $scope.Valorcaracteristica = false;
    //$scope.Valordimensiones = false;
    $scope.LOADING = true;

    //$scope.init = function (Labor, Gestionstock, Tipogestionlotes, 
    $scope.init = function (Labor, Gestionstock, Tipogestionlotes, Stocknegativoautorizado, Lotefraccionable, Tipofamilia, valormaterial, valorcaracteristica, valordimensiones) {
        $scope.LOADING = true;
        $scope.Labor = Labor;
        $scope.Tipofamilia = Tipofamilia;
        $scope.Gestionstock = Gestionstock;
        $scope.Tipogestionlotes = Tipogestionlotes;
        $scope.Stocknegativoautorizado = Stocknegativoautorizado;
        $scope.Lotefraccionable = Lotefraccionable;
        $scope.Valormaterial = valormaterial;
        $scope.Valorcaracteristica = valorcaracteristica;        
        $scope.VerificarTipofamilia(Tipofamilia);
        $scope.actualizarTipofamilia(Tipofamilia);
        $scope.LOADING = false;
    }

    eventAggregator.RegisterEvent("Familia-cv", function(message) {
        if (message) {
            $scope.Gestionstock = message.Gestionstock;
            $scope.Tipofamilia = message.Tipofamilia;
            $scope.Stocknegativoautorizado = message.Stocknegativoautorizado;
            $scope.Lotefraccionable = message.Lotefraccionable;

            $("[name='Validardimensiones']").prop('checked', message.Validardimensiones);

            //tipofamilia 
            $scope.actualizarTipofamilia(message.Tipofamilia);
            $scope.$apply();
        }
    });

        //Cambia el tipo de familia
        $scope.$watch("Tipofamilia", function (nwevalue, oldvalue) {         
            $scope.actualizarTipofamilia(nwevalue);
        });

        //Bloquear Gestiones
        $scope.actualizarTipofamilia = function (tipofamilia) {

            $scope.Lotefraccionabledisabled = false;
            $scope.Gestionstockdisabled = $scope.Bloqueostock(tipofamilia); //No se puede modificar si es tabla o bloque

            //Si la gestion de stock es true, lo dejamos a true, si es falso es porque o es nuevo (dependera de si es bloque o tabla para ponerse a true, o si es otro, estara a false)
            if (!$scope.Gestionstock) {
                $scope.Gestionstock = $scope.Bloqueostock(tipofamilia); //Por defecto activado (true,1)
            }
            $scope.Tipogestionlotesdisabled = false; //Si es tabla o bloque, puede elegir el que quiera
            $scope.Stocknegativoautorizadodisabled = false;
            $scope.VerificarTipofamilia(tipofamilia);
        }
        
        //Bloqueo si es tabla o bloque
        $scope.Bloqueostock = function (valor) {
            return (valor == 1 || valor == 2) 
        }

    $scope.$watch("Gestionstock", function (nwevalue, oldvalue) {
        if (!$scope.Gestionstock) {
            $scope.Tipogestionlotes = 0;
            $scope.Stocknegativoautorizado = false;
        }
    });

    $scope.$watch("Tipogestionlotes", function (nwevalue, oldvalue) {
        if ($scope.Tipogestionlotes > 0) {
            $scope.Stocknegativoautorizado = false;
        }
    });
    $scope.$watch("Valormaterial", function (nwevalue, oldvalue) {
        $("[name='Validarmaterial']").val(nwevalue);

    });
    $scope.$watch("Valorcaracteristica", function (nwevalue, oldvalue) {
        $("[name='Validarcaracteristica']").val(nwevalue);

    });

    $scope.VerificarTipofamilia = function (valor) {
        if (valor == "1") {
            $scope.Valorgrosor = false;
            $scope.Valoracabado = false;
            $scope.Valormaterial = true;
            $scope.Valorcaracteristica = true;

            $scope.Deshabilitarmaterial = false;
            $scope.Deshabilitarcaracteristica = false;
            $scope.Deshabilitargrosor = true;
            $scope.Deshabilitaracabado = true;            

            $("[name='Validargrosor']").val(false);
            $("[name='Validaracabado']").val(false);            

        } else if (valor == "3") {
            $scope.Valorgrosor = false;
            $scope.Valoracabado = false;
            $scope.Valorcaracteristica = false;
            $scope.Valormaterial = false;


            $("[name='Validarmaterial']").val(false);
            $("[name='Validarcaracteristica']").val(false);
            $("[name='Validargrosor']").val(false);
            $("[name='Validaracabado']").val(false);


            $scope.Deshabilitargrosor = true;
            $scope.Deshabilitaracabado = true;
            $scope.Deshabilitarmaterial = true;
            $scope.Deshabilitarcaracteristica = true;
            
        } else {
            $scope.Valorgrosor = true;
            $scope.Valoracabado = true;
            $scope.Valorcaracteristica = true;
            $scope.Valormaterial = true;


            $scope.Deshabilitargrosor = false;
            $scope.Deshabilitaracabado = false;
            $scope.Deshabilitarmaterial = false;
            $scope.Deshabilitarcaracteristica = false;
        }
    }


}]);