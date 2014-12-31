Sequel.migration do
  change do
    create_table(:resolution) do
      primary_key   :id
      String        :width
      String        :height
      String        :resolution
    end
  end
end
