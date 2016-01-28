require 'Oystercard'

#HEATHER - WE HAVEN'T ISOLATED THESE TESTS FROM JOURNEY CLASS.
# JUST SO YOU KNOW TOMORROW WHEN YOU PAIR WITH ANYBODY AND THEY GO 'WTF'?
# BASICALLY, WE NEED A HELLISH DAY OF MOCKING AND STUBBING

describe Oystercard do

  subject(:oystercard) {described_class.new }
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}

# THESE ARE SO I CAN CHECK THE JOURNEY RETURNED IS RIGHT FROM JOURNEY HISTORY

  let(:current_trip) { {entry: entry_station, exit: exit_station} }
  let(:incomplete_in_only_trip) {{entry: entry_station}}
  let(:incomplete_out_only_trip) {{exit: exit_station}}

# GET RID OF MAGIC NUMBERS LIKE THIS :)
  let(:standard_topup) {10}
  let(:too_big_topup) {91}

describe '#initialize' do

    it { is_expected. to respond_to{:balance}}

    it 'initializes with 0 balance and an empty history' do
      expect(oystercard.balance).to eq 0
      expect(oystercard.history).to be_empty
    end
  end

  describe '#top up' do

    it {is_expected.to respond_to(:top_up).with(1).argument }

    it 'can be topped up' do
      expect{ oystercard.top_up standard_topup }.to change{ oystercard.balance }.by standard_topup
    end


    it 'top up cannot allow balance to exceed £90' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      expect{oystercard.top_up(too_big_topup)}.to raise_error "Balance has exceeded limit of #{Oystercard::MAXIMUM_BALANCE}"
    end

  end


  describe '#touch in' do

    before do
      oystercard.top_up standard_topup
    end

    it 'raises an error if balance is less than 1' do
      9.times do
        oystercard.touch_in(entry_station)
        oystercard.touch_out(exit_station)
      end
      expect{oystercard.touch_in(entry_station)}.to raise_error "Insufficient funds"
    end

  end


  describe '#touch_out' do

    it { is_expected.to respond_to(:touch_out).with(1).argument }

    before do
      oystercard.top_up(standard_topup)
      oystercard.touch_in(entry_station)
    end

    it 'deduct by minimum fare' do
      expect{oystercard.touch_out(exit_station)}.to change {oystercard.balance}.by(-Oystercard::MINIMUM_BALANCE)
    end

    it 'resets entry station to nil when touched out' do
      oystercard.touch_out(exit_station)
      expect(oystercard.entry_station).to be nil
    end

  end

  describe '#history' do

    before do
      oystercard.top_up standard_topup
    end

    it 'stores in #history the details of a complete journey' do
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.history).to include current_trip
    end

    it 'stores in #history an incomplete journey when touched in twice consecutively' do
      2.times do
        oystercard.touch_in(entry_station)
      end
      expect(oystercard.history).to include incomplete_in_only_trip
    end

    it 'stores in #history an incomplete journey when touched out twice consecutively' do
      2.times do
        oystercard.touch_out(exit_station)
      end
      expect(oystercard.history).to include incomplete_out_only_trip

    end

  end

end
