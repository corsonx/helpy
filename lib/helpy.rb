=begin rdoc

= Helpy - Ruby Class Extensions

Author:: Bradley Corson, Jr., brad@unclehenrys.com

Extend FixNum, Float, Bignum and String with phone, money and boolean functionality.

=end

$LOAD_PATH.unshift File.dirname(__FILE__)
require 'boolean_extension'
require 'phone_extension'
require 'money_extension'

class Fixnum
  include Boolinators
  include MoneyFuncs
  include PhoneFuncs
end

class Float
  include Boolinators
  include MoneyFuncs
  include PhoneFuncs  ## The entire value is converted to a number. Ex 555123.4 = '555-1234'
end

class Bignum
  include Boolinators
  include MoneyFuncs  ## Bignum is converted to a Fixnum before monetizing
  include PhoneFuncs
end

class String
  include Boolinators
  include MoneyFuncs
  include PhoneFuncs
end

class TrueClass
  include Boolinators
end

class FalseClass
  include Boolinators
end

class NilClass
  include Boolinators
end
