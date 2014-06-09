class TweetsController < ApplicationController
  def search
    #9gag.com/gag/a2NXxR9
     render :json => Tweet.search("なめこ", 100)
  end
end
