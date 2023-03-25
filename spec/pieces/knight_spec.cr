require "../spec_helper"


describe Chess::Knight do
  context "in an empty board" do
    knight = Chess::Knight.make_black
    board = BoardFactory.empty_with_piece_in_the_middle_of_board(knight)

    expected_target_positions = [
      {1, 2},
      {1, 4},
      {2, 1},
      {2, 5},
      {4, 1},
      {4, 5},
      {5, 2},
      {5, 4},
    ]

    expected_target_positions.each do |expected|
      it "should be able to move to position #{expected}" do
        knight.possible_moves(board).should contain(expected)
      end
    end
  end

  context "completely surrounded by pieces of the same color" do
    knight = Chess::Knight.make_black
    board = BoardFactory.piece_completely_surrounded(knight)

    expected_target_positions = [
      {1, 1},
      {2, 2},
      {1, 5},
      {2, 4},
    ]

    expected_target_positions.each do |expected|
      it "should jump over the pieces to position #{expected}" do
        knight.possible_moves(board).should contain(expected)
      end
    end
  end

  context "completely surrounded by pieces (different colors)" do
    knight = Chess::Knight.make_black
    board = BoardFactory.piece_surrounded_with_different_colors(knight)

    expected_target_positions = [
      {1, 1},
      {2, 2},
      {1, 5},
      {2, 4},
    ]

    expected_target_positions.each do |expected|
      it "should jump over the pieces to #{expected}" do
        knight.possible_moves(board).should contain(expected)
      end
    end
  end

  context "with different possible moves" do
    knight = Chess::Knight.make_white
    board = BoardFactory.piece_with_several_possible_moves(knight)

    it "should have 7 possible movements" do
      knight.possible_moves(board).size.should eq(7)
    end
  end

  it "should return a value of 3" do
    knight = Chess::Knight.make_black
    knight.value.should eq(3)
  end
end
