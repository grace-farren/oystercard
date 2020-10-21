require 'oystercard'

RSpec.describe Oystercard do
let(:oystercard) {Oystercard.new}
let(:entry_station){ double :entry_station }
let(:exit_station){ double :exit_station }

LIMIT = 90
MINIMUM_FARE = 1
#Let creates the object where theres subject it calls,
#oystercard = Oystercard.new
  describe '#balance' do
    it 'checks the default balance' do
      expect(oystercard.balance).to eq(0)

    end
  end

  describe '#top_up' do
    it 'adds money to the oystercard' do
      oystercard.top_up(5)
      expect(oystercard.balance).to eq(5)
    end

    it 'prevents user from topping up more than 90' do
      expect{oystercard.top_up(100)}.to raise_error("£#{ LIMIT } limit exceeded")
    end
  end

  describe '#deduct' do
    it 'deducts a fare from the balance' do
      oystercard.top_up(20)
      oystercard.deduct(3)
      expect(oystercard.balance).to eq(17)
    end
  end

  describe '#in_journey' do
    it 'is not intially in journey' do
      expect(oystercard.in_journey?).to eq false
    end
  end

  describe '#touch_in' do
    it 'checks if card in a journey' do
      oystercard.touch_in(entry_station)
      expect(oystercard.in_journey?).to eq true
    end
  end

  describe '#touch_out' do
    it 'check if card is not in a journey' do
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.in_journey?).to eq false
    end

    it 'deducts the fare from the balance of the card' do
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect { oystercard.touch_out(exit_station) }.to change{ oystercard.balance }.by(-MINIMUM_FARE)
    end
  end

  describe '#minimum fare' do
    it 'prevents journey if balance below minimum fare' do
      oystercard.balance
      expect{oystercard.minimum_fare}.to raise_error("please top-up, minimum fare £#{ MINIMUM_FARE }")
    end
  end

  describe '#journey log' do
    it 'saves the starting station' do
      oystercard.touch_in(entry_station)
      expect(oystercard.entry_station).to eq (entry_station)
    end

    it 'saves the exit station' do
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.exit_station).to eq (exit_station)
    end

    it 'check that a new oystercard has no previous journeys' do
      expect(oystercard.journeys).to be_empty

    end

    it 'shows previous journeys made' do
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.journeys.count).to eq(1)

    end
  end

end
