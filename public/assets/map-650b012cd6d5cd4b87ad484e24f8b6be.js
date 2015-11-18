(function() {
  $(function() {
    var address, geocoder;
    address = $('#map').data('address');
    geocoder = new google.maps.Geocoder();
    return geocoder.geocode({
      'address': address
    }, function(results, status) {
      var latlng, map, marker, options;
      if (status === google.maps.GeocoderStatus.OK) {
        latlng = results[0].geometry.location;
        options = {
          zoom: 15,
          center: latlng
        };
        map = new google.maps.Map(document.getElementById('map'), options);
        return marker = new google.maps.Marker({
          position: map.getCenter(),
          map: map
        });
      } else {
        return console.log('マップを取得できませんでした');
      }
    });
  });

}).call(this);
