module Boolinators
  def truey?
    (self == true ||                                            ## TrueClass
      !(self.to_s.strip =~ /^true$|^yes$|^t$|^y$|^on$|^1$/i).nil? || ## Strings
      (self == 1 rescue false)                                  ## Integers
    ) ? true : false
  end 
  
  def falsey?
    (self == false ||                                           ## FalseClass
     self == nil ||                                             ## NilClass
      (self.to_s.empty? rescue false) ||                        ## Empty Strings
      !(self.to_s.strip =~ /^false$|^no$|^f$|^n$|^off$|^0$/i).nil? || ## Strings
      (self == 0 rescue false) ||                               ## Integers
      (self.to_f > 1 rescue false )
    ) ? true : false
  end
end
