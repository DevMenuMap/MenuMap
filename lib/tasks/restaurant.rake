namespace :restaurants do
	desc 'Ping naver for seo'
	task :ping => :environment do
		error = [1432, 1446, 1392, 1278, 1345, 1374, 1396, 1319, 1350, 1419, 1443, 1445, 1360]
		error.each do |i|
			puts Restaurant.ping(i)
		end
	end
end
