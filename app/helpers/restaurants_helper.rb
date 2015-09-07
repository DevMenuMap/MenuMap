module RestaurantsHelper

	def short_addr(addr)
		addr.split.take(3).pop(2).join(" ")
	end

	def css_on_menu(arg)
		if arg == 11
			"success"
		elsif arg == 1
			"warning"
		else
			"default"
		end
	end

	def words_on_menu(arg)
		if arg == 11
			"메뉴등록 완료"
		elsif arg == 1
			"메뉴 등록중"
		else
			"메뉴 미등록"
		end
	end

	def delivery_css(arg)
		if arg
			"del"
		else
			"nodel"
		end
	end

	def two_menus(arg1, arg2, arg3, arg4)
		if arg3.blank?
			arg1 + arg2
		else
			arg1 + arg2 + ", " + arg3 + arg4
		end
	end

	def meta_description(restaurant)
		description	 = "음식점 #{restaurant.name}("
		description	+= "#{restaurant.cat}) "
		description += "주요상권 및 위치: "
		description += "[#{restaurant.rest_info.title_addr}] " if restaurant.rest_info.title_addr.present?
		description += "#{restaurant.addr}"

		# 4~5 menus would appear on meta description.
		if restaurant.menus.present?
			title_menus = []
			restaurant.menus.take(5).each do |menu|
				if menu.menu_side_info
					title_menus << (menu.menu_name + menu.menu_side_info + " " + menu.menu_price.to_s + "원")
				else
					title_menus << (menu.menu_name + " " + menu.menu_price.to_s + "원")
				end
			end
			title_menus = title_menus.join(", ")
			description += ", 주요 메뉴의 메뉴판, 가격: " 
			description	+= "#{title_menus}"
		end

		if restaurant.phnum
			if restaurant.delivery
				description	+= ", 배달주문 전화번호: #{restaurant.phnum}" 
			else
				description	+= ", 전화번호: #{restaurant.phnum}" 
			end
		end

		description
	end
end
