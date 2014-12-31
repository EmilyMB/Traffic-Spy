Sequel.migration do
  change do
    create_table(:referredBy) do
      primary_key   :id
      String        :url
    end
  end
end
