Sequel.migration do
  change do
    add_column(:payload, :referredBy_id, Integer) 
  end
end
