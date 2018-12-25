require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper 
	url = "https://www.billboard.com/charts/hot-100"
	unparsed_page = HTTParty.get(url)
	parsed_page = Nokogiri::HTML(unparsed_page)
	hot100 = parsed_page.css('div.chart-list-item')
	song_names = Array.new
	hot100.each do |item|
		item = item.css('span.chart-list-item__title-text')
		song_names.push(item.text.tr("\n",""))
	end
	puts song_names
	#byebug
end

scraper