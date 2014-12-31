Sequel.migration do
  change do
    add_column(:referredBy, :count, Integer)
  end
end
