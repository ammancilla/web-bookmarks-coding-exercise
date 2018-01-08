class SearchesController < ApplicationController
  def show
    @bookmark = Bookmark.new

    @title = params[:title]
    @url = params[:url]
    @shortening = params[:shortening]

    @bookmarks =
      if search_params.blank?
        Bookmark.recents
      else
        Bookmark.chain_scopes( search_params )
      end

    render 'bookmarks/index'
  end

  private

  def search_params
    params.permit(:title, :url, :shortening)
      .to_hash.keep_if { |_, val| val.present? }
  end
end
