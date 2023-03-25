require "./spec_helper"


describe Chess::Piece do
  context "depending on the color of the piece" do
    it "should get white color" do
      subject = PieceFactory.random_class.make_white
      subject.color.should eq(Chess::Color::White)
    end

    it "should get black color" do
      subject = PieceFactory.random_class.make_black
      subject.color.should eq(Chess::Color::Black)
    end
  end

  it "should be able to set a position" do
    subject = PieceFactory.random_class.make_black
    subject.position = {1, 2}
    subject.position.should eq({1, 2})
  end
end
