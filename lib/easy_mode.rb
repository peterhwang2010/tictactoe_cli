require 'outputs'
require 'validate'

class EasyMode
	def initialize(gameboard, player_turn, player_marker)
		@output = Outputs.new()
		@validate = Validate.new()
		@gameboard = gameboard
		@player_moves = []
		@computer_moves = []
		@player_turn = player_turn
		@player_marker = player_marker
		@possible_turn = [1,2,3,4,5,6,7,8,9]
		player_marker == "X" ? @computer_marker = "O" : @computer_marker = "X"
		run_game
	end
	def run_game 
		@output.print_board(@gameboard)
		@player_turn.upcase == "Y" ? players_turn : computers_turn
	end
	def players_turn
		@output.print_draw if @possible_turn.length == 0 
		@output.print_players_turn(@player_marker)
		player_input = gets.chomp
		if @validate.validate_player_move_input(player_input, @possible_turn) 
			player_input = player_input.to_i
			@possible_turn.delete(player_input)
			@player_turn = "N"
			@gameboard[player_input] = @player_marker
			@player_moves.push(player_input)
			@validate.validate_winner(@player_moves) ? @output.print_game_over(@gameboard, @player_turn) : run_game
		else
			@output.print_invalid
			players_turn
		end
	end
	def computers_turn 
		@output.print_draw if @possible_turn.length == 0 
		random_move_generator = @possible_turn[rand(@possible_turn.length-1)]
		@possible_turn.delete(random_move_generator)
		@player_turn = "Y"
		@gameboard[random_move_generator] = @computer_marker
		@computer_moves.push(random_move_generator)
		@validate.validate_winner(@computer_moves) ? @output.print_game_over(@gameboard, @player_turn) : run_game
	end
end