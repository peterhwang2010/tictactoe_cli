require 'outputs'
require 'validate'
require 'game'

class Console
	def initialize()
		@output = Outputs.new()
		@validate = Validate.new() 
		@output.print_initial_outputs
		get_game_mode
	end	
	def get_game_mode
		@output.print_type_of_game_mode
		@game_mode = gets.chomp
		@validate.validate_mode(@game_mode) ? get_player_marker : get_game_mode
	end
	def get_player_marker
		@output.print_type_of_player_marker
		@player_marker = gets.chomp
		if @validate.validate_marker(@player_marker)
			game = Game.new(@game_mode.upcase, @player_marker.upcase)
		else
			get_player_marker
		end
	end
end
