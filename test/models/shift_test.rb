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
require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
