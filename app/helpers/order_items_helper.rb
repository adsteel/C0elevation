	module OrderItemsHelper

		require 'numbers_in_words'
		require 'numbers_in_words/duck_punch'

		class PriceLine
			def initialize(key, value)
		  	@first_key, @second_key 		= key, key
		  	@first_value, @second_value = value, value
			end

			# checkers

			def multiple_values?
				@first_value != @second_value
			end

			def multiple_keys?
				@first_key != @second_key
			end

			# update variable values

			def update_second_key_value(key, value)
				@second_key   = key
				@second_value = value
			end

      def to_formatted_html
				@first_key = @first_key.in_numbers.to_i.ordinal
				@second_key = @second_key.in_numbers.to_i.ordinal
				multiple_values? ? suffix = "" : suffix = "<span class=\"\">" + " /ea"

        def range
          "<span class=\"smaller-span\">" + @first_key + " - " + @second_key + "</span> "
        end
        
        def single
         "<span class=\"smaller-span\">" + @first_key + " person" + "</span> "
        end

				if multiple_keys?
			  	range.html_safe  + "$" + @first_value.to_s + suffix.html_safe
			  else
			  	single.html_safe + "$" + @first_value.to_s 
			  end       
      end
		end

	  def price_lines(trip)
	  	@price_lines = Array.new
	  	cols = TripCost::COSTCOLUMNS.reject { |col| col.in_numbers > trip.max }
	  	trip_cost = trip.trip_costs.last

	  	cols.each_with_index do |col, i|

	  		#set up variables
	  		i == 0 ? prior_key = nil : prior_key = cols[i-1]
	  		prior_key ? prior_value = trip_cost.send(prior_key) : prior_value = nil

	  		curr_key = col 
	  		curr_value = trip_cost.send(col)

	  		cols[i+1] ? next_key = cols[i+1] : next_key = nil
	  		next_key ? next_value = trip_cost.send(next_key) : next_key = nil

	  		if prior_key == nil || (prior_value != curr_value && curr_value != 0 ) 
	  			@line = PriceLine.new(curr_key, curr_value)
	  		elsif prior_value == curr_value || curr_value == 0
	  			@line.update_second_key_value(curr_key, curr_value)
	  		end

	  		if next_value != 0 && next_value != curr_value
	  			@price_lines << @line.to_formatted_html
	  		end
	  	end

	  	if @price_lines.length == 1
	  		@price_lines = [number_to_currency(trip_cost.send(cols[0]), precision: 0) + " per person"]
	  	end

	  	return @price_lines
		end

	end


