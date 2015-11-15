$ ->
	address = $('#map').data('address')
	# geocoderのインスタンス化
	geocoder = new google.maps.Geocoder()
	# geocodeメソッドを実行
	geocoder.geocode { 'address': address }, (results, status)->
		# ステータスが正しかった場合
		if (status == google.maps.GeocoderStatus.OK)
			# 緯度経度取得
			latlng = results[0].geometry.location
			# オプションの設定
			options = { zoom: 15, center: latlng }
			# マップの表示
			map = new google.maps.Map(document.getElementById('map'), options)
			# マーカーを表示
			marker = new google.maps.Marker({
				# マーカーの位置
				position: map.getCenter(),
				# 描画先
				map: map
				})
		# エラーが発生した場合
		else
			console.log('マップを取得できませんでした')
