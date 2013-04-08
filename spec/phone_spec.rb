require 'spec_helper'
require File.dirname(__FILE__) + '/../lib/phone_extension'

describe String do
  
  before(:all) do
    class String
      include PhoneFuncs
    end
  end
  
  it "should default correctly" do
    '8005551234'.phone.should eq('800-555-1234')
    '5551234'.phone.should eq('555-1234')
  end
  
  it "should strip non-digits before converting" do
    '800.555.1234'.phone.should eq('800-555-1234')
    '555|1234'.phone.should eq('555-1234')
  end
  
  it "should raise an exception for too-short input" do
    expect { '551234'.phone }.should raise_exception
  end
  
  it "should allow options" do
    '8005551234'.phone({:area_sep => '.'}).should eq('800.555-1234')
    '8005551234'.phone({:area_sep => '('}).should eq('(800)555-1234')
    '8005551234'.phone({:num_sep => '.'}).should eq('800-555.1234')
    expect { '551234'.phone({:exceptions => false}) }.should_not raise_exception
    '551234'.phone({:exceptions => false}).should eq('')
  end
  
end

#######################
describe Fixnum do
  
  before(:all) do
    class Fixnum
      include PhoneFuncs
    end
  end
  
  it "should default correctly" do
    5551234.phone.should eq('555-1234')
  end
  
  it "should raise an exception, because a full 10 digit number is a Bignum" do
    expect { 8005551234.phone }.should raise_exception
  end
  
  it "should raise an exception for a too-short number" do
    expect { 551234.phone }.should raise_exception
  end
  
end

#######################
describe Float do
  before(:all) do
    class Float
      include PhoneFuncs
    end
  end
  
  it "should default correctly" do
    555123.4.phone.should eq('555-1234')
  end
  
  it "should raise an exception, because a full 10 digit number is a Bignum" do
    expect { 8005551234.3.phone }.should raise_exception
  end
  
  it "should raise an exception for a too-short number" do
    expect { 5512.2.phone }.should raise_exception
  end
  
  it "should raise an exception for a too-long number" do
    expect { 5551234.2.phone }.should raise_exception
  end
  
end

#######################
describe Bignum do
  before(:all) do
    class Bignum
      include PhoneFuncs
    end
  end
  
  it "should default correctly with large numbers" do
    5551234.phone.should eq('555-1234')
  end
  
  it "should default correctly" do
    8005551234.phone.should eq('800-555-1234')
  end
  
  
end



