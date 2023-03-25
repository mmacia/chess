require "../spec_helper"


describe Chess::King do
  context "in an empty board" do
    king = Chess::King.make_white
    board = BoardFactory.empty_with_piece_in_the_middle_of_board(king)

    expected_target_positions = [
      {2, 2},
      {2, 3},
      {2, 4},
      {3, 2},
      {3, 4},
      {4, 2},
      {4, 3},
      {4, 4},
    ]

    expected_target_positions.each do |expected|
      it "should be able to move to position #{expected}" do
        king.possible_moves(board).should contain(expected)
      end
    end
  end

  context "completely surrounded by pieces of the same color" do
    king = Chess::King.make_white
    board = BoardFactory.piece_completely_surrounded(king)

    it "should not be able to move" do
      king.possible_moves(board).should be_empty
    end
  end

  context "completely surrounded by pieces (different colors)" do
    king = Chess::King.make_white
    board = BoardFactory.piece_surrounded_with_different_colors(king)

    it "should capture 2 pieces" do
      king.possible_moves(board).size.should eq(2)
    end
  end

  context "with different possible moves" do
    king = Chess::King.make_white
    board = BoardFactory.piece_with_several_possible_moves(king)

    it "should have 7 possible movements" do
      king.possible_moves(board).size.should eq(7)
    end
  end

  it "should return a value of 0" do
    king = Chess::King.make_white
    king.value.should eq(0)
  end
end
