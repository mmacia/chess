require "../spec_helper"

describe Chess::Queen do
  context "in an empty board" do
    queen = Chess::Queen.make_white
    board = BoardFactory.empty_with_piece_in_the_middle_of_board(queen)

    expected_target_positions = [
      {0, 3},
      {1, 3},
      {2, 3},
      {4, 3},
      {5, 3},
      {6, 3},
      {7, 3},
      {3, 0},
      {3, 1},
      {3, 2},
      {3, 4},
      {3, 5},
      {3, 6},
      {3, 7},

      {2, 4},
      {1, 5},
      {0, 6},
      {4, 4},
      {5, 5},
      {6, 6},
      {7, 7},
      {4, 2},
      {5, 1},
      {6, 0},
      {2, 2},
      {1, 1},
      {0, 0},
    ]

    expected_target_positions.each do |expected|
      it "should move to #{expected}" do
        queen.possible_moves(board).should contain(expected)
      end
    end
  end

  context "completely surrounded by pieces of the same color" do
    queen = Chess::Queen.make_white
    board = BoardFactory.piece_completely_surrounded(queen)

    it "should not move at all" do
      queen.possible_moves(board).should be_empty
    end
  end

  context "completely surrounded by pieces (different colors)" do
    queen = Chess::Queen.make_white
    board = BoardFactory.piece_surrounded_with_different_colors(queen)

    it "should capture 2 pieces" do
      queen.possible_moves(board).size.should eq(2)
    end
  end

  context "with different possible moves" do
    queen = Chess::Queen.make_white
    board = BoardFactory.piece_with_several_possible_moves(queen)

    it "should have 18 possible movements" do
      queen.possible_moves(board).size.should eq(18)
    end
  end

  it "should return a value of 9" do
    queen = Chess::Queen.make_black
    queen.value.should eq(9)
  end
end
