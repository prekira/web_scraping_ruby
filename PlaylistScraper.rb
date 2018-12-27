require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper 
	url = "https://www.billboard.com/charts/hot-100"
	unparsed_page = HTTParty.get(url)
	parsed_page = Nokogiri::HTML(unparsed_page)
	#get tracks 2-100 on list
	hot100 = (get_tracks(parsed_page))

	#get top track , not included with rest
	top_track = get_top_track(parsed_page)
	#top track name
	top_track_name = get_top_track_name(top_track)
	
	#add rest of track names
	#get top track for hot 100, not grouped with rest
	track_names = get_names(hot100, track_names)
	puts top_track_name
	puts track_names
	#byebug
end

def get_top_track(parsed_page)
	parsed_page.css('div.chart-number-one__info')
end

def get_top_track_name(top_track)
	(top_track.css('div.chart-number-one__title').text)
end

def get_names(hot100, track_names)
	hot100.each do |item|
		track_names.push(get_name(item))
	end
end

def get_tracks(parsed_page)
	parsed_page.css('div.chart-list-item')
end

def get_name(track)
	track_name = track.css('span.chart-list-item__title-text').text.tr("\n", "")
end
scraper