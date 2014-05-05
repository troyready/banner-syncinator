module SyncinatorHelpers
  def create_current_syncinator
    Syncinator.create name: 'trogdir_api_client', access_id: Settings.trogdir.access_id, secret_key: Settings.trogdir.secret_key
  end
end