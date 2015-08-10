# Current Weather and Forecast

require 'yahoo_weatherman'

# Ask user for any zipcode
print "To get the current weather condition please enter any zipcode: "
zipcode = gets.chomp

# Lookup for the current weather using yahoo_weatherman gem
client = Weatherman::Client.new :unit => 'C' #change to F if you want weather in Farenheit
response = client.lookup_by_location(zipcode)

# Assign the current condition to variables
temperature = response.condition['temp'].to_i
curr_condition = response.condition['text'].downcase #because will be used inside a sentence, better to be downcased
curr_city = response.location['city']
sunrise = response.astronomy['sunrise']
sunset = response.astronomy['sunset']
today = Time.now.strftime('%w').to_i

# Print the current weather in the terminal
puts "It is now #{curr_condition} with a temperature of #{temperature} degree C in #{curr_city}."

# Ask the user if would like to have weather forecasts
print "Want the forecast for #{curr_city} in the next few days? (Y/N) "
reply = gets.chomp.downcase

if reply == 'y'

response.forecasts.each do |forecast|
	day = forecast['date']
	weekday = day.strftime('%w').to_i
	
	if weekday == today
		day = "Today"
	elsif weekday == today + 1
		day = "Tomorrow"
	else
		day = day.strftime('%A')
	end
	
	puts day + " is going to be " + forecast['text'].to_s.downcase + ". Temperature will have a low of " + forecast['low'].to_s + " degree C and a high of " + forecast['high'].to_s + " degree C."
end
else reply == 'n'
	puts 'Thank you!'
end