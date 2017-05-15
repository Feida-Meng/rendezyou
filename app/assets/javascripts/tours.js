$(function(){

  var showTourMapDiv = document.getElementById('show-tour-map');


  if ($.contains(document,showTourMapDiv) ) {
    var currentUrl = window.location.href;
    var tourId = currentUrl.substring(currentUrl.lastIndexOf('/') + 1);
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

      var showTourMap = new google.maps.Map(showTourMapDiv, {
        zoom: 13,
        center: {lat: -34.397, lng: 150.644}
      });

      var rendezvousPoint = tour.rendezvous_point;
      var country = "Canada";//tour.rendezvous_point;
      var rendezvousGeocoder = new google.maps.Geocoder();

      geocodeAddress(rendezvousGeocoder, showTourMap, country,rendezvousPoint, rendezvousPoint);

      var latlng;
      var latP;
      var lagP;
      var markerPosition;
      var largeInfowindow = new google.maps.InfoWindow();
      var bounds = new google.maps.LatLngBounds();
      var marker;
      for (var i = 0; i<tour.tourpoints.length;i++) {

        laglng = tour.tourpoints[i].tour_point_laglng;
        latP = Number(laglng.substring(laglng.indexOf("(")+1,laglng.indexOf(",")-1));
        lagP = Number(laglng.substring(laglng.indexOf(",")+1,laglng.indexOf(")")-1));
        markerPosition = {lat:latP,lng:lagP};
        console.log(markerPosition);
        marker = markerMaker(markerPosition, showTourMap,(i+1).toString());
        marker.addListener('click', function () {
          populateInfoWindow(this,tour.tourpoints[i],largeInfowindow,showTourMap);
        });
        // bounds.extend(marker.position);
      }
    // showTourMap.fitBounds(bounds);
    });
  }

  function populateInfoWindow(marker, tourpoint, infowindow, map) {
    var tourPointName = "<div>" + tourpoint.tour_point_name + "</div>";
    var tourPointImg = "<img src=" + tourpoint.tour_point_img + " alt='tour point image' width='42' height='42' border=0>";
    var tourPointImgDiv = "<div>" + "<a href =" + tourpoint.tour_point_img + ">" + tourPointImg + "</a>" + "</div>";
    if (infowindow.marker != marker) {
      infowindow.marker = marker;
      infowindow.setContent( tourPointName + tourPointImgDiv );
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
      title: 'TP',
      animation: google.maps.Animation.DROP
    });

    return marker;
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
          // Icon: "https://maxcdn.icons8.com/Share/icon/Network//router1600.png",
          position: results[0].geometry.location,
          title: markerTitle,
          animation: google.maps.Animation.DROP
        });
      } else {
        alert('Geocode was not successful for the following reason: ' + status);
      }
    });
  }

});
