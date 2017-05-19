// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require_tree .
//= require bootstrap-sprockets

function geocodeAddress(geocoder, resultsMap, country, address) {

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
        title: "Rendezvous Point",
        animation: google.maps.Animation.DROP
      });
    } else {
      // alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

var image = 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png';
function markerMaker(position,map,label,draggable) {
  var marker = new google.maps.Marker({
    position: position,
    map: map,
    label:label,
    icon:image,
    title: 'TP',
    draggable:draggable,
    animation: google.maps.Animation.DROP
  });
  return marker;
}

function populateInfoWindow(marker, tourpoint, infowindow, map) {
  var tourPointName = "<div>" + "<h3>" + tourpoint.tour_point_name + "</h3>" + "</div>";
  var tourPointDescription = "<div>" + tourpoint.tour_point_description + "</div>";
  var tourPointImg = "<img src=" + tourpoint.tour_point_img + " alt='tour point image' width='400px' height='400px' border=0>";
  var tourPointImgDiv = "<div>" + "<a href =" + tourpoint.tour_point_img + ">" + tourPointImg + "</a>" + "</div>";
  if (infowindow.marker != marker) {
    infowindow.marker = marker;
    infowindow.setOptions({maxWidth:500});
    infowindow.setContent( tourPointName + tourPointDescription + tourPointImgDiv  );
    infowindow.open(map, marker);
    infowindow.addListener('closeclick',function(){
      infowindow.setMarker = null;
    });
  }
}

function createMap(tourMapDiv) {
  var map = new google.maps.Map(tourMapDiv, {
    zoom: 10,
    center: {lat: -34.397, lng: 150.644}
  });
  return map;
}

function rendezvousGeocoder() {
  var geocoder = new google.maps.Geocoder();
  return geocoder;
}
