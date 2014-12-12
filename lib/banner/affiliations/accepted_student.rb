module Banner
  class AcceptedStudent < Banner::Person
    include Banner::NonEmployee

    SQL_ALL = "SELECT * FROM bsv_trogdir_accepted"
    SQL_ONE = "SELECT * FROM bsv_trogdir_accepted WHERE id = :1"
  end
end
