require "./spec_helper"


class FakePlayer < Chess::RandomPlayer
  def initialize(@color : Chess::Color, @plays_since_last_capture : Int32)
  end
end


describe Chess::FinishDetector do
  subject = Chess::FinishDetector.new

  describe "#king_captured?" do
    it "should finish when white King is captured" do
      whites = PieceFactory.random_list(5, Chess::Color::White, Chess::King)
      blacks = PieceFactory.random_list(5, Chess::Color::Black)
      blacks << Chess::King.make_black

      subject.reset!
      subject.playable_pieces_white = whites
      subject.playable_pieces_black = blacks

      subject.king_captured?.should be_true
      subject.winner.should eq(Chess::Color::Black)
      subject.reason.should eq("White King captured")
    end

    it "should finish when black King is captured" do
      whites = PieceFactory.random_list(5, Chess::Color::White)
      whites << Chess::King.make_white
      blacks = PieceFactory.random_list(5, Chess::Color::Black, Chess::King)

      subject.reset!
      subject.playable_pieces_white = whites
      subject.playable_pieces_black = blacks

      subject.king_captured?.should be_true
      subject.winner.should eq(Chess::Color::White)
      subject.reason.should eq("Black King captured")
    end

    it "should not finish when both Kings are present" do
      whites = PieceFactory.random_list(5, Chess::Color::White)
      whites << Chess::King.make_white
      blacks = PieceFactory.random_list(5, Chess::Color::Black)
      blacks << Chess::King.make_black

      subject.reset!
      subject.playable_pieces_white = whites
      subject.playable_pieces_black = blacks

      subject.king_captured?.should be_false
      subject.winner.should eq(nil)
      subject.reason.should eq("")
    end
  end

  describe "#player_demands_yield?" do
    it "should finish when white player yields" do
      subject.reset!
      subject.player_white = FakePlayer.new(Chess::Color::White, 45)
      subject.player_black = Chess::RandomPlayer.new(Chess::Color::Black)

      subject.player_demands_yield?.should be_true
      subject.winner.should eq(Chess::Color::Black)
      subject.reason.should eq("White yields")
    end

    it "should finish when black player yields" do
      subject.reset!
      subject.player_black = FakePlayer.new(Chess::Color::Black, 45)
      subject.player_white = Chess::RandomPlayer.new(Chess::Color::White)

      subject.player_demands_yield?.should be_true
      subject.winner.should eq(Chess::Color::White)
      subject.reason.should eq("Black yields")
    end

    it "should not finish when no player demands draw" do
      subject.reset!
      subject.player_black = Chess::RandomPlayer.new(Chess::Color::Black)
      subject.player_white = Chess::RandomPlayer.new(Chess::Color::White)

      subject.player_demands_yield?.should be_false
      subject.winner.should eq(nil)
      subject.reason.should eq("")
    end
  end
end
