module StaticPagesHelper
  
  def square_right(trip, text_color = "black-text", overlay_color = "overlay-white")
		content_tag :div, class: "col-sm-4 item" do
      image_tag(trip.primary_image_url(:medium)) +
      content_for_display(trip, text_color, overlay_color)
    end
  end
  
  def long_right(trip, text_color = "black-text", overlay_color = "overlay-white")
    content_tag :div, class: "col-sm-8 item" do
      image_tag(trip.primary_image_url(:medium), class: "visible-xs") +
      image_tag(trip.banner_image_url, class: "hidden-xs") +
      content_for_display(trip, text_color, overlay_color)
    end
  end
  
  def content_for_display(trip, text_color, overlay_color)
    text_box_class = "text-box bottom-right " + text_color
    link_to new_trip_order_item_path(trip), class: text_color do
      content_tag(:div, "", class: "overlay " + overlay_color) + 
      content_tag(:div, class: text_box_class ) do
        concat content_tag(:h1, trip.title)
        concat content_tag(:p, trip.one_liner, class: "hidden-xs")
        #concat link_to to_trip_button, new_trip_order_item_path(trip), class: "btn btn-info"
        concat arrow
      end
    end
  end
  
  def to_trip_button
    string = "" + content_tag(:i, "", class: "fa fa-angle-double-right fa-2x")
    return string.html_safe
  end
  
  def arrow
    image = content_tag(:i, "", class: "fa fa-angle-double-right fa-2x")
    content_tag(:div, image, class: "arrow-circle" )
  end

end