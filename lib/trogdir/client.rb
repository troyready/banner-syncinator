module Trogdir
  class Client
    def self.people(method, params = nil)
      call Trogdir::APIClient::People, method, params
    end

    def self.groups(method, params = nil)
      call Trogdir::APIClient::Groups, method, params
    end

    private

    def self.call(client_class, method, params = nil)
      client = client_class.new
      request = client.send method, params
      response = request.perform

      unless response.not_found?
        JSON.parse(response.body, symbolize_names: true)
      end
    end
  end
end
