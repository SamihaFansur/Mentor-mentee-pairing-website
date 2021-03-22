# Function for validating data

#Returns false if the parameter is a empty
#else returns a true
module Validation
 def self.str_is_text?(str) 
    return false if str.nil?
    return true if !str.nil?
 end
end
