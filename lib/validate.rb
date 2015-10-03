require 'outputs'

class Validate
	def initialize()
	end
	def validate_mode(input)
		if input.upcase == "E" || input.upcase == "H"
			return true
		else
			return false
		end
	end
	def validate_marker(input)
		if input.upcase == "X" || input.upcase == "O"
			return true 
		else
			return false
		end
	end
	def validate_player_turn(input)
		if input.upcase == "Y" || input.upcase == "N"
			return true
		else 
			return false
		end
	end
	def validate_player_move_input(player_input, possible_turns)
		player_input = player_input.to_i
		if player_input > 0 && player_input <10 
			possible_turns.each do |possible_turn|
				if possible_turn == player_input
					return true
				end
			end
			return false
		else
			return false
		end
	end
	def validate_winner(moves)
		moves = moves.sort
		if moves.length > 2
			if validate_horizontal_winner(moves) 
				return true
			else
				if validate_vertical_winner(moves)
					return true
				else
					if validate_diagnol_winner(moves)
						return true 
					else
						return false
					end 
				end
			end
		else
			return false
		end
	end
	def validate_blocker(moves)
		moves = moves.sort
		if moves.length > 1
			if validate_horizontal_blocker(moves) 
				return validate_horizontal_blocker(moves)
			else
				if validate_vertical_blocker(moves)
					return validate_vertical_blocker(moves)
				else
					if validate_diagnol_blocker(moves)
						return validate_diagnol_blocker(moves) 
					else
						return false
					end 
				end
			end
		else
			return false
		end
	end
	def validate_horizontal_winner(possible_winner)
		possible_winner.each do |number_first|
			if number_first == 1
				possible_winner.each do |number_second|
					if number_second == 2
						possible_winner.each do |number_third|
							if number_third == 3
								return true 
							end
						end
					end
				end
			elsif number_first == 4
				possible_winner.each do |number_second|
					if number_second == 5
						possible_winner.each do |number_third|
							if number_third == 6
								return true 
							end
						end
					end
				end
			elsif number_first == 7
				possible_winner.each do |number_second|
					if number_second == 8
						possible_winner.each do |number_third|
							if number_third == 9
								return true 
							end
						end
					end
				end
			else
				return false
			end
		end
	end
	def validate_vertical_winner(possible_winner)
		possible_winner.each do |number_first|
			if number_first == 1
				possible_winner.each do |number_second|
					if number_second == 4
						possible_winner.each do |number_third|
							if number_third == 7
								return true 
							end
						end
					end
				end
			elsif number_first == 2
				possible_winner.each do |number_second|
					if number_second == 5
						possible_winner.each do |number_third|
							if number_third == 8
								return true 
							end
						end
					end
				end
			elsif number_first == 3
				possible_winner.each do |number_second|
					if number_second == 6
						possible_winner.each do |number_third|
							if number_third == 9
								return true 
							end
						end
					end
				end
			else
				return false
			end
		end
	end
	def validate_diagnol_winner(possible_winner)
		possible_winner.each do |number_first|
			if number_first == 1
				possible_winner.each do |number_second|
					if number_second == 5
						possible_winner.each do |number_third|
							if number_third == 9
								return true 
							end
						end
					end
				end
			elsif number_first == 3
				possible_winner.each do |number_second|
					if number_second == 5
						possible_winner.each do |number_third|
							if number_third == 7
								return true 
							end
						end
					end
				end
			else 
				return false
			end
		end
	end
	def validate_horizontal_blocker(possible_winner, possible_turn)
		if possible_winner.length > 1
			possible_turn.each do |number_first|
				if number_first == 1 || number_first == 2 || number_first == 3
					possible_number = [1,2,3]
					return_number = number_first
					possible_number.delete(number_first)
					possible_winner.each do |number_second|
						if number_second == possible_number[0] || number_second == possible_number[1]
							possible_number.delete(number_second)
							possible_winner.each do |number|
								if number == possible_number[0]
									return return_number
								end
							end
						end
					end
				elsif number_first == 4 || number_first == 5 || number_first == 6
					possible_number = [4,5,6]
					return_number = number_first
					possible_number.delete(number_first)
					possible_winner.each do |number_second|
						if number_second == possible_number[0] || number_second == possible_number[1]
							possible_number.delete(number_second)
							possible_winner.each do |number|
								if number == possible_number[0]
									return return_number
								end
							end
						end
					end
				elsif number_first == 7 || number_first == 8 || number_first == 9
					possible_number = [7,8,9]
					return_number = number_first
					possible_number.delete(number_first)
					possible_winner.each do |number_second|
						if number_second == possible_number[0] || number_second == possible_number[1]
							possible_number.delete(number_second)
							possible_winner.each do |number|
								if number == possible_number[0]
									return return_number
								end
							end
						end
					end
				else
					return false
				end
			end
		else
			return false
		end
	end
	def validate_vertical_blocker(possible_winner, possible_turn)
		if possible_winner.length > 1
			possible_turn.each do |number_first|
				if number_first == 1 || number_first == 4 || number_first == 7
					possible_number = [1,4,7]
					return_number = number_first
					possible_number.delete(number_first)
					possible_winner.each do |number_second|
						if number_second == possible_number[0] || number_second == possible_number[1]
							possible_number.delete(number_second)
							possible_winner.each do |number|
								if number == possible_number[0]
									return return_number
								end
							end
						end
					end
				elsif number_first == 2 || number_first == 5 || number_first == 8
					possible_number = [2,5,8]
					return_number = number_first
					possible_number.delete(number_first)
					possible_winner.each do |number_second|
						if number_second == possible_number[0] || number_second == possible_number[1]
							possible_number.delete(number_second)
							possible_winner.each do |number|
								if number == possible_number[0]
									return return_number
								end
							end
						end
					end
				elsif number_first == 3 || number_first == 6 || number_first == 9
					possible_number = [3,6,9]
					return_number = number_first
					possible_number.delete(number_first)
					possible_winner.each do |number_second|
						if number_second == possible_number[0] || number_second == possible_number[1]
							possible_number.delete(number_second)
							possible_winner.each do |number|
								if number == possible_number[0]
									return return_number
								end
							end
						end
					end
				else
					return false
				end
			end
		else
			return false
		end
	end
	def validate_diagnol_blocker(possible_winner, possible_turn)
		if possible_winner.length > 1
			possible_turn.each do |number_first|
				if number_first == 1 || number_first == 5 || number_first == 9
					possible_number = [1,5,9]
					return_number = number_first
					possible_number.delete(number_first)
					possible_winner.each do |number_second|
						if number_second == possible_number[0] || number_second == possible_number[1]
							possible_number.delete(number_second)
							possible_winner.each do |number|
								if number == possible_number[0]
									return return_number
								end
							end
						end
					end
				elsif number_first == 3 || number_first == 5 || number_first == 7
					possible_number = [3,5,7]
					return_number = number_first
					possible_number.delete(number_first)
					possible_winner.each do |number_second|
						if number_second == possible_number[0] || number_second == possible_number[1]
							possible_number.delete(number_second)
							possible_winner.each do |number|
								if number == possible_number[0]
									return return_number
								end
							end
						end
					end
				
					return false
				end
			end
		else
			return false
		end
	end
end