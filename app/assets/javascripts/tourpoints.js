$(function(){

  // $.ajax({
  //   method:"POST",
  //   url: "",
  //   data: $(this).serialize(),
  //   dataType:'json'
  //
  // });

  $("#tour-site-input").on("input",initMap);


  function initMap(){
    var markers = [];

    var tourpointmap = new google.maps.Map(document.getElementById("tourpointmap"), {
      zoom: 16,
      center: {lat: -34.397, lng: 150.644}
    });
      var geocoder = new google.maps.Geocoder();
      tourPointLocator(geocoder, tourpointmap);

    var drawingManager = new google.maps.drawing.DrawingManager({
      drawingMode: google.maps.drawing.OverlayType.MARKER,
      drawingControl: true,

      drawingControlOptions: {
        position: google.maps.ControlPosition.TOP_CENTER,
        drawingModes: ['marker', 'circle', 'polygon', 'polyline', 'rectangle']
      },
      rectangleOptions: {
        editable: true
      },
      polylineOptions: {
        editable: true
      },
      polygonOptions: {
        editable: true
      },
      markerOptions: {
        icon: 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png'
      },
      circleOptions: {
       fillColor: '#ffff00',
       fillOpacity: 1,
       strokeWeight: 5,
       clickable: false,
       editable: true,
       zIndex: 1
     }
    });

    drawingManager.setMap(tourpointmap);


  }

  function tourPointLocator(geocoder, resultsMap) {
    var tourSite = $("#tour-site-input").val();
    // var country = $("#tour_country_id option:selected").text();
    geocoder.geocode(
      { address: tourSite
        // componentRestrictions: {country: country}
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
