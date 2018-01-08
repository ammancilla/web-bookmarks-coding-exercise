class BookmarksController < ApplicationController
  layout 'simple', only: :edit

  before_action :find_bookmark, except: [:index, :create]

  def index
    @bookmark = Bookmark.new
    load_recent_bookmarks
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    if @bookmark.save
      redirect_to :root, notice: 'Bookmark saved :)'
    else
      load_recent_bookmarks
      render :index
    end
  end

  def edit
  end

  def update
    @bookmark.assign_attributes(bookmark_params)
    if @bookmark.save
      redirect_to :root, notice: 'Bookmark updated :)'
    else
      render :edit, layout: 'simple'
    end
  end

  def destroy
    if @bookmark.destroy
      redirect_to :root, notice: 'Bookmark removed :)'
    else
      redirect_to :root, alert: "Oops, we could'n remove the bookmark :("
    end
  end

  private

  def find_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def load_recent_bookmarks
    @bookmarks = Bookmark.recents
  end

  def bookmark_params
    bookmark_attrs = params.require(:bookmark).permit(:title, :url, :shortening)

    return bookmark_attrs if bookmark_attrs[:url].blank?

    uri = URI.parse( bookmark_attrs[:url] )
    site_url = "#{uri.scheme}://#{uri.hostname}"
    site = Site.find_by(url: site_url)

    if site.present?
      bookmark_attrs[:site] = site
    else
      bookmark_attrs[:site_attributes] = { url: site_url }
    end

    bookmark_attrs
  end
end
