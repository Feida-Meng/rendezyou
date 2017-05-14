$(function(){

  var showTourMapDiv = document.getElementById('show-tour-map');
  // $.ajax({
  //   method:"GET",
  //   url: tour_page_url,
  //   dataType:'json'
  // });
  if ($.contains(document,showTourMapDiv) ) {
    var current_url = window.location.href;
    var tour_id = current_url.substring(current_url.lastIndexOf('/') + 1);
    var tour_page_url = "/tours/"+tour_id;
    $.ajax({
      method:"GET",
      url: tour_page_url,
      dataType:'json'
    }).done(function(reponseData){
      console.log(reponseData);
    });
    console.log(tour_page_url);
    console.log(document.URL);
  }

  var showTourMap = new google.maps.Map(showTourMapDiv, {
    zoom: 16,
    center: {lat: -34.397, lng: 150.644}
  });


  // $("#rendezvous-point").on('click',function(){
  $("#rendezvous-point-input").on("input",function(){
    var map = new google.maps.Map(document.getElementById('rendezvous-map'), {
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
