module PersonHelpers
  def new_person(attributes = {})
    attributes[:banner_id]    ||= 1111111
    attributes[:biola_id]     ||= 2222222
    attributes[:first_name]   ||= 'John'
    attributes[:last_name]    ||= 'Doe'
    attributes[:biola_email]  ||= 'john.doe@example.com'

    BannerSyncinator::Person.new attributes
  end
end