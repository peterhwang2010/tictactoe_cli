require 'console'
require 'validate'

class Outputs
	def initialize
		@validate = Validate.new()

	end
	def print_initial_outputs
		puts "TicTacToe Game\n\n\n"
	end
	def print_type_of_game_mode
		puts "Press E if you want to play easy mode and press H is you want to play hard mode"
	end
	def print_type_of_player_marker
		puts "Press X if you want to be X and O to be an O"
	end
	def print_invalid
		puts "Invalid input!"
	end
	def print_board(board_object)
		puts "The Game Board \n  #{board_object[1]} | #{board_object[2]} | #{board_object[3]} \n ------------ \n  #{board_object[4]} | #{board_object[5]} | #{board_object[6]} \n ------------ \n  #{board_object[7]} | #{board_object[8]} | #{board_object[9]}"
	end
	def print_ask_turn
		puts "Do you want to go first? (Y/N)"
	end
	def print_players_turn(marker)
		puts "It is your turn. Enter # where you want to place #{marker}."
	end
	def print_game_over(gameboard, player_turn)
		puts "Game Over!"
		print_board(gameboard)
		if player_turn == "Y"
			puts "Your a loser!"
			print_play_again
			input = gets.chomp
			if @validate.validate_player_turn(input)
				Console.new() if input.upcase == "Y"
			else
				exit
			end
		else
			puts "Your a Winner!"
			print_play_again
			input = gets.chomp
			if @validate.validate_player_turn(input)
				Console.new() if input.upcase == "Y"
			else
				exit
			end
		end
	end
	def print_play_again
		puts "Do you want to play again? (Y/N)" 
	end
	def print_draw
		put "Draw Game!"
		print_play_again
		input = gets.chomp
		if @validate.validate_player_turn(input)
			Console.new() if input.upcase == "Y"
		else
			exit
		end
	end
end