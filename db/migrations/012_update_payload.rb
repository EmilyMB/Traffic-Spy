Sequel.migration do
  change do
    add_column(:payload, :identifier, String)
  end
end
