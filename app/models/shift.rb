# == Schema Information
#
# Table name: shifts
#
#  id              :bigint           not null, primary key
#  user_id         :integer
#  organization_id :integer          not null
#  start           :datetime         not null
#  finish          :datetime         not null
#  break_length    :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Shift < ApplicationRecord
    belongs_to :user, foreign_key: :user_id
    belongs_to :organization, foreign_key: :organization_id

    validates :user, presence: true
    validates :start, presence: true
    validates :finish, presence: true
  
    validates_inclusion_of :break_length, :in => 0..60, :message => "must be between 0 and 60 minutes"
end
