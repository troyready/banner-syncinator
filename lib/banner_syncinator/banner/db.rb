require 'oci8'

module Banner
  class DB
    def self.connection
      OCI8.new(Settings.oracle.connection_string)
    end
  end
end