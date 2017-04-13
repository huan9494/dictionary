class IndexController < ApplicationController
	require 'rubygems'
	require 'mechanize'

  def find

  	@agent = Mechanize.new

  	@keyword = params[:keyword]
  	url = "http://tratu.soha.vn/dict/en_vn/" + @keyword.to_s
  	@page = @agent.get url

    url_img = "https://www.google.com/search?site=&tbm=isch&source=hp&biw=1290&bih=634&q=" + @keyword.to_s + "&oq=" + @keyword.to_s + "&gs_l=img.3..35i39k1j0l"
    @page_img = @agent.get url_img
    if @keyword
      @content1 = @page.search("div#show-alter div#content-5")
    end
  end
end
