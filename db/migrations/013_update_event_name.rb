Sequel.migration do
  change do
    add_column(:eventName, :count, Integer)
  end
end
