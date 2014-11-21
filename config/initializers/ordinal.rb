class Integer
	def ordinal
		cardinal = self.abs
		digit = cardinal%10
		if (1..3).include?(digit) and not (11..13).include?(cardinal%100) 
			self.to_s << %w{st nd rd}[digit-1]
		else
			self.to_s << 'th'
		end
	end
end