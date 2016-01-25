require 'oystercard'


describe Oystercard do
	let(:oystercard) { Oystercard.new }

	it 'should have a balance of 0' do
		expect(oystercard.balance).to eq(0)
	end

	describe '#top_up' do

	   	it {is_expected.to respond_to(:top_up).with(1).argument}

	   	it 'should top up the balance' do
	   		oystercard.top_up(10)
	   		expect(oystercard.balance).to eq(10)
	         #above could be written using .to change .by
	   	end

		it 'should raise an error if maximum balance exceeded' do
			maximum_balance = Oystercard::MAXIMUM_BALANCE
			oystercard.top_up(maximum_balance)
			expect { oystercard.top_up(1) }.to raise_error "Cannot top up! Maximum limit #{maximum_balance}!"
		end
	end 


	describe '#deduct money' do

		it {is_expected.to respond_to(:deduct).with(1).argument}

		it 'should deduct the balance' do
			oystercard.deduct(10)
			expect(oystercard.balance).to eq(-10)
		end 
	end 

end
