class TicTacToe
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2],
  ]

  def initialize
    # @board = [' ',' ',' ',' ',' ',' ',' ',' ',' ']

    @board = Array.new(9, ' ')
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts '-----------'
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts '-----------'
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    index = input.to_i - 1
  end

  def move(index, token = 'X')
    @board[index] = token
  end

  def position_taken?(index)
    @board[index] != ' '
  end

  def valid_move?(index)
    index.between?(0, 8) && !position_taken?(index)
  end

  def turn_count
    # empty_cells = []

    # @board.each do |spot|
    #   if spot == ' '
    #     empty_cells << spot
    #   end
    # end
    # turns = 9 - empty_cells.size

    # turns
    @board.count { |spot| spot != ' ' }
  end

  def current_player
    # x_player = @board.count { |spot| spot != 'O' }
    # o_player = @board.count { |spot| spot != 'X' }

    # if x_player > o_player
    #   'O'
    # else
    #   'X'
    # end

    @board.count('X') == @board.count('O') ? 'X' : 'O'
  end

  def turn
    puts 'Please enter a number between 1 and 9:'
    input = gets.strip
    index = input_to_index(input)

    if valid_move?(index)
      token = current_player
      move(index, token)
      display_board
    else
      puts 'Please make a valid move.'
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.each do |combo|
      if @board[combo[0]] == @board[combo[1]] &&
           @board[combo[1]] == @board[combo[2]] && position_taken?(combo[0])
        return combo
      end
    end
    false
  end

  def full?
    @board.all? { |spot| spot == 'X' || spot == 'O' }
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || draw?
  end

  def winner
    WIN_COMBINATIONS.each do |combo|
      if @board[combo[0]] == @board[combo[1]] &&
           @board[combo[1]] == @board[combo[2]] && position_taken?(combo[0])
        return @board[combo[0]]
      end
    end
    nil
  end

  def play
    turn_count = 0

    until over? || turn_count == 9
      turn
      turn_count += 1
    end

    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end

game = TicTacToe.new
game
