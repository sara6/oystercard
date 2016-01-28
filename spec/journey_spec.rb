require 'journey'

describe Journey do

subject(:journey) { described_class.new }
let(:entry_station) {double :entry_station}
let(:exit_station) {double :exit_station}

  describe 'initialize' do

    it 'initializes with an empty hash' do
    expect(journey.current_journey).to eq ({})
    end

  end

  describe 'start_journey' do

    it 'remember a start station' do
      journey.start_journey entry_station
      expect(journey.current_journey[:entry]).to eq (entry_station)
    end

  end

  describe 'end_journey' do

    it 'remembers an exit station' do
      journey.start_journey entry_station
      journey.end_journey(exit_station)
      expect(journey.current_journey[:exit]).to eq (exit_station)
    end

  end

  describe 'current_journey' do

  let(:current_trip) {{entry: entry_station, exit: exit_station}}

    it 'stores both exit and entry stations' do
      journey.start_journey entry_station
      journey.end_journey exit_station
      expect(journey.current_journey).to eq current_trip
    end
  end

  describe 'completed' do
    it { is_expected.to respond_to(:completed?) }

    it 'returns true if has both entry and exit journey' do
      journey.start_journey entry_station
      journey.end_journey exit_station
      expect(journey.completed?).to be true
    end
  end

  describe 'calculate fare' do

    it 'deducts a penalty charge if the user does not touch out' do
      journey.start_journey entry_station
      expect(journey.calculate_fare).to eq Journey::PENALTY_FARE
    end

    it 'deducts a penalty charge if the user does not touch in' do
      journey.end_journey exit_station
      expect(journey.calculate_fare).to eq Journey::PENALTY_FARE
    end

    it 'deducts normal fare if user touches in and out' do
      journey.start_journey entry_station
      journey.end_journey exit_station
      expect(journey.calculate_fare).to eq Journey::MINIMUM_CHARGE
    end

  end

end
