require bundler; Bundler.require

if ENV["TRAFFIC_SPY_ENV"] == "test"
  database_file = 'db/traffic_spy-test.sqlite3'
  @database = Sequel.sqlite database_file
else
  @database = Sequel.postgres "traffic_spy"
end
@database.from(:sources).insert(
:identifier => "some-identifier",
:root_url => "http://example.org"
)
