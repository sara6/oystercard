# require_relative 'station'
# require_relative 'journey'

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1
  PENALTY_FARE = 6

 attr_reader :balance, :history, :journey, :entry_station

  def initialize(journey_klass = Journey)
    @balance = 0
    @history = []
    @journey = journey_klass
  end

  def top_up amount
    fail "Balance has exceeded limit of #{MAXIMUM_BALANCE}" if amount + @balance > MAXIMUM_BALANCE
    @balance += amount
  end


  def touch_in(entry_station)
    fail "Insufficient funds" if top_up_needed?
    unless @entry_station.nil?
      deduct(PENALTY_FARE)
      @history << @current_trip.current_journey
    end
    @entry_station = entry_station
    @current_trip = @journey.new
    @current_trip.start_journey(entry_station)
  end


  def touch_out(exit_station)
    if @current_trip.nil?
      @current_trip = @journey.new
    end
    @current_trip.end_journey(exit_station)
    deduct(@current_trip.calculate_fare)
    @history << @current_trip.current_journey
    @entry_station = nil
  end


  def top_up_needed?
    @balance <= MINIMUM_BALANCE
  end


  # private

  def deduct amount
    @balance -= amount
  end


end
