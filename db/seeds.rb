# -*- coding: utf-8 -*-
User.create!(:account => 'admin', :password => 'test', :password_confirmation => 'test')

titles = %w(東工大音楽ゲーム愛好会BEATECH メンバー紹介 活動記録 入部申請 成果報告 部内大会 部内KAC 弐寺オリコ SDVX2WR RPS RPS登録方法 音ゲー攻略 ゲーセン情報 ACコン製作記 BEATECHとは 入部希望者へ 他大の方へ)
urls = %w(frontpage members history registration achievements contest kac iidxoc sdvx2wr rps howtorps tips gamecenter accon about registration outsider)
menus = %w(0 1 1 1 2 2 2 2 2 3 3 3 3 3 4 4 4)
limits = %w(1 2 0 2 2 0 0 0 0 2 0 0 0 0 1 2 1)

num = titles.size - 1           
0.upto(num) do |idx|  
  Page.create!(
               :title => titles[idx],
               :url => urls[idx],
               :menu => menus[idx].to_i,
               :limit => limits[idx].to_i,
               :text => "<h2>" + titles[idx] + "</h2>" 
               )
end
