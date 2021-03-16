# Provide various functions for validating data
module Validation
 def self.str_is_text?(str) 
    return false if str.nil?
    return true if !str.nil?
#     str.match?(/^(\d)+$/)
  end

end
