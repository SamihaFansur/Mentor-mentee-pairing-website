# Provide various functions for validating data
module Validation
  def self.str_is_integer?(str)
    return false if str.nil?

    str.match?(/^(\d)+$/)
  end

end
