class Currency
  attr_accessor :value, :amount
  attr_reader :type, :beginning_value, :history
  
  def initialize(type, amount, value)
    @type = type
	@amount = amount
    @value = value
	@beginning_value = value
	@history = []
	@history.push(@value)
  end
  
  def save_history()
    if @history.length == 301
	  @history.shift()
	end
	@history.push(@value)
  end  
end