require 'spec_helper'
require File.dirname(__FILE__) + '/../lib/boolean_extension'

describe String do
  
  before(:all) do
    class String
      include Boolinators
    end
  end
  
  it "should consider true for a string of 't' or 'true', regardless of capitalization" do
    ['t', 'T', 'true', 'True', 'TrUe'].each do |str|
      str.truey?.should eq(true)
      str.falsey?.should eq(false)
    end
  end
  
  it "should consider true for a string of 'y' or 'yes', regardless of capitalization" do
    ['y', 'Y', 'yes', 'Yes', 'YeS'].each do |str|
      str.truey?.should eq(true)
      str.falsey?.should eq(false)
    end
  end
  
  it "should consider true for a string of '1'" do
    '1'.truey?.should eq(true)
    '1'.falsey?.should eq(false)
  end
  
  it "should consider false for a string of 'f' or 'false', regardless of capitalization" do
    ['f', 'F', 'false', 'False', 'FALSE'].each do |str|
      str.falsey?.should eq(true)
      str.truey?.should eq(false)
    end
  end
  
  it "should consider false for a string of 'n' or 'no', regardless of capitalization" do
    ['n', 'N', 'no', 'No', 'NO'].each do |str|
      str.falsey?.should eq(true)
      str.truey?.should eq(false)
    end
  end
  
  it "should consider false for an empty string" do
    ''.falsey?.should eq(true)
    ''.truey?.should eq(false)
  end
  
  it "should consider false for a string of '0'" do
    '0'.falsey?.should eq(true)
    '0'.truey?.should eq(false)
  end
 
end

#######################
describe TrueClass do
  
  before(:all) do
    class TrueClass
      include Boolinators
    end
  end
  
  it "should consider true as true for TrueClass" do
    true.truey?.should eq(true)
    true.falsey?.should eq(false)
  end
 
end

#######################
describe FalseClass do
  
  before(:all) do
    class FalseClass
      include Boolinators
    end
  end
  
  it "should consider false as false for FalseClass" do
    false.truey?.should eq(false)
    false.falsey?.should eq(true)
  end
 
end

#######################
describe Fixnum do
  
  before(:all) do
    class Fixnum
      include Boolinators
    end
  end
  
  it "should consider true for integers == 1" do
    1.truey?.should eq(true)
    1.falsey?.should eq(false)
  end
  
  it "should consider false for integers other than 0 or 1" do
    [2, 45, 100].each do |i|
      i.truey?.should eq(false)
      i.falsey?.should eq(true)
    end
  end
 
end

#######################
describe Float do
  
  before(:all) do
    class Float
      include Boolinators
    end
  end
  
  it "should consider true for floats == 1.0" do
    1.0.truey?.should eq(true)
    1.0.falsey?.should eq(false)
  end
  
  it "should consider false for floats == 0.0" do
    0.0.truey?.should eq(false)
    0.0.falsey?.should eq(true)
  end
  
  it "should consider false for floats > 1.0" do
    [1.1, 15.2, 123.0].each do |i|
      i.truey?.should eq(false)
      i.falsey?.should eq(true)
    end
  end
 
end

#######################
describe Bignum do
  
  before(:all) do
    class Bignum
      include Boolinators
    end
  end
  
  it "should consider false for all Bignum's" do
    (2**(0.size * 8 -2)).truey?.should eq(false) ## minimum Bignum
    (2**(0.size * 8 -2)).falsey?.should eq(true)
    
    ((2**(0.size * 8 -2))*2).truey?.should eq(false) ## double minimum Bignum
    ((2**(0.size * 8 -2))*2).falsey?.should eq(true) 
  end
 
end



