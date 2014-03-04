class SearchController < ApplicationController

	# curl -v 'http://api.soundcloud.com/resolve.json?url=http://soundcloud.com/fuck-vic-mensa&client_id=d8b21e837485a3086c3f20da86fee214'
	# client_id = d8b21e837485a3086c3f20da86fee214

	require 'soundcloud'

	def new
		@search = Search.new
	end

	def create
  		@search = Search.create(search_params)
  		redirect_to search_index_path
	end

	def index
		@search = Search.last
		@search_result = @search.content
		@client = Soundcloud.new(client_id: 'd8b21e837485a3086c3f20da86fee214')
		@user_tracks = @client.get('/users/28508171/tracks')
	end
 
	private
 	def search_params
    	params.require(:search).permit(:content)
  	end
end
