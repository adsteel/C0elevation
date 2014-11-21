module UsersHelper
	def phone_format(number)
		unless number.nil? || number.blank?
			if number.length < 11
		     	"(" + number[0..2] + ") " + number[3..5] + "-" + number[6..9]
		    else
				"(" + number[0..2] + ") " + number[3..5] + "-" + number[6..9] + " ext " + number[10..13]
		    end
	    else
	    	""
	    end
	end

	def make_list(content)
		if content
			made_list = String.new
			content.split("\n").each { |a| made_list << content_tag(:li, a) }
			return made_list.html_safe
		else
			return ""
		end
	end

	def format_meeting_address(trip)
		if trip.meet_address
			address = String.new
			trip.meet_address.split(',').each { |a| address << content_tag(:p, a) }
			return address.html_safe
		end
	end

	def show_cart(cart_items)
		if cart_items.length > 0
			link_to " |&nbsp;&nbsp; My cart (#{@cart_items.length})".html_safe, cart_path(current_user), class: "header-cart"
		else
			""
		end
	end

	def admin_page
		if current_user.admin?
			content_tag :li, (link_to "Admin Dashboard", admin_dashboard_index_path )
		end
	end
end
