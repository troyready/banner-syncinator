class TrogdirChange
  attr_reader :hash

  def initialize(hash)
    @hash = hash
  end

  def sync_log_id
    hash['sync_log_id']
  end

  def person_uuid
    hash['person_id']
  end

  def netid
    modified['identifier']
  end

  def netid_creation?
    id? && create? && modified['type'] == 'netid'
  end

  private

  def id?
    hash['scope'] == 'id'
  end

  def create?
    hash['action'] == 'create'
  end

  def modified
    hash['modified']
  end
end
