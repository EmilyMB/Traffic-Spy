Sequel.migration do
  change do
    add_column(:payload, :raw_data, String) 
  end
end
