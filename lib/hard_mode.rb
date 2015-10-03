require 'outputs'
require 'validate'

class HardMode
	def initialize(gameboard, player_turn, player_marker)
		@output = Outputs.new()
		@validate = Validate.new()
		@gameboard = gameboard
		@player_moves = []
		@computer_moves = []
		@player_turn = player_turn
		@player_marker = player_marker
		@possible_turn = [1,2,3,4,5,6,7,8,9]
		@bestchoice
		player_marker == "X" ? @computer_marker = "O" : @computer_marker = "X"
		run_game
	end
	def run_game
		@scores = {1=>0, 2=>0, 3=>0, 4=>0, 5=>0, 6=>0, 7=>0, 8=>0, 9=>0}
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
		while @possible_turn.length > 0 && @validate.validate_winner(@computer_moves) != true 
			duplicate_board = {}
			@gameboard.each do |key, value|
				duplicate_board[key] = value
			end
			test = @validate.validate_vertical_blocker(@player_moves, @possible_turn)
			if @validate.validate_diagnol_blocker(@player_moves, @possible_turn) && @validate.validate_diagnol_blocker(@player_moves, @possible_turn).kind_of?(Array) == false
				move = []
				move = @validate.validate_diagnol_blocker(@player_moves, @possible_turn)
				@possible_turn.delete(move)
				@player_turn = "Y"
				@gameboard[move] = @computer_marker
				@computer_moves.push(move[-1])
				@validate.validate_winner(@computer_moves) ? @output.print_game_over(@gameboard, @player_turn) : run_game
			elsif @validate.validate_vertical_blocker(@player_moves, @possible_turn) && @validate.validate_vertical_blocker(@player_moves, @possible_turn).kind_of?(Array) == false
				move = []
				move = @validate.validate_vertical_blocker(@player_moves, @possible_turn)
				@possible_turn.delete(move)
				@player_turn = "Y"
				@gameboard[move] = @computer_marker
				@computer_moves.push(move[-1])
				@validate.validate_winner(@computer_moves) ? @output.print_game_over(@gameboard, @player_turn) : run_game
			elsif @validate.validate_horizontal_blocker(@player_moves, @possible_turn) && @validate.validate_horizontal_blocker(@player_moves, @possible_turn).kind_of?(Array) == false
				move = []
				move = @validate.validate_horizontal_blocker(@player_moves, @possible_turn)
				@possible_turn.delete(move)
				@player_turn = "Y"
				@gameboard[move] = @computer_marker
				@computer_moves.push(move[-1])
				@validate.validate_winner(@computer_moves) ? @output.print_game_over(@gameboard, @player_turn) : run_game
			else
				minimax(duplicate_board, @player_turn)
				@possible_turn.delete(@bestchoice[0])
				@player_turn = "Y"
				@gameboard[@bestchoice[0]] = @computer_marker
				@computer_moves.push(@bestchoice[0])
				@validate.validate_winner(@computer_moves) ? @output.print_game_over(@gameboard, @player_turn) : run_game
			end
		end
		return
	end
	def minimax(gameboard, player_turn)
		player_moves = []
		computer_moves = []
		available_space = []
		gameboard.each do |space, value|
			if value == @player_marker
				player_moves.push(space)
			elsif value == @computer_marker
				computer_moves.push(space)
			else
				available_space.push(space)
			end
		end
		return score(player_moves, computer_moves) if @validate.validate_winner(computer_moves) || @validate.validate_winner(player_moves)
		available_space.each do |space|
			duplicate_gameboard = gameboard
			if player_turn == "Y"
				duplicate_gameboard[space] = @player_marker
				player_turn == "N"
				if minimax(duplicate_gameboard, player_turn) != nil
					@scores[space] = @scores[space] + minimax(duplicate_gameboard, player_turn)
				else
					minimax(duplicate_gameboard, player_turn)
				end
			else 
				duplicate_gameboard[space] = @computer_marker
				player_turn == "Y"
				if minimax(duplicate_gameboard, player_turn) != nil
					@scores[space] = @scores[space] + minimax(duplicate_gameboard, player_turn)
				else
					minimax(duplicate_gameboard, player_turn)
				end
			end
		end
		@bestchoice = best_move(player_turn, @scores)
	end
	def best_move(player_turn, scores)
		scores.max_by { |_k, v| v}
	end
	def score(player_moves, computer_moves)
		if @validate.validate_winner(computer_moves)
			return 10
		elsif @validate.validate_winner(player_moves)
			return -10
		else
			return 0
		end
	end		
	def ai_board_score(possible_turns)
		@board_score = {}
		possible_turns.each do |possible_turn|
			@board_score[possible_turn] = 0
		end
	end
end