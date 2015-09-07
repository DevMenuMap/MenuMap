class SitemapController < ApplicationController
	layout nil

  def show
		@static = "http://menumap.co.kr/"
		@restaurants = Restaurant.where("picture is not null OR menu_on > 0 OR delivery is true OR updated_at > ?", Time.now - 7.day)
		respond_to do |format|
			format.xml 
		end
  end

	def naver_seo
		@restaurants = Restaurant.where("menu_on = ? OR menu_on is null", 0).limit(100).offset(params[:offset].to_i*100)

		respond_to do |format|
			format.atom
		end
	end
end
