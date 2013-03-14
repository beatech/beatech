# -*- coding: utf-8 -*-
module UsersHelper
  def user_data(user)
    text =  '<h3><a href="' + root_url + 'users/' + user.account + '">' +
      User.name_by_account(user.account) + '</a>'
    if screen_names = User.screen_names_by_account(user.account)
      text += ' - '
      screen_names.each_with_index do |screen_name, i|
        text += ', ' if i != 0
        text += '<a href="https://twitter.com/' + screen_name + '">@' +
          screen_name + '</a>'
      end
    end
    text += '<span class="pull-right">'
    
    if (@current_user && @current_user.account == user.account) || admin?
      text += link_to('編集', root_url + 'users/edit/' + user.account)
    end
      
    if admin?
      text += ' ' + link_to('削除', root_url + 'users/destroy/' + user.account)
    end
    
    text += '</span>'
    text += '</h3><div id="profile-left">'
    text += '<img src="' + User.profile_image_by_account(user.account) +
      '" style="width: 73px; height: 73px; position:absolute; -webkit-border-radius: 3px; -moz-border-radius: 3px; border-radius: 3px;">'
    text += '</div><div id="profile-right">'
    text += PagesController.new.convert_wiki(
      User.short_profile_by_account(user.account)
    )
    text += '</div>'
  end

  def admin?
    if @current_user && @current_user.account == 'ikstrm'
      true
    else
      false
    end
  end  
end
