class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journeys
  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @entry_station
    @exit_station
    @journeys = []

  end

  def top_up(amount)
    raise "£#{ LIMIT } limit exceeded" if @balance + amount > LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    @entry_station = entry_station
    @journeys << { :start => @entry_station, :end => nil }
  end

  def in_journey?
    if @entry_station != nil
      true
    else
      false
    end
    # why does this work
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @in_journey = false
    @entry_station = nil
    @exit_station = exit_station
    @journeys.last[:end] = @exit_station
  end

  def minimum_fare
    raise "please top-up, minimum fare £#{ MINIMUM_FARE }" if @balance < MINIMUM_FARE
  end

  'private'
  def deduct(amount)
    # Remember to not allow negative values
    @balance -= amount
  end
end

# def in_journey
#   @in_journey
# end
# this is not needed due to having in the attr_reader + def init
