class Oystercard

  attr_reader :balance, :in_journey
  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "£#{ LIMIT } limit exceeded" if @balance + amount > LIMIT
    @balance += amount
  end

  def deduct(amount)
    # Remember to not allow negative values
    @balance -= amount
  end

  def in_journey
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def minimum_fare
    raise "please top-up, minimum fare £#{ MINIMUM_FARE }" if @balance < MINIMUM_FARE
  end
end
