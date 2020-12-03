json.extract! reservation, :id, :number_of_nights, :number_of_guest, :approved, :total_price, :created_at, :updated_at
json.url property_url(reservation, format: :json)
