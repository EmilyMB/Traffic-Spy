Sequel.migration do
  change do
    create_table(:userAgent) do
      primary_key   :id
      String        :browser
      String        :os
      String        :full_data
    end
  end
end
