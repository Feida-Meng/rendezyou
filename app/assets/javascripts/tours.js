$(function(){
  var showTourMapDiv = document.getElementById('show-tour-map');
  var tourPointMapDiv = document.getElementById('tourpointmap');
  var tourMapDiv;
  var tourId;
  var mapPage;
  var currentUrl = window.location.href;

  if ($.contains(document,showTourMapDiv)) {
    tourId = currentUrl.substring(currentUrl.lastIndexOf('/') + 1);
    tourMapDiv = showTourMapDiv;
    mapPage = true;
  } else if ( $.contains(document, tourPointMapDiv)) {
    tourId = currentUrl.substring(currentUrl.indexOf('/tours/') + 7,currentUrl.indexOf('/tourpoints/new') );
    tourMapDiv = tourPointMapDiv;
    mapPage = true;
  } else {
    mapPage = false;
  }

  if (mapPage === true) {

    var tourPageUrl = "/tours/"+tourId;
    var tour;
    var tourpoints = [];
    $.ajax({
      method:"GET",
      url: tourPageUrl,
      dataType:'json'
    }).done(function(reponseData){
      tour = reponseData;

      var tourMap = createMap(tourMapDiv);
      var rendezvousPoint = tour.rendezvous_point;
      var country = tour.country;

      geocodeAddress(rendezvousGeocoder(), tourMap, country, rendezvousPoint);

      var latlng;
      var latP;
      var lagP;
      var markerPosition;
      var tourPointInfoWindow = new google.maps.InfoWindow();
      var bounds = new google.maps.LatLngBounds();
      var marker;
      var markers = {};
      var markerPlaced = false;
      var newMarker;

      if (tour.tourpoints.length > 0) {
        for (var i = 0; i<tour.tourpoints.length;i++) {
          laglng = tour.tourpoints[i].tour_point_laglng;
          latP = Number(laglng.substring(laglng.indexOf("(")+1,laglng.indexOf(",")-1));
          lagP = Number(laglng.substring(laglng.indexOf(",")+1,laglng.indexOf(")")-1));
          markerPosition = {lat:latP,lng:lagP};
          marker = markerMaker(markerPosition,tourMap,(i+1).toString(),false);
          markers[marker.label]= tour.tourpoints[i];
          marker.addListener('click', function() {
            populateInfoWindow(this,markers[this.label],tourPointInfoWindow,tourMap);
          });
           bounds.extend(marker.position);
        }
      }
      if (tourMapDiv === tourPointMapDiv) {
        tourMap.addListener('click', function(event) {
          if (markerPlaced === false) {
            $("#tourpoint_tour_point_laglng").val(event.latLng.toString());
            console.log(event.latLng);
            newMarker = markerMaker(event.latLng, tourMap, (i+1).toString(),true);
            google.maps.event.addListener(newMarker, 'dragend', function (event) {
              $("#tourpoint_tour_point_laglng").val(event.latLng.toString());
            });

          }
          markerPlaced = true;
        });
      }

      tourMap.fitBounds(bounds);
    });
  }


  $("#rendezvous-point-input").on("input",function(){
    var newTourMapDiv = $("#rendezvous-map");
    var rendezvousPointInput = $("#rendezvous-point-input").val();
    var tourCountry = $("#tour_country_id option:selected").text();
    geocodeAddress(rendezvousGeocoder(), createMap(newTourMapDiv), tourCountry, rendezvousPointInput);
  });

});
