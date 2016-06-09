require "./ex43_currency.rb"
require "./ex43_statistics.rb"
require "./ex43_random.rb"

class CurrencyTrader
  attr_accessor :usd, :cad, :aud, :gbp, :eur

  def initialize()
    @usd = Currency.new("USD", 100000, 100.00)
	@cad = Currency.new("CAD", 0, 100.00)
	@aud = Currency.new("AUD", 0, 100.00)
	@gbp = Currency.new("GBP", 0, 150.00)
	@eur = Currency.new("EUR", 0, 120.00)
	@turn = 1
	
  end
  
  def play()
    while true
	  print_turn()
	  print "> "
	  action = gets.chomp().downcase
	  if action == "1"
	    select_selling_currency()
	  elsif action == "2"
	    see_statistics()
	  elsif action == "3"
	    change_turn()
	  elsif action == "4"
	    turns = ""
		loop do
		  puts "How many turn would you like to turn?"
		  turns = gets.chomp()
		  break if turns.respond_to?(:to_i) && turns.to_i <= 1000
		  puts "The number of turns must be a number and maximum 1000!"
		end
		turns.to_i.times {change_turn()}
	  elsif action == "exit"
	    Process.exit(1)
	  else
	    puts "Your choice can only be a number between 1 and 4 or 'Exit'."
	  end
	end
  end
  
  def select_selling_currency()
	print_account()
	puts "Which of your currencies would you like to sell?"
	puts "USD" if @usd.amount > 0
	puts "CAD" if @cad.amount > 0
	puts "AUD" if @aud.amount > 0
	puts "GBP" if @gbp.amount > 0
	puts "EUR" if @eur.amount > 0
	puts "Exit - any other input."
	
	sell = gets.chomp().downcase
	if sell == "usd" && @usd.amount > 0
	  select_buying_currency(@usd)
	elsif sell == "cad" && @cad.amount > 0
	  select_buying_currency(@cad)
	elsif sell == "aud" && @aud.amount > 0
	  select_buying_currency(@aud)
	elsif sell == "gbp" && @gbp.amount > 0
	  select_buying_currency(@gbp)
	elsif sell == "eur" && @eur.amount > 0
      select_buying_currency(@eur)
	end
  end
  
  def select_buying_currency(sell)
    puts "\nWhich currency would you like to buy?"
	puts "USD" if sell != @usd
	puts "CAD" if sell != @cad
	puts "AUD" if sell != @aud
	puts "GBP" if sell != @gbp
	puts "EUR" if sell != @eur
	puts "Exit - any other input."
	
	buy = gets.chomp().downcase
	if buy == "usd" && sell != @usd
	  amount_of_change(@usd, sell)
	elsif buy == "cad" && sell != @cad
	  amount_of_change(@cad, sell)
	elsif buy == "aud" && sell != @aud
	  amount_of_change(@aud, sell)
	elsif buy == "gbp" && sell != @gbp
	  amount_of_change(@gbp, sell)
	elsif buy == "eur" && sell != @eur
	  amount_of_change(@eur, sell)
	end
  end
  
  def amount_of_change(buy, sell)
    okay = false
	until okay
	  puts "\nHow much do you want to buy?"
	  amount = gets.chomp().to_i
	  value = Statistics.change_value(buy.value, sell.value, amount)
	  price = Statistics.commission(value)
	  price = 1 if price < 1
	  action = "0"
	  if (value + price) > sell.amount
	    puts "You don't have enough #{sell.type} for this transaction!"
		action = "3"
      end
	  until action == "1" || action == "2" || action == "3"
	    puts "Price is %i %s + 0,5%s commission: %i %s." % 
	      [value, sell.type, "%", price, sell.type]
	    puts "That is %i %s. Do you want to make the transaction?" % 
	      [(value + price), sell.type]
	    puts "1 - Yes"
	    puts "2 - No"
	    puts "3 - Another amount"
	    action = gets.chomp()
	    if action == "1"
	      buy.amount += amount
		  sell.amount -= (value + price)
		  okay = true
		elsif action == "2"
		  okay = true
		end
	  end
	end
  end
  
  def change_turn()
	@usd.value *= RandomNumber.generate_weighted_rand_num(@usd.value)
	@usd.save_history()
	@cad.value *= RandomNumber.generate_weighted_rand_num(@cad.value)
	@cad.save_history()
	@aud.value *= RandomNumber.generate_weighted_rand_num(@aud.value)
	@aud.save_history()
	@gbp.value *= RandomNumber.generate_weighted_rand_num(@gbp.value)
	@gbp.save_history()
	@eur.value *= RandomNumber.generate_weighted_rand_num(@eur.value)
	@eur.save_history()
	@turn += 1
  end
  
  def print_turn()
    if @turn == 1
	    puts "Welcome! This is a currency trader game."
		puts "You can deal with different type of currencies here.\n"
	end
	puts "\nTurn #%d\n\n" % @turn
	print_account()
	print_currency_rates(@usd)
	puts "\nPrice of a Big Mac:"
	print "\tUSD: %f" % Statistics.get_big_mac_price(@usd.value)
	puts "\tChange: %f%s" % [Statistics.get_inflation(@usd.history, 1), " %"]
	print "\tCAD: %f" % Statistics.get_big_mac_price(@cad.value)
	puts "\tChange: %f%s" % [Statistics.get_inflation(@cad.history, 1), " %"]
	print "\tAUD: %f" % Statistics.get_big_mac_price(@aud.value)
	puts "\tChange: %f%s" % [Statistics.get_inflation(@aud.history, 1), " %"]
	print "\tGBP: %f" % Statistics.get_big_mac_price(@gbp.value)
	puts "\tChange: %f%s" % [Statistics.get_inflation(@gbp.history, 1), " %"]
	print "\tEUR: %f" % Statistics.get_big_mac_price(@eur.value)
	puts "\tChange: %f%s" % [Statistics.get_inflation(@eur.history, 1), " %"]
	puts "\nYou can choose of the next opportunities:"
	puts "1 - Change currency"
	puts "2 - See more statistics"
	puts "3 - End of turn"
	puts "4 - Make given turn"
	puts "Exit - Exit"
  end
  
  def print_account()
    puts "You have:"
	puts "\t#{@usd.amount.to_i} USD" if @usd.amount >= 1
	puts "\t#{@cad.amount.to_i} CAD" if @cad.amount >= 1
	puts "\t#{@aud.amount.to_i} AUD" if @aud.amount >= 1
	puts "\t#{@gbp.amount.to_i} GBP" if @gbp.amount >= 1
	puts "\t#{@eur.amount.to_i} EUR" if @eur.amount >= 1
  end
  
  def print_currency_rates(base, text=true)
    puts text ? "\nCurrency rates: " : "\n"
	print "\tUSD/#{base.type}: %f" % Statistics.get_value(@usd.value, base.value) if base != @usd
	puts "\t Change: %f%s" % [Statistics.get_rate_change(@usd.history, base.history, 1), " %"] if base != @usd
	print "\tCAD/#{base.type}: %f" % Statistics.get_value(@cad.value, base.value) if base != @cad
	puts "\t Change: %f%s" % [Statistics.get_rate_change(@cad.history, base.history, 1), " %"] if base != @cad
	print "\tAUD/#{base.type}: %f" % Statistics.get_value(@aud.value, base.value) if base != @aud
	puts "\t Change: %f%s" % [Statistics.get_rate_change(@aud.history, base.history, 1), " %"] if base != @aud
	print "\tGBP/#{base.type}: %f" % Statistics.get_value(@gbp.value, base.value) if base != @gbp
	puts "\t Change: %f%s" % [Statistics.get_rate_change(@gbp.history, base.history, 1), " %"] if base != @gbp
	print "\tEUR/#{base.type}: %f" % Statistics.get_value(@eur.value, base.value) if base != @eur
	puts "\t Change: %f%s" % [Statistics.get_rate_change(@eur.history, base.history, 1), " %"] if base != @eur
  end
  
  def print_change_of_currencies_periodic(base, turns, text=true)
    puts text ? "\nBeginning rate:\t\t Current rate:\t  Change:" : "\n"
	
	print "\t USD/#{base.type}: %f" % Statistics.get_value(@usd.history[@usd.history.length - turns - 1],
	  base.history[base.history.length - turns - 1]) if base != @usd
	print "\t%f\t" % Statistics.get_value(@usd.value, base.value) if base != @usd
	puts "%f \%" % Statistics.get_rate_change(@usd.history, base.history, turns) if base != @usd
	
	print "\t CAD/#{base.type}: %f" % Statistics.get_value(@cad.history[@cad.history.length - turns - 1],
	  base.history[base.history.length - turns - 1]) if base != @cad
	print "\t%f\t" % Statistics.get_value(@cad.value, base.value) if base != @cad
	puts "%f \%" % Statistics.get_rate_change(@cad.history, base.history, turns) if base != @cad
    
	print "\t AUD/#{base.type}: %f" % Statistics.get_value(@aud.history[@aud.history.length - turns - 1],
	  base.history[base.history.length - turns - 1]) if base != @aud
	print "\t%f\t" % Statistics.get_value(@aud.value, base.value) if base != @aud
	puts "%f \%" % Statistics.get_rate_change(@aud.history, base.history, turns) if base != @aud
    
	print "\t GBP/#{base.type}: %f" % Statistics.get_value(@gbp.history[@gbp.history.length - turns - 1],
	  base.history[base.history.length - turns - 1]) if base != @gbp
	print "\t%f\t" % Statistics.get_value(@gbp.value, base.value) if base != @gbp
	puts "%f \%" % Statistics.get_rate_change(@gbp.history, base.history, turns) if base != @gbp
	
	print "\t EUR/#{base.type}: %f" % Statistics.get_value(@eur.history[@eur.history.length - turns - 1],
	  base.history[base.history.length - turns - 1]) if base != @eur
	print "\t%f\t" % Statistics.get_value(@eur.value, base.value) if base != @eur
	puts "%f \%" % Statistics.get_rate_change(@eur.history, base.history, turns) if base != @eur
  end
  
  def see_statistics()
	okay = false
	until okay
	  puts "\nWhich statistics are you interested in?"
	  puts "1 - Show the rates of a selected currency!"
	  puts "2 - Show all the rate pairs!"
	  puts "3 - Show the change of the rates of a selected currency in a given period!"
	  puts "4 - Show all changes of the rates in a given period!"
	  puts "5 - Show the inflation rate of the currencies in a given period!"
	  puts "6 - Show the total value of all my property!"
	  puts "7 - Exit"
	  action = gets.chomp()
	  
	  if action == "1"
	    puts "Which currency are you interested in?"
	    puts "USD / CAD / AUD / GBP / EUR"
		currency = gets.chomp().downcase
		if currency == "usd"
		  print_currency_rates(@usd)
		elsif currency == "cad"
		  print_currency_rates(@cad)
		elsif currency == "aud"
		  print_currency_rates(@aud)
		elsif currency == "gbp"
		  print_currency_rates(@gbp)
		elsif currency == "eur"
		  print_currency_rates(@eur)
		end
	  
	  elsif action == "2"
	    print_currency_rates(@usd)
		print_currency_rates(@cad, false)
		print_currency_rates(@aud, false)
		print_currency_rates(@gbp, false)
		print_currency_rates(@eur, false)
      
	  elsif action == "3"
	    puts "Which currency are you interested in?"
	    puts "USD / CAD / AUD / GBP / EUR"
		currency = gets.chomp().downcase
		turns = ""
		loop do
		  puts "\nHow long is the period in turns?"
		  turns = gets.chomp()
		  break if turns.respond_to?(:to_i) && turns.to_i <= (@usd.history.length - 1)
		  puts "It must be number and maximum %d!" % (@usd.history.length - 1)
		end
		turns = turns.to_i
		if currency == "usd"
		  print_change_of_currencies_periodic(@usd, turns)
		elsif currency == "cad"
		  print_change_of_currencies_periodic(@cad, turns)
		elsif currency == "aud"
		  print_change_of_currencies_periodic(@aud, turns)
		elsif currency == "gbp"
		  print_change_of_currencies_periodic(@gbp, turns)
		elsif currency == "eur"
		  print_change_of_currencies_periodic(@eur, turns)
		end
	  
	  elsif action == "4"
	    turns = ""
		loop do
		  puts "\nHow long is the period in turns?"
		  turns = gets.chomp()
		  break if turns.respond_to?(:to_i) && turns.to_i <= (@usd.history.length - 1)
		  puts "It must be number and maximum %d!" % (@usd.history.length - 1)
		end
		turns = turns.to_i
		print_change_of_currencies_periodic(@usd, turns)
		print_change_of_currencies_periodic(@cad, turns, false)
		print_change_of_currencies_periodic(@aud, turns, false)
		print_change_of_currencies_periodic(@gbp, turns, false)
		print_change_of_currencies_periodic(@eur, turns, false)		
	  
	  elsif action == "5"
	    turns = ""
		loop do
		  puts "\nHow long is the period in turns?"
		  turns = gets.chomp()
		  break if turns.respond_to?(:to_i) && turns.to_i <= (@usd.history.length - 1)
		  puts "It must be number and maximum %d!" % (@usd.history.length - 1)
		end
		turns = turns.to_i
		
		puts "\nBeginning rate:\t\t Current rate:\t  Change:\tAverage per turn:"
	    
		print "\tUSD: %f\t\t%f" % [Statistics.get_big_mac_price(@usd.history[@usd.history.length - turns - 1]),
		  Statistics.get_big_mac_price(@usd.value)]
		print "\t%f \%" % Statistics.get_inflation(@usd.history, turns)
		puts "\t%f \%" % Statistics.get_inflation_avg(@usd.history, turns)
	    
		print "\tCAD: %f\t\t%f" % [Statistics.get_big_mac_price(@cad.history[@cad.history.length - turns - 1]),
		  Statistics.get_big_mac_price(@cad.value)]
		print "\t%f \%" % Statistics.get_inflation(@cad.history, turns)
		puts "\t%f \%" % Statistics.get_inflation_avg(@cad.history, turns)
		
		print "\tAUD: %f\t\t%f" % [Statistics.get_big_mac_price(@aud.history[@aud.history.length - turns - 1]),
		  Statistics.get_big_mac_price(@aud.value)]
		print "\t%f \%" % Statistics.get_inflation(@aud.history, turns)
		puts "\t%f \%" % Statistics.get_inflation_avg(@aud.history, turns)
		
		print "\tGBP: %f\t\t%f" % [Statistics.get_big_mac_price(@gbp.history[@gbp.history.length - turns - 1]),
		  Statistics.get_big_mac_price(@gbp.value)]
		print "\t%f \%" % Statistics.get_inflation(@gbp.history, turns)
		puts "\t%f \%" % Statistics.get_inflation_avg(@gbp.history, turns)
		
		print "\tEUR: %f\t\t%f" % [Statistics.get_big_mac_price(@eur.history[@eur.history.length - turns - 1]),
		  Statistics.get_big_mac_price(@eur.value)]
		print "\t%f \%" % Statistics.get_inflation(@eur.history, turns)
		puts "\t%f \%" % Statistics.get_inflation_avg(@eur.history, turns)
		puts "\n\t(Calculated with the price of a Big Mac.)"
	  
	  elsif action == "6"
		puts "\nThe value of all your property:"
		in_big_mac, in_usd, in_cad, in_aud, in_eur, in_gbp = Statistics.value_of_property(@usd, @cad, @aud, @eur, @gbp)
		puts "\tin USD: %d" % in_usd
		puts "\tin CAD: %d" % in_cad
		puts "\tin AUD: %d" % in_aud
		puts "\tin EUR: %d" % in_eur
		puts "\tin GBP: %d" % in_gbp
		puts "\n\tyou could buy %d Big Mac." % in_big_mac
	  
	  elsif action == "7"
	    okay = true
	  end
	end
  end
	
end

game = CurrencyTrader.new()
game.play()