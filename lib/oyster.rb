# frozen_string_literal: true

class Oyster
  MAXIMUM_LIMIT = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :status, :entry_station, :journeys, :exit_station

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
    @journeys = []
  end

  def top_up(value)
    raise "Can't top up: Maximum limit of #{MAXIMUM_LIMIT} reached" if check_top_up(value)

    @balance += value
  end

  def touch_in(station)
    raise 'Insufficient Funds' if @balance < 1
    @entry_station = station

  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journeys << {@entry_station => station}
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  private

  def check_top_up(value)
    (@balance + value) > MAXIMUM_LIMIT
  end

  def deduct(value)
    @balance -= value
  end
end
