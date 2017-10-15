require 'rails_helper'

RSpec.describe Station, type: :model do
  describe ".link" do
    # it 'handles scoring stations in a way that consistency earns points' do
    #   one  = create(:station, lat: 1.111, lon: 2.22220, scores: [create(:score, score: 1)])
    #   two  = create(:station, lat: 1.111, lon: 2.22219, scores: [create(:score, score: -1)])
    #   cost = create(:cost, right_id: 2, left_id: 1, time: 10, distance: 10)
    #   link = Station.find(2).link
    #   binding.pry
    #   expect(link.sid).to eq(3)
    # end
    let(:uptown_pickup) {create(:station, :uptown, scores: [create(:pickup)])}
    let(:downtown_dropoff){ create(:station, :downtown, scores: [create(:dropoff)]) }

    it 'makes reasonable scores for -1 -> 1 stations' do
      cost = create(:cost, right_id: downtown_dropoff.id, left_id: uptown_pickup.id, time: 60, distance: 10)
      link = uptown_pickup.link
      # binding.pry
      expect(link["wage"]).not_to be_nil
      expect(link["costed_distance"]).to eq("10.0")
      expect(link["costed_time"].to_i).to eq(1)
    end

    # uptown_pickup
  end
end
