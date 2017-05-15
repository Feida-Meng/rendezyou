$(function(){

  var showTourMapDiv = document.getElementById('show-tour-map');

  if ($.contains(document,showTourMapDiv) ) {
    var currentUrl = window.location.href;
    var tourId = currentUrl.substring(currentUrl.lastIndexOf('/') + 1);
    var tourPageUrl = "/tours/"+tourId;
    var tour;
    $.ajax({
      method:"GET",
      url: tourPageUrl,
      dataType:'json'
    }).done(function(reponseData){
      tour = reponseData;

      var showTourMap = new google.maps.Map(showTourMapDiv, {
        zoom: 16,
        center: {lat: -34.397, lng: 150.644}
      });

      var rendezvousPoint = tour.rendezvous_point;
      var country = "Canada";//tour.rendezvous_point;
      var rendezvousGeocoder = new google.maps.Geocoder();
      geocodeAddress(rendezvousGeocoder, showTourMap, country,rendezvousPoint);

    });
  }

  // $("#rendezvous-point").on('click',function(){
  $("#rendezvous-point-input").on("input",function(){
    var rendezvousMap = new google.maps.Map(document.getElementById('rendezvous-map'), {
      zoom: 16,
      center: {lat: -34.397, lng: 150.644}
    });
    var rendezvousPoint = $("#rendezvous-point-input").val();
    var country = $("#tour_country_id option:selected").text();
    var rendezvousGeocoder = new google.maps.Geocoder();
    geocodeAddress(rendezvousGeocoder, rendezvousMap, country, rendezvousPoint);
  });

  function geocodeAddress(geocoder, resultsMap, country, address) {

    geocoder.geocode(
      { address: address,
        componentRestrictions: {country: country}
      }, function(results, status) {
      if (status === 'OK') {
        resultsMap.setCenter(results[0].geometry.location);
        var marker = new google.maps.Marker({
          map: resultsMap,
          position: results[0].geometry.location
        });
      } else {
        alert('Geocode was not successful for the following reason: ' + status);
      }
    });
  }

});
