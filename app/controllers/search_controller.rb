class SearchController < ApplicationController

	require 'soundcloud'
	require 'net/http'
	require 'json'

	def new
		@search = Search.new
	end

	def create
  		@search = Search.create(search_params)
  		redirect_to search_index_path
	end

	def index
		@client = Soundcloud.new(client_id: 'd8b21e837485a3086c3f20da86fee214')
		@search = Search.last
		@search_result = @search.content
		uri = URI("http://api.soundcloud.com/resolve.json?url=http://soundcloud.com/#{@search_result}&client_id=d8b21e837485a3086c3f20da86fee214")

		Net::HTTP.start(uri.host, uri.port) do |http|
  			request = Net::HTTP::Get.new uri

  			@res = http.request request # Net::HTTPResponse object
		end
		@res
		@res_json = @res.to_json
		@res_hash = JSON.parse(@res_json)
		@res_url = @res_hash["location"]
		@res_url_string = @res_url.to_s
		@res_url_1 = @res_url_string.gsub(/(("http:\/\/api.soundcloud.com\/users\/))/, "")
		@res_url_2 = @res_url_1.gsub("?", "")
		@res_url_3 = @res_url_2.gsub(/(.jsonclient_id=d8b21e837485a3086c3f20da86fee214"])/, "")
		@user_id = @res_url_3.gsub("[", "")
		@user_tracks = @client.get("/users/#{@user_id}/tracks")
	end
 
	private
 	def search_params
    	params.require(:search).permit(:content)
  	end
  	
end
