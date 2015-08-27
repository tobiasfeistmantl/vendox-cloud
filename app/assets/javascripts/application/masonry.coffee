$ ->
	$grid = $('.grid-product').masonry
		itemSelector: '.grid-item-product',
		isFitWidth: true

	$grid.imagesLoaded().progress ->
		$grid.masonry 'layout'