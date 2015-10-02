class Recipe
    
    include HTTParty

    @key_value = ENV["FOOD2FORK_KEY"]
    hostport = ENV["FOOD2FORK_SERVER_AND_PORT"] || "www.food2fork.com"
    base_uri "http://#{hostport}/api"
    # base_uri 'http://food2fork.com/api/search'
    format :json

    def self.for keyword
        get("", query: { key: @key_value, q: keyword })["recipes"]

    end
end