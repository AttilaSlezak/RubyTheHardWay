class Statistics
  class << self

	def get_value(value_currency, base_currency)
      value_currency / base_currency
	end
  
	def get_big_mac_price(currency)
      100.00 / currency
    end
  
    def get_inflation(currency_history, turn)
	  next_turn = currency_history.length - turn - 1
	  beginning = currency_history[next_turn]
	  (currency_history[currency_history.length - 1].to_f / beginning.to_f - 1) * 100
    end

	def get_inflation_avg(currency_history, turn)
	  next_turn = currency_history.length - turn - 1
	  beginning = currency_history[next_turn]
	  ((currency_history[currency_history.length - 1].to_f / beginning.to_f) ** (1.0 / turn.to_f) - 1) * 100
	end

	def value_of_property(usd, cad, aud, eur, gbp)
		total_value = usd.amount * usd.value
		total_value += cad.amount * cad.value
		total_value += aud.amount * aud.value
		total_value += eur.amount * eur.value
		total_value += gbp.amount * gbp.value
		return total_value / 100, total_value / usd.value, total_value / cad.value, 
		  total_value / aud.value, total_value / eur.value, total_value / gbp.value
	end
		
	def get_rate_change(value_history, base_history, turn)
	  next_turn = base_history.length - turn - 1
	  beginning_value = value_history[next_turn]
	  beginning_base = base_history[next_turn]
	  beginning_rate = get_value(beginning_value, beginning_base)
	  current_value = value_history[value_history.length - 1]
	  current_base = base_history[base_history.length - 1]
	  current_rate = get_value(current_value, current_base)
	  (current_rate / beginning_rate - 1) * 100
	end
	
	def change_value(buy, sell, amount)
	   buy / sell * amount
	end
	
	def commission(amount)
	  amount * 0.005
	end
  end
end