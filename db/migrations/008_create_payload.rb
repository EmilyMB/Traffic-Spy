Sequel.migration do
  change do
    create_table(:payload) do
      primary_key   :id
      Integer       :url_id
      Date          :requestedAt
      Integer       :respondedIn
      Integer       :requestType_id
      String        :parameters
      Integer       :eventName_id
      Integer       :userAgent_id
      Integer       :resolution_id
      String        :ip
    end
  end
end
