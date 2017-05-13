$(function(){


  // $("#rendezvous-point").on('click',function(){
  $("#rendezvous-point-input").on("input",function(){
    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 16,
      center: {lat: -34.397, lng: 150.644}
    });
      var geocoder = new google.maps.Geocoder();
      geocodeAddress(geocoder, map);
  });

  function geocodeAddress(geocoder, resultsMap) {
    var rendezvousPoint = $("#rendezvous-point-input").val();
    var country = $("#tour_country_id option:selected").text();
    geocoder.geocode(
      { address: rendezvousPoint,
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
