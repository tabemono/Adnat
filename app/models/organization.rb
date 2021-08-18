# == Schema Information
#
# Table name: organizations
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  hourly_rate :decimal(, )      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Organization < ApplicationRecord
    has_many :users, dependent: :nullify
    has_many :shifts

    validates :name, presence: true, uniqueness: true
    validates :hourly_rate, numericality: { greater_than_or_equal_to: 0 }
end
