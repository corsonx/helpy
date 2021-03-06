module PhoneFuncs
  def phone(options={})
    options = {:area_sep => '-', :num_sep => '-', :exceptions => false}.merge(options)
    ph = self.to_s.gsub(/[^0-9]/, '')
    area = ''
    unless ph.length > 0; return ph; end
    if ph.length == 11
      area = options[:area_sep] == '(' ? ph[0..0]+'('+ph[1..3]+')' : ph[0..0] + options[:num_sep] + ph[1..3]+options[:area_sep]
      ph = [ph[4..6],ph[7..10]].join(options[:num_sep])
    elsif ph.length == 10
      area = options[:area_sep] == '(' ? '('+ph[0..2]+')' : ph[0..2]+options[:area_sep]
      ph = [ph[3..5],ph[6..9]].join(options[:num_sep])
    elsif ph.length == 7
      ph = [ph[0..2],ph[3..6]].join(options[:num_sep])
    else
      if options[:exceptions]
        raise ArgumentError, 'Invalid number of digits for a phone number', caller
      #else
        #area = ''
        #ph = ''
      end
    end
    area+ph
  end
end
