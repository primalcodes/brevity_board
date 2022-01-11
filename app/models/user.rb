class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #===================================================
  # CALLBACKS
  #===================================================

  #===================================================
  # SCOPES
  #===================================================

  #===================================================
  # VALIDATIONS
  #===================================================
  validates :name, presence: true

  #===================================================
  # RELATIONSHIPS
  #===================================================
  has_many :posts
  has_many :comments

  #===================================================
  # INSTANCE METHODS
  #===================================================
  def initials
    return 'n/a' if name.nil?

    name.split(' ')[0..1].map { |n| n[0] }.join('')
  end
end
