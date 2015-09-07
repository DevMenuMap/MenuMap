require 'net/http'

class Restaurant < ActiveRecord::Base

	has_one :rest_key, dependent: :destroy
	has_one :rest_info, dependent: :destroy
	has_many :rest_imgs, dependent: :destroy
	has_many :menu_titles, dependent: :destroy
	has_many :menus, through: :menu_titles
	has_many :comments, dependent: :destroy
	has_many :report_rest_errs, dependent: :destroy

	# mymap
	has_many :mymap_relationships, class_name: "MymapRelationship",
																foreign_key: "mymap_rest_id",
																dependent: 	 :destroy

	# order for posts
	default_scope -> { order(menu_on: :desc, updated_at: :desc) }

	# image upload
	mount_uploader :picture, PictureUploader
	validate :picture_size

	# for restaurant index page's pagination.
	self.per_page = 10

	def self.ping(offset)
		header = {
			"User-agent" => "request",
			"Host" => "apis.naver.com",
			"Progma" => "no-cache",
			"Content-type" => "application/x-www-form-urlencoded",
			"Accept" => "*/*",
			"Authorization" => "Bearer " + 'AAAAN8wgRyFhowAcR4CMuvk/efAw7n+eG0Gc0xOfJKfSrm6Yg+A+4+am23oxCIgJlOVhlxVJzTXmyxYyr4k1N3YbqaQ='
		}

		uri = URI.parse('https://apis.naver.com/crawl/nsyndi/v2')

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		
		atom_url = 'http://www.menumap.co.kr/sitemap.atom?offset=' + offset.to_s

		args = { ping_url: atom_url }
		uri.query = URI.encode_www_form(args)

		request = Net::HTTP::Post.new(uri.request_uri, header)
		http.request(request)
	end
	private

		# set maximum image size.
		def picture_size
			if picture.size > 10.megabytes
				errors.add(:picture, "10MB를 넘는 사진입니다.")
			end
		end
end
