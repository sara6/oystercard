require 'station.rb'

describe Station do

  subject(:station) {described_class.new(:name, :zone)}
  let(:station) {double :station, name:'Lewisham', zone:3}

  describe '#initialize' do

    it 'initializes with a name' do
      expect(subject.name).to eq 'Lewisham'
    end

    it 'initializes with a zone' do
      expect(subject.zone).to be 3
    end

  end
end
