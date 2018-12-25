require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper 
	url = "https://www.billboard.com/charts/hot-100"
	unparsed_page = HTTParty.get(url)
	parsed_page = Nokogiri::HTML(unparsed_page)
	#get tracks 2-100 on list
	hot100 = (get_tracks(parsed_page))

	#track names
	track_names = Array.new
	#get top track , not included with rest
	top_track = parsed_page.css('div.chart-number-one__info')
	#top track name
	top_track_name = "1: " + (top_track.css('div.chart-number-one__title').text)
	
	#add rest of track names
	#get top track for hot 100, not grouped with rest
	track_names = get_names(hot100, track_names)
	puts top_track_name
	puts track_names
	#byebug
end



def get_names(hot100, track_names)
	count = 1
	hot100.each do |item|
		count += 1
		track_names.push(count.to_s + ":" + get_name(item))
	end
	return track_names
end

def get_tracks(parsed_page)
	return parsed_page.css('div.chart-list-item')
end

def get_name(track)
	track_name = track.css('span.chart-list-item__title-text').text.tr("\n", "")
	return track_name
end
scraper