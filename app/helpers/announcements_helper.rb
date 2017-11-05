module AnnouncementsHelper
  def visible?(announcement)
    if announcement.displayflag == 1
      true
    else
      if announcement.displayflag == 2 and session[:user_name]
        true
      else
        if announcement.displayflag == 3 and User.staff?(session[:user_name])
          true
        else
          if announcement.displayflag == 4 and User.student?(session[:user_name])
            true
          end
        end
      end
    end
  end
end
