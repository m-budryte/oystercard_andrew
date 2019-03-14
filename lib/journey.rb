require_relative './station.rb'
class Journey
  attr_reader :entry, :exit
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  def initialize(station)
    @entry = station
  end

  def end_journey(station)
    @exit = station
    self
  end

  def in_journey?
    @entry != nil && @exit == nil
  end

  def fare
    if (@entry && @exit)
      MINIMUM_FARE
    else
      PENALTY_FARE
    end
  end
end
