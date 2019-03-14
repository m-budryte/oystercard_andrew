require 'journey'
describe Journey do
  before(:each) do
    @station = double :station
    @new_journey = Journey.new(@station)
  end
  # let(:station) { double :station }

  it 'accepts end_journey method' do
    expect(@new_journey).to respond_to(:end_journey).with(1).argument
  end

  it 'has a in_journey? method' do
    expect(@new_journey).to respond_to(:in_journey?)
  end

  it 'saves the entry station when start_journey is called' do

    expect(@new_journey.entry).to eq(@station)
  end

  it 'saves the exit station when end_journey is called' do
    @new_journey.end_journey(@station)
    expect(@new_journey.exit).to eq(@station)
  end

  it 'is in_journey after start_journey' do

    expect(@new_journey).to be_in_journey
  end

  it 'is not in_journey after end_journey' do

    @new_journey.end_journey(@station)
    expect(@new_journey).not_to be_in_journey
  end

  it "has a method called #fare" do
    expect(@new_journey).to respond_to(:fare)
  end

  it "the fare is minimun after the full journey" do

    @new_journey.end_journey(@station)
    expect(@new_journey.fare).to eq(Journey::MINIMUM_FARE)
  end

  it "penalty fare if no exit station" do

    expect(@new_journey.fare).to eq(Journey::PENALTY_FARE)
  end

end
