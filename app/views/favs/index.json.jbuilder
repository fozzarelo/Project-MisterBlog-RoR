json.array! @favs do |fav|
	json.title fav.post.title
	json.user fav.post.user.full_name
	json.post_id fav.post.id
end
