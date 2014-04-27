module Trogdir
  class Client
    def self.call(method, params = nil)
      client = Trogdir::APIClient::People.new
      request = client.send method, params
      response = request.perform

      unless response.not_found?
        JSON.parse(response.body, symbolize_names: true)
      end
    end
  end
end