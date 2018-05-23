module HomeHelper
  # Returns the Gravatar for the given user.
  def gravatar_author
    gravatar_id = Digest::MD5::hexdigest('dfursenko@gmail.com')
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=70"
  end
end
