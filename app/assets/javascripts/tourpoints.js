$(function(){

  // $.ajax({
  //   method:"POST",
  //   url: "",
  //   data: $(this).serialize(),
  //   dataType:'json'
  //
  // });
//map------------------------------------------------------------------------------------------
  $("#tour-site-input").on("input",initMap);

  var tourPointDrawing;
  var markers = [];
  var tourPointMap;


  function initMap(){

    tourPointMap = new google.maps.Map(document.getElementById("tourpointmap"), {
      zoom: 16,
      center: {lat: -34.397, lng: 150.644}
    });

      var geocoder = new google.maps.Geocoder();
      tourPointLocator(geocoder, tourPointMap);

      tourPointDrawing = new google.maps.drawing.DrawingManager({
      drawingMode: google.maps.drawing.OverlayType.POLYLINE,
      drawingControl: true,

      drawingControlOptions: {
        position: google.maps.ControlPosition.TOP_RIGHT,
        // drawingModes: ['circle', 'polygon', 'polyline', 'rectangle']
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
        fillOpacity: 0.3,
        strokeWeight: 5,
        clickable: false,
        editable: true,
        zIndex: 1
     }
    });

    tourPointDrawing.setMap(tourPointMap);



      tourPointMap.addListener('click', function(event) {
        if (markers.length === 0) {
        console.log(markers.length);
        addMarker(event.latLng);
        }
      });


  }

  $("#remove-drawing").click(removeDrawing);

  function removeDrawing() {
    // console.log("hahha");
    initMap();
    markers = [];

  }

  function addMarker(location) {

  var marker = new google.maps.Marker({
    position: location,
    map: tourPointMap,
    // draggable: true
  });
  console.log(marker.getPosition());
  $("#tourpoint_tour_point_laglng").val( marker.getPosition().toString() );
  markers.push(marker);
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

//map------------------------------------------------------------------------------------------

});
