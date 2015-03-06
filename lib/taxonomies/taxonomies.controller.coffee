module.exports = angular.module('wordpress-hybrid-client.taxonomies')
    .controller 'WPHCTaxonomiesController', ($log, $scope, $wpApiTaxonomies, $WPHCTaxonomies, $state, $WPHCLoading) ->
        $log.info 'WPHCTaxonomiesController'

        vm = @
        vm.list = undefined
        vm.title = $WPHCTaxonomies.getTitle $state.params.term
        vm.term = $state.params.term

        $scope.$on '$ionicView.loaded', () ->
            $WPHCLoading.show()
            $WPHCTaxonomies.getList($state.params.term)
            .then (response) ->
                vm.list = response.data.filter (item) ->
                    item.count > 0 # remove useless taxo
            .catch () ->
                $log.debug 'posts error'
            .finally () ->
                $WPHCLoading.hide()

        return @
