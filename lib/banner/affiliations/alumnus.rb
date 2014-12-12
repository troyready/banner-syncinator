module Banner
  class Alumnus < Banner::Person
    include Banner::NonEmployee

    SQL_ALL = "SELECT * FROM bsv_trogdir_alumni"
    SQL_ONE = "SELECT * FROM bsv_trogdir_alumni WHERE id = :1"
  end
end
