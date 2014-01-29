class DownloadableController < ApplicationController

	require 'soundcloud'

	def index
		@client = Soundcloud.new(client_id: 'd8b21e837485a3086c3f20da86fee214')
		@user_tracks = @client.get('/users/28508171/tracks')
	end

end
