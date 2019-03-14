# frozen_string_literal: true
require_relative './station.rb'
require_relative './journey.rb'
class Oyster
  MAXIMUM_LIMIT = 90

  attr_reader :balance, :status, :journeys

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(value)
    raise "Can't top up: Maximum limit of #{MAXIMUM_LIMIT} reached" if check_top_up(value)
    @balance += value
  end

  def touch_in(station, journey = Journey)
    raise 'Insufficient Funds' if @balance < 1
    @journeys << journey.new(station)
  end

  def touch_out(station)
    deduct(Journey::MINIMUM_FARE)
    @journeys[-1].end_journey(station)
  end

  private

  def check_top_up(value)
    (@balance + value) > MAXIMUM_LIMIT
  end

  def deduct(value)
    @balance -= value
  end
end
