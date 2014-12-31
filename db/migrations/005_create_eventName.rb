Sequel.migration do
  change do
    create_table(:eventName) do
      primary_key   :id
      String        :event
    end
  end
end
