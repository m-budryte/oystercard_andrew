require 'station'

describe Station do
  let(:name) { double :name }
  let(:zone) { double :zone }

  it 'has a name and a zone' do
    station = Station.new(:name, :zone)
    expect(station).to respond_to(:name , :zone)
  end
end
