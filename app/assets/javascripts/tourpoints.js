$(function(){

//map------------------------------------------------------------------------------------------
  var tourPointMapDiv = document.getElementById('tourpointmap');

  if ($.contains(document,tourPointMapDiv) ) {
    var currentUrl = window.location.href;
    var tourId = currentUrl.substring(currentUrl.indexOf('/tours/') + 7,currentUrl.indexOf('/tourpoints/new') );
    var tourPageUrl = "/tours/"+tourId;
    var tour;
    var tourpoints = [];
    $.ajax({
      method:"GET",
      url: tourPageUrl,
      dataType:'json'
    }).done(function(reponseData){
      tour = reponseData;

      console.log(tour);

      var tourPointMap = new google.maps.Map(tourPointMapDiv, {
        zoom: 13,
        center: {lat: -34.397, lng: 150.644}
      });

      var rendezvousPoint = tour.rendezvous_point;
      var country = "Canada";//tour.rendezvous_point;
      var rendezvousGeocoder = new google.maps.Geocoder();

      geocodeAddress(rendezvousGeocoder, tourPointMap, country,rendezvousPoint, rendezvousPoint);

      var latlng;
      var latP;
      var lagP;
      var markerPosition;
      var largeInfowindow = new google.maps.InfoWindow();
      var bounds = new google.maps.LatLngBounds();
      var marker;
      var i ;
      var markerPlaced = false;
      if (tour.tourpoints.length > 0) {

        for (i = 0; i<tour.tourpoints.length;i++) {

          laglng = tour.tourpoints[i].tour_point_laglng;
          latP = Number(laglng.substring(laglng.indexOf("(")+1,laglng.indexOf(",")-1));
          lagP = Number(laglng.substring(laglng.indexOf(",")+1,laglng.indexOf(")")-1));
          markerPosition = {lat:latP,lng:lagP};
          console.log(markerPosition);
          marker = markerMaker(markerPosition, tourPointMap,(i+1).toString());
          marker.addListener('click', function () {
            populateInfoWindow(this, largeInfowindow, tourPointMap);
          });
          // bounds.extend(marker.position);
        }
      }
      // showTourMap.fitBounds(bounds);

      tourPointMap.addListener('click', function(event) {
        if (markerPlaced === false) {
          markerMaker(event.latLng, tourPointMap, (i+1).toString());
        }
        markerPlaced = true;
      });



    }).fail(function(){
      console.log("fails");
    });
  }

  function populateInfoWindow(marker, infowindow, map) {

    if (infowindow.marker != marker) {
      infowindow.marker = marker;
      infowindow.setContent('<div>' + marker.title + '</div>');
      infowindow.open(map, marker);
      infowindow.addListener('closeclick',function(){
        infowindow.setMarker = null;
      });
    }
  }

  var image = 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png';
  function markerMaker(position,map,label) {
    var marker = new google.maps.Marker({
      position: position,
      map: map,
      label:label,
      icon:image,
      title: 'Tp',
      animation: google.maps.Animation.DROP
    });
    $("#tourpoint_tour_point_laglng").val( marker.getPosition().toString() );
    return marker;
  }


  function geocodeAddress(geocoder, resultsMap, country, address, markerTitle) {

    geocoder.geocode(
      { address: address,
        componentRestrictions: {country: country}
      }, function(results, status) {
      if (status === 'OK') {
        resultsMap.setCenter(results[0].geometry.location);
        var rendezvousPointMarker = new google.maps.Marker({
          map: resultsMap,
          label:"R",
          position: results[0].geometry.location,
          title: markerTitle,
          animation: google.maps.Animation.DROP
        });
      } else {
        alert('Geocode was not successful for the following reason: ' + status);
      }
    });
  }

//map------------------------------------------------------------------------------------------

});
