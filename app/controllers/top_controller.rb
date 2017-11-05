class TopController < ApplicationController
  skip_before_action :authorize
  def index
    @announcements = Announcement.all
  end
end
