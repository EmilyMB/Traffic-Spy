Sequel.migration do
  change do
    create_table(:url) do
      primary_key   :id
      String        :site_url
      Integer       :count
    end
  end
end
