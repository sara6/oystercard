class Journey

  attr_reader :current_journey
  # :entry_station, :exit_station,

  PENALTY_FARE = 6
  MINIMUM_CHARGE = 1

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
    if completed?
      MINIMUM_CHARGE
    else
      PENALTY_FARE
    end
  end

  def completed?
    !current_journey[:entry].nil? && !current_journey[:exit].nil?
  end


end



# another way for def complete:
# if current_journey.has_key?(:entry) && current_journey.has_key?(:exit)
#   true
# else
#   false
# end
