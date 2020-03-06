class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  after_validation :set_slug, only: [:create, :update]
  private

  def set_slug
    self.slug = username.to_s.parameterize
  end

end
