# Don't require explicitly because there's no ruby-oci8 in test
autoload :OCI8, 'oci8'

module Banner
  class DB
    def self.exec(*args, &block)
      sql = args.shift
      params = args

      raise ArgumentError, 'A SQL statement is required' if sql.nil?

      conn = connection
      cursor = conn.exec(sql, *params)

      while row = cursor.fetch_hash
        block.call(row.symbolize_keys) if block_given?
      end

      cursor.close
      conn.logoff
    end

    def self.connection
      OCI8.new(Settings.oracle.connection_string)
    end
  end
end