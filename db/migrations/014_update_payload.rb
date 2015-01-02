Sequel.migration do
  change do
    add_column(:payload, :requestedAt2, DateTime)
  end
end
