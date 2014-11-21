module ApplicationHelper
	def full_title(page_title)
		if Rails.env.development?
			base_title = "Development"
    	elsif staging?
    		base_title = "Staging"
    	elsif local_machine? && Rails.env.production?
    		base_title = "** Production **"
    	else
    		base_title = "coElevation"
    	end
    	
    	if page_title.empty?
    		"#{base_title} | Connecting you with outdoor guides "
    	else
      		"#{base_title} | #{page_title} "
    	end
	end 

	def link_linkedin(body)
		'<a href="https://www.linkedin.com/company/3716334" target="blank" >'.html_safe + body.html_safe + '</a>'.html_safe
	end

	def link_facebook(body)
		'<a href="http://www.facebook.com/coelevation" target="blank" class="facebook">'.html_safe + body.html_safe + '</a>'.html_safe
	end

	def link_instagram(body)
		'<a href="http://instagram.com/coelevation" target="blank">'.html_safe + body.html_safe + '</a>'.html_safe
	end

	def link_twitter(body)
		'<a href="http://www.twitter.com/coelevation" target="blank">'.html_safe + body.html_safe + '</a>'.html_safe
	end
  

  
end
