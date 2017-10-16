require 'rails_helper'

RSpec.describe Station, type: :model do
  describe ".link" do
    it 'makes reasonable scores for -1 -> 1 stations' do
      uptown_pickup = create(:station, :uptown, scores: [create(:pickup)])
      downtown_dropoff = create(:station, :downtown, scores: [create(:dropoff)]) 
      cost = create(:cost, right_id: downtown_dropoff.id, left_id: uptown_pickup.id, time: 60, distance: 10)
      links = Station.links
      expect(links.length).to eq(1)
      link = links[0]
      expect(link["wage"]).not_to be_nil
      expect(link["costed_distance"]).to eq("10.0")
      expect(link["costed_time"].to_i).to eq(1)
    end

    it "does not create a link between two neutral stations" do
      tribeca_neutral = create(:station, :tribeca, scores: [create(:neutral)])
      gowanus_neutral = create(:station, :gowanus, scores: [create(:neutral)])
      links = Station.links
      expect(links.length).to eq(0)
    end

    it "does create a link between a neutral station and a dropoff station" do
      gowanus_neutral = create(:station, :gowanus, scores: [create(:neutral)])
      downtown_dropoff = create(:station, :downtown, scores: [create(:dropoff)]) 
      links = Station.links
      expect(links.length).to eq(1)
      link = links[0]
      expect(link["wage"]).not_to be_nil
      expect(link["subj_id"]).to eq(gowanus_neutral.id)
      expect(link["sid"]).to eq(downtown_dropoff.id)

    end

    it "does create a link from a pickup station to a dropoff station" do
      gowanus_neutral = create(:station, :gowanus, scores: [create(:neutral)])
      uptown_pickup = create(:station, :uptown, scores: [create(:pickup)])
      links = Station.links
      expect(links.length).to eq(1)
      link = links[0]
      expect(link["wage"]).not_to be_nil
      expect(link["sid"]).to eq(gowanus_neutral.id)
      expect(link["subj_id"]).to eq(uptown_pickup.id)
    end
    # uptown_pickup
  end
end
