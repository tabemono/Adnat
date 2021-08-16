class Shift < ApplicationRecord
    belongs_to :user, foreign_key: 'user_id'
    belongs_to :organization, foreign_key: 'organization_id'

    validates :user, presence: true
    validates :start, presence: true
    validates :finish, presence: true
  
    validates_inclusion_of :break_length, :in => 0..60, :message => "must be between 0 and 60 minutes"
end