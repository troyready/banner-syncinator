class GroupSynchronizer
  attr_reader :group, :sql

  # The only column returned in the SQL should be a PIDM
  def initialize(group, sql)
    @group = group
    @sql = sql
  end

  def call
    Log.info "Begin sync of #{group} group"

    (banner_people - trogdir_people).each do |person|
      update :add, person
    end

    (trogdir_people - banner_people).each do |person|
      update :remove, person
    end

    Log.info "Finished syncing of #{group} group"
  end

  private

  def banner_people
    @banner_people ||= [].tap do |people|
      Banner::DB.exec(sql) do |row|
        col ||= row.keys.first
        people << Banner::Person.new(PIDM: row[col])
      end
    end
  end

  def trogdir_people
    @trogdir_people ||= Trogdir::Client.groups(:people, group: group).map do |hash|
      Trogdir::Person.new(hash)
    end
  end

  def update(method, person)
    response = Trogdir::Client.groups(method, group: group, identifier: person.banner_id.to_s, type: 'banner')

    message = "#{method.to_s.titleize} user with PIDM #{person.banner_id} to #{group} group"
    if response && response[:result] == true
      Log.info message
    else
      Log.error "Unable to #{message}"
    end
  end
end
