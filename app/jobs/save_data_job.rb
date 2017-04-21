class SaveDataJob < ApplicationJob
  queue_as :default

  def perform(keyword,discription_arr,img_arr)
			    
#Save to database

		@translation = Translation.new

		@translation.keyword = keyword
		@translation.discription = discription_arr
		@translation.pictures = img_arr
		@translation.query_number = 1

		@translation.save

	#Save to database
  end
end
