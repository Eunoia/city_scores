FactoryGirl.define do
  factory :station do
    region_id 71
  end

  trait :uptown do
    id 3509
    name "Lenox Ave & W 115 St"
    short_name "7627.10"
    lat 0.408011939e2
    lon -0.739500739e2
    region_id 71
    geog "POINT (-74.9500739 40.8011939)"
  end

  trait :downtown do
     id 330
     name "Reade St & Broadway"
     short_name "5247.10"
     lat 0.4071450451e2
     lon -0.7400562789e2
     geog "POINT (-74.00562789 40.71450451)"
  end

  trait :gowanus do
    id 3373
    name "3 St & 3 Ave"
    short_name "4028.03"
    lat 0.406750705e2
    lon -0.7398775226e2
    geog "POINT (-73.98775226e2 40.6750705e2)"
  end

  trait :tribeca do
    id 3436
    name "Greenwich St & Hubert St"
    short_name "5470.10"
    lat 40.721319
    lon -74.010065
    geog "POINT (74.010065 40.721319)"
  end

end
