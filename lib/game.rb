require 'outputs'
require 'validate'
require 'easy_mode'
require 'hard_mode'

class Game
	def initialize(mode, marker)
		@output = Outputs.new()
		@validate = Validate.new()
		@mode = mode 
		@player_marker = marker
		empty_board
		mode == "E" ? easy_mode : hard_mode
	end

	def easy_mode
		@output.print_ask_turn
		player_turn = gets.chomp
		@validate.validate_player_turn(player_turn) ? EasyMode.new(@board, player_turn, @player_marker) : easy_mode
	end
	
	def hard_mode
		@output.print_ask_turn
		player_turn = gets.chomp
		@validate.validate_player_turn(player_turn) ? HardMode.new(@board, player_turn, @player_marker) : hard_mode
	end

	def empty_board
		@board = {1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9"}
	end
end