require_relative "../app/hand"
require_relative "../app/card"

describe Hand do
  let(:two_of_hearts) { Card.new(2, 'Hearts')}
  let(:two_of_spades) { Card.new(2, 'Spades')}
  let(:two_of_clubs) { Card.new(2, 'Clubs')}

  describe "pair" do
    it "should know what a pair is" do
      Hand.new([two_of_hearts, two_of_spades]).should be_a_pair
    end

    it "should know what two cards that are not a pair are" do
      three_of_spades = Card.new(3, 'Spades')
      Hand.new([two_of_hearts, three_of_spades]).should_not be_a_pair
    end
  end
  
  describe "two pair" do
    it "should know what two pair is" do
      six_of_hearts = Card.new 6, 'Hearts'
      six_of_spades = Card.new 6, 'Spades'
      Hand.new([two_of_spades, two_of_hearts, six_of_spades, six_of_hearts]).should be_a_two_pair
    end

    it "should know when a hand is not two pair" do
      six_of_hearts = Card.new 6, 'Hearts'
      seven_of_spades = Card.new 7, 'Spades'
      Hand.new([two_of_spades, two_of_hearts, seven_of_spades, six_of_hearts]).should_not be_a_two_pair
    end

    it "should not care about the order of the hand" do
      six_of_spades = Card.new 6, 'Spades'
      six_of_hearts = Card.new 6, 'Hearts'
      Hand.new([two_of_hearts, six_of_spades, six_of_hearts, two_of_spades]).should be_a_two_pair
    end
  end

  describe "three of a kind" do
    it "should know what three of a kind is" do
      Hand.new([two_of_spades, two_of_hearts, two_of_clubs]).should be_a_three_of_a_kind
    end

    it "should recognize three of a kind regardless of hand size" do
      six_of_spades = Card.new 6, 'Spades'
      seven_of_hearts = Card.new 7, 'Hearts'
      Hand.new([two_of_spades,
                two_of_hearts,
                two_of_clubs,
                six_of_spades,
                seven_of_hearts]).should be_a_three_of_a_kind
    end
  end

  describe "comparisons" do
    it "should know three of a kind is greater than a pair" do
      three_of_a_kind = Hand.new([two_of_spades, two_of_hearts, two_of_clubs])
      pair = Hand.new([two_of_spades, two_of_clubs])
      three_of_a_kind.should be > pair
    end

    it "should know that a pair is less than three of a kind" do
      three_of_a_kind = Hand.new([two_of_spades, two_of_hearts, two_of_clubs])
      pair = Hand.new([two_of_spades, two_of_clubs])
      pair.should be < three_of_a_kind
    end

    it "should know that two pair is less than three of a kind" do
      six_of_spades = Card.new 6, 'Spades'
      six_of_hearts = Card.new 6, 'Hearts'
      three_of_a_kind = Hand.new([two_of_spades, two_of_hearts, two_of_clubs])
      two_pair = Hand.new([two_of_spades, two_of_clubs, six_of_hearts, six_of_spades])
      two_pair.should be < three_of_a_kind
    end
  end

  describe "highest hand" do
    it "should know when its a high card" do
      hand = Hand.new([two_of_spades])
      hand.highest_hand.should == Hand::HIGH_CARD
    end

    it "should know when its a pair" do
      hand = Hand.new([two_of_spades, two_of_clubs])
      hand.highest_hand.should == Hand::PAIR
    end

    it "should know when its a two pair" do
      six_of_spades = Card.new(6, 'Spades')
      six_of_clubs = Card.new(6, 'Clubs')
      hand = Hand.new([two_of_spades, two_of_clubs, six_of_clubs, six_of_spades])
      hand.highest_hand.should == Hand::TWO_PAIR
    end

    it "should know when its a three of a kind" do
      hand = Hand.new([two_of_spades, two_of_clubs, two_of_hearts])
      hand.highest_hand.should == Hand::THREE_OF_A_KIND
    end
  end
end


