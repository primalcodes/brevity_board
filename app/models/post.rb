class Post < ApplicationRecord
  #===================================================
  # CALLBACKS
  #===================================================

  #===================================================
  # SCOPES
  #===================================================
  default_scope { order(created_at: :desc) }
  scope :top_5, -> { unscoped.order(comments_count: :desc).limit(5)}

  #===================================================
  # VALIDATIONS
  #===================================================
  validates :title, presence: true
  validates :body, presence: true

  #===================================================
  # RELATIONSHIPS
  #===================================================
  belongs_to :author, class_name: 'User', foreign_key: :user_id, counter_cache: true
  has_many :comments, -> { order(created_at: :asc) }

  #===================================================
  # INSTANCE METHODS
  #===================================================
end
