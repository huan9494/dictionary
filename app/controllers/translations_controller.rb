class TranslationsController < ApplicationController
	require 'rubygems'
	require 'mechanize'

  def index

  	@agent = Mechanize.new

  	if params[:query]
  		@keyword = params[:query].downcase.delete(' ').gsub(/[^a-z ]/,'')
  		

  		

	    if Translation.where(:keyword => @keyword).first
	  		@translation = Translation.where(:keyword => @keyword).first
	  		@translation.update(query_number: @translation.query_number + 1)
	  		@data_saved = true
	  	else

	  		#Search data on net--------------
		  		url = "http://tratu.soha.vn/dict/en_vn/" + @keyword
			  	@page = @agent.get url

			    url_img = "https://www.google.com/search?site=&tbm=isch&source=hp&biw=1290&bih=634&q=" + @keyword.to_s + "&oq=" + @keyword.to_s + "&gs_l=img.3..35i39k1j0l"
			    @page_img = @agent.get url_img

			    if @keyword
			      @content1 = @page.search("div#show-alter div#content-5")
			    end

			    keyword = params[:query]
			    img_arr = []
			    (0..4).each do |idx|
		        	img_arr << @page_img.search("img")[idx].attribute("src").text
		        end

		        discription_arr = []
		        @content1.each do |content1|
            		discription_arr << {black: content1.search("h5 span.mw-headline").text}
        			content1.search("dl dd dl dd").each do |subcontent1|
		                if subcontent1.search("a").any?
		                        discription_arr << {red: subcontent1.text}
		                else
		                        discription_arr << {green: subcontent1.text}
		                end
            		end
            	end

	        #Search data on net--------------

	        	@data_saved = false
			    SaveDataJob.perform_later(keyword,discription_arr,img_arr)
	  	end


  	end


  end

  def auto_complete
  	render json: Translation.search(params[:query], limit: 10).map(&:keyword)
  end

end
