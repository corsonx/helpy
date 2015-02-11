module MoneyFuncs
  def monetize(options={})
    # default format: $12,345,678.90
    options = {:currency_symbol => "$", :delimiter => ",", :decimal => ".", 
                :currency_before => true, :no_decimal => false}.merge(options)
    isneg = (self.class.method_defined? :to_str) ? self.include?('-') : self < 0
    if self.class == Bignum
      parts = self.to_s.gsub(/[^0-9^.]/, '').split('.')
      int = parts[0] or '0'
      frac = parts[1].nil? ? '00' : parts[1]
    else
      int, frac = ("%.2f" % self.to_s.gsub(/[^0-9^.]/, '')).split('.')
    end
    int.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{options[:delimiter]}")
    frac_part = options[:no_decimal] ? "" : options[:decimal] + frac
    if options[:currency_before]
      "#{isneg == true ? '-' : ''}#{options[:currency_symbol]}#{int}#{frac_part}"
    else
      "#{int}#{frac_part}#{options[:currency_symbol]}"
    end
  end
end
