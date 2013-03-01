module Refinery
  module Videos
    class VideosController < ::ApplicationController

      before_filter :find_all_videos
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @distributor in the line below:
        present(@page)
      end

      def show
        @video = Video.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @distributor in the line below:
        present(@page)
      end

    protected

      def find_all_videos
        @videos = Video.order('position ASC')
        @videos = @videos.paginate(:page => params[:page])
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/videos").first
      end

    end
  end
end