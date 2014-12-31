Sequel.migration do
  change do
    create_table(:requestedType) do
      primary_key   :id
      String        :request
    end
  end
end
