require 'spec_helper'
require File.dirname(__FILE__) + '/../lib/money_extension'

describe String do
  
  before(:all) do
    class String
      include MoneyFuncs
    end
  end
  
  it "should default to US currency" do
    '123456'.monetize.should eq('$123,456.00')
    '123'.monetize.should eq('$123.00')
  end
  
  it "should have no decimal when specified" do
    '123456'.monetize({:no_decimal => true}).should eq('$123,456')
    '123456.00'.monetize({:no_decimal => true}).should eq('$123,456')
    '123456.50'.monetize({:no_decimal => true}).should eq('$123,456')
  end
  
  it "should allow you to specify where the money symbol is" do
    '123456'.monetize({:currency_before => false}).should eq('123,456.00$')
    '123456.00'.monetize({:currency_before => false, :no_decimal => true}).should eq('123,456$')
  end
  
  it "should allow you to specify what the money symbol is" do
    '123456'.monetize({:currency_symbol => '^'}).should eq('^123,456.00')
    '123456.00'.monetize({:currency_symbol => '^',
                          :currency_before => false, 
                          :no_decimal => true}).should eq('123,456^')
  end
  
  it "should allow you to specify what the decimal symbol is" do
    '123456'.monetize({:decimal => ';'}).should eq('$123,456;00')
    '123456.00'.monetize({:decimal => ';', 
                          :no_decimal => true}).should eq('$123,456')
  end
  
  it "should allow you to specify what the delimiter symbol is" do
    '123456'.monetize({:delimiter => '.'}).should eq('$123.456.00')
    '123456.00'.monetize({:delimiter => '.', 
                          :no_decimal => true}).should eq('$123.456')
  end

  it "should display negative numbers correctly" do
    '-123456'.monetize({:delimiter => ','}).should eq('-$123,456.00')
  end
end

#######################
describe Fixnum do
  
  before(:all) do
    class Fixnum
      include MoneyFuncs
    end
  end
  
  it "should default to US currency" do
    123456.monetize.should eq('$123,456.00')
    123.monetize.should eq('$123.00')
  end
  
  it "should allow all options" do
    123456.monetize({:currency_symbol => '^',
                        :currency_before => false,
                        :delimiter => '.', 
                        :no_decimal => true}).should eq('123.456^')
  end

  it "should display negative numbers correctly" do
    -123456.monetize({:delimiter => ','}).should eq('-$123,456.00')
  end
end

#######################
describe Float do
  before(:all) do
    class Float
      include MoneyFuncs
    end
  end
  
  it "should default to US currency" do
    123456.0.monetize.should eq('$123,456.00')
    123.0.monetize.should eq('$123.00')
    123.50.monetize.should eq('$123.50')
    123.56.monetize.should eq('$123.56')
  end
  
  it "should round to the nearest penny" do
    123.5678.monetize.should eq('$123.57')
    123.562.monetize.should eq('$123.56')
  end
  
  it "should allow all options" do
    123456.0.monetize({:currency_symbol => '^',
                        :currency_before => false,
                        :delimiter => '.', 
                        :no_decimal => true}).should eq('123.456^')
  end
end

#######################
describe Bignum do
  before(:all) do
    class Bignum
      include MoneyFuncs
    end
  end
  
  it "should equal max Fixnum money display" do
    ## Bignum size differs across systems
    expect { (2**(0.size * 8 -2)).monetize }.should_not raise_exception
    
    ## is the monetized length greater than the largest Fixnum conversion
    ((2**(0.size * 8 -2))*20).monetize.length.should be > (2**(0.size * 8 -2) -1).monetize.length
    
  end
  
  it "should allow options" do
    (2**(0.size * 8 -2)).monetize({:currency_symbol => '^'}).include?('^').should eq(true)
    (2**(0.size * 8 -2)).monetize({:delimiter => '*'}).include?('*').should eq(true)
    (2**(0.size * 8 -2)).monetize({:no_decimal => true}).include?('.00').should eq(false)
    
    res = (2**(0.size * 8 -2)).monetize({:currency_before => false})
    res[res.length-1,1].should eq('$')
  end
end



