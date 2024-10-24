class Player
	attr_reader :color
	
	def initialize(color)
		@color = color
	end

	def get_input
		print "#{color} - enter your move XX XX: "
		gets.chomp
	end
end