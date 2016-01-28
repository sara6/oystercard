class Journey

  attr_reader :entry_station, :exit_station, :current_journey

  PENALTY_FARE = 6

  def initialize
    @current_journey = {}
  end

  def start_journey entry_station
    @entry_station = entry_station
    @current_journey[:entry] = entry_station
  end

  def end_journey exit_station
    @exit_station = exit_station
    @current_journey[:exit] = exit_station
  
  end

  def calculate_fare
    PENALTY_FARE
  end


end
