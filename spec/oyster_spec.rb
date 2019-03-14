# frozen_string_literal: true

require 'oyster'

describe Oyster do
  let(:station1) { double :station1 }
  let(:station2) { double :station2 }

  it "doesn't have a balance bigger than 0 when initialized" do
    expect(subject.balance).to eq 0
  end

  context 'topping up' do
    it '.top_up' do
      subject.top_up(20)
      expect(subject.balance).to eq 20
      # expect { subject.top_up }.to change {subject.balance}.by(20)
    end

    it 'stops topping up if balance reached maximum limit: 90' do
      subject.top_up(Oyster::MAXIMUM_LIMIT)
      expect { subject.top_up(1) }.to raise_error "Can't top up: Maximum limit of #{Oyster::MAXIMUM_LIMIT} reached"
    end
  end

  # context "topping down" do
  #
  #   it ".deduct" do
  #     subject.top_up(50)
  #     expect { subject.deduct(1) }.to change {subject.balance}.by(-1)
  #   end
  #
  # end

  context 'usage' do
    # before(:each) do
    #   subject = Oyster.new
    #   subject.top_up(5)
    # end

    it '.touch_in' do
      subject.top_up(5)
      expect { subject.touch_in(station1) }.to change { subject.in_journey? }.to be true
    end

    it '.touch_out(station2)' do
      subject.top_up(5)
      subject.touch_in(station1)
      expect { subject.touch_out(station2) }.to change { subject.in_journey? }.to be false
    end

    it '.in_journey?' do
      subject.top_up(5)
      subject.touch_in(station1)
      expect(subject.in_journey?).to be true
    end
  end

  context 'Money focused methods' do
    it 'raises an error if there are insufficient funds' do
      Oyster.new
      expect { subject.touch_in(station1) }.to raise_error('Insufficient Funds')
    end

    it 'deducts minimum fare when touch_out(station2) is called' do
      subject.top_up(5)
      subject.touch_in(station1)
      expect { subject.touch_out(station2) }.to change { subject.balance }.by(-Oyster::MINIMUM_FARE)
    end
  end

  context 'Remembering the Station' do
    it 'stores the entry station' do
      subject.top_up(5)
      subject.touch_in(station1)
      expect(subject.entry_station).to eq station1
    end

    it 'removes the entry station' do
      subject.top_up(5)
      subject.touch_in(station1)
      subject.touch_out(station2)
      expect(subject.entry_station).to eq nil
    end

    it 'checks that a new card has an empty travel journey.' do
      expect(subject.journeys).to eq []
    end

    it 'Oyster responds to the touch_out(station2) method with one argument ' do
      expect(subject).to respond_to(:touch_out).with(1).argument
    end

    # it 'stores an exit station upon touch_out' do
    #   subject.top_up(Oyster::MAXIMUM_LIMIT)
    #   subject.touch_in(station1)
    #   subject.touch_out(station2)
    #   expect(subject.exit_station).to eq station2
    # end

    it 'stores journey history' do
      subject.top_up(Oyster::MAXIMUM_LIMIT)
      subject.touch_in(station1)
      subject.touch_out(station2)
      expect(subject.journeys).to eq [{station1 => station2}]
    end
  end


end
