// $(function(){
//
// //map------------------------------------------------------------------------------------------
//   var tourPointMapDiv = document.getElementById('tourpointmap');
//
//   if ($.contains(document,tourPointMapDiv) ) {
//
//     var tourPageUrl = "/tours/"+tourId;
//     var tour;
//     var tourpoints = [];
//     $.ajax({
//       method: "GET",
//       url: tourPageUrl,
//       dataType:'json'
//     }).done(function(reponseData){
//       tour = reponseData;
//
//       var tourPointMap = new google.maps.Map(tourPointMapDiv, {
//         zoom: 13,
//         center: {lat: -34.397, lng: 150.644}
//       });
//
//       var rendezvousPoint = tour.rendezvous_point;
//       var country = "Canada";//tour.rendezvous_point;
//       var rendezvousGeocoder = new google.maps.Geocoder();
//
//       geocodeAddress(rendezvousGeocoder, tourPointMap, country,rendezvousPoint, rendezvousPoint);
//
//       var latlng;
//       var latP;
//       var lagP;
//       var markerPosition;
//       var tourPointInfoWindow = new google.maps.InfoWindow();
//       var bounds = new google.maps.LatLngBounds();
//       var marker;
//       var markers = {};
//       var i;
//       var markerPlaced = false;
//       if (tour.tourpoints.length > 0) {
//
//         for (i = 0; i<tour.tourpoints.length;i++) {
//
//           laglng = tour.tourpoints[i].tour_point_laglng;
//           latP = Number(laglng.substring(laglng.indexOf("(")+1,laglng.indexOf(",")-1));
//           lagP = Number(laglng.substring(laglng.indexOf(",")+1,laglng.indexOf(")")-1));
//           markerPosition = {lat:latP,lng:lagP};
//           console.log(markerPosition);
//           marker = markerMaker(markerPosition,tourPointMap,(i+1).toString());
//           markers[marker.label]= tour.tourpoints[i];
//           marker.addListener('click', function () {
//
//             console.log(this);
//             populateInfoWindow(this,markers[this.label],tourPointInfoWindow,tourPointMap);
//           });
//           // bounds.extend(marker.position);
//         }
//       }
//       // showTourMap.fitBounds(bounds);
//       console.log("markerPlaced" + markerPlaced);
//       tourPointMap.addListener('click', function(event) {
//         if (markerPlaced === false) {
//           markerMaker(event.latLng, tourPointMap, (i+1).toString());
//         }
//         markerPlaced = true;
//       });
//
//     }).fail(function(){
//       console.log("fails");
//     });
//   }
//
// //map------------------------------------------------------------------------------------------
//
// });
