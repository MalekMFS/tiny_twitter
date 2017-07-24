module ApplicationHelper
	#sets Global app's name
	$APP_NAME = "میم"

	#return full title
	def full_title(page_title = '')
		base_title = $APP_NAME
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end


end
