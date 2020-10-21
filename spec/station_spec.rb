system 'clear'
require 'station'

RSpec.describe Station do
  describe '#station' do
  let(:station) {Station.new(name: "Liverpool Street", zone: 1)}

    it 'knows its name' do
      expect(station.name).to eq ("Liverpool Street")

    end
  end


end
