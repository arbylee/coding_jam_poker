class Hand
  HIGH_CARD = 0
  PAIR = 1
  TWO_PAIR = 2
  THREE_OF_A_KIND = 3
  include Comparable

  def <=> other_hand
    if self.highest_hand > other_hand.highest_hand
      return 1
    elsif self.highest_hand == other_hand.highest_hand
      return 0
    else
      return -1
    end
  end

  def initialize(cards)
    @cards = cards
  end

  def pair?
    if @cards.size == 2
      return @cards[0].value == @cards[1].value
    end
  end

  def two_pair?
    if @cards.size == 4
      sorted = @cards.sort_by {|card| card.value }
      return sorted[0].value == sorted[1].value && sorted[2].value == sorted[3].value
    end
  end

  def three_of_a_kind?
    # if @cards.size == 3
    #   return @cards[0].value == @cards[1].value && @cards[1].value == @cards[2].value
    # end

    values = @cards.map do |card|
      card.value
    end

    values.any? do |value|
      values.count(value) == 3
    end
  end

  def highest_hand
    case
    when self.three_of_a_kind?
      return THREE_OF_A_KIND
    when self.two_pair?
      return TWO_PAIR
    when self.pair?
      return PAIR
    else
      return HIGH_CARD
    end
  end
end