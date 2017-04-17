class TranslationsController < ApplicationController
	require 'rubygems'
	require 'mechanize'

  def index

  	@agent = Mechanize.new

  	if params[:keyword_search]
  		@keyword = params[:keyword_search].downcase.delete(' ').gsub(/[^a-z ]/,'')
  		

	    if Translation.where(:keyword => @keyword).first
	  		@translation = Translation.where(:keyword => @keyword).first
	  		# @translation.update(query_number: @translation.query_number + 1)
	  	else

	  		#Search image on net--------------
		  		url = "http://tratu.soha.vn/dict/en_vn/" + @keyword
			  	@page = @agent.get url

			    url_img = "https://www.google.com/search?site=&tbm=isch&source=hp&biw=1290&bih=634&q=" + @keyword.to_s + "&oq=" + @keyword.to_s + "&gs_l=img.3..35i39k1j0l"
			    @page_img = @agent.get url_img

			    if @keyword
			      @content1 = @page.search("div#show-alter div#content-5")
			    end

			    @img_arr = []
			    (0..4).each do |idx|
		        	@img_arr << @page_img.search("img")[idx].attribute("src").text
		        end

		        @discription_arr = []
		        @content1.each do |content1|
            		@discription_arr << {black: content1.search("h5 span.mw-headline").text}
        			content1.search("dl dd dl dd").each do |subcontent1|
		                if subcontent1.search("a").any?
		                        @discription_arr << {red: subcontent1.text}
		                else
		                        @discription_arr << {green: subcontent1.text}
		                end
            		end
            	end

	        #Search image on net--------------

	        #Save to database

		  		@translation = Translation.new

		  		@translation.keyword = @keyword
		  		@translation.discription = @discription_arr
		  		@translation.pictures = @img_arr
		  		@translation.query_number = 1

		  		@translation.save

	  		#Save to database

	  	end


  	end


  end

  def show
  	@translation = Translation.find(params[:id])
  end

  def new
  	@translation = Translation.new
  end

  def create
  	@translation = Translation.new(translation_params)
  	@translation.save
  end

  private
  def translation_params
  	Params.require(:translation).permit(:keyword, :discription, :pictures, :query_number)
  end
end
