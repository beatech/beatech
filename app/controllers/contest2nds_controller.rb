# -*- coding: utf-8 -*-
class Contest2ndsController < ApplicationController
  def result
    @contest2nds = Contest2nd.all
    @contestdates = Contestdate.all
    @team = Hash.new
    @total_score = Hash.new
    @total_rate = Hash.new
    @total_bp = Hash.new

    %w|A B C|.each do |team_char|
      @team[team_char] = Contest2nd.find(:all, :conditions => {:team => team_char})
      @total_score[team_char] = 0
      @total_rate[team_char] = 0
      @total_bp[team_char] = 0
    end

    %w|A B C|.each do |team_char|
      @team[team_char].each_with_index do |member, i|
        member["total_score"] = member.a_score + member.b_score + member.c_score
        @total_score[team_char] += member["total_score"]

        member["total_bp"] = member.a_bp + member.b_bp + member.c_bp
        @total_bp[team_char] += member["total_bp"]

        %w|a b c|.each do |rate_char|
          if @team[team_char.upcase][i].notes == 0
            member[rate_char + "_rate"] = 0
          else
            member[rate_char + "_rate"] = member.send(rate_char + "_score") * 1000 / (@team[rate_char.upcase][i].notes * 2)
          end
        end
        member["total_rate"] = member["a_rate"] + member["b_rate"] + member["c_rate"]
        @total_rate[team_char] += member["total_rate"]

        # percentize
        %w|a b c total|.each do |rate_char|
          rate = member[rate_char + "_rate"]
          member[rate_char + "_rate"] = (rate / 10).to_s + '.' + (rate % 10).to_s
        end
      end

      # percentize
      total_rate = @total_rate[team_char]
      @total_rate[team_char] = (total_rate / 10).to_s + '.' + (total_rate % 10).to_s
    end

    @title = '第二回部内大会'
  end

  def tunesedit
    @order = params[:order]
    @tunes = Array.new
    @a_team = Contest2nd.find(:all,
      :conditions => {:team => 'A', :order => @order})
    @tunes[0] = @a_team[0]
    @b_team = Contest2nd.find(:all,
      :conditions => {:team => 'B', :order => @order})
    @tunes[1] = @b_team[0]
    @c_team = Contest2nd.find(:all,
      :conditions => {:team => 'C', :order => @order})
    @tunes[2] = @c_team[0]
  end

  def scoreedit
    @order = params[:order]
    @tunes = Array.new
    @a_team = Contest2nd.find(:all,
      :conditions => {:team => 'A', :order => @order})
    @tunes[0] = @a_team[0]
    @b_team = Contest2nd.find(:all,
      :conditions => {:team => 'B', :order => @order})
    @tunes[1] = @b_team[0]
    @c_team = Contest2nd.find(:all,
      :conditions => {:team => 'C', :order => @order})
    @tunes[2] = @c_team[0]
  end

  def tunesupdate
    @tunes = params[:tune]
    @tunes.each do |tune|
      data = tune[1]
      @order = data["order"]
      @team = data["team"]

      contests = Contest2nd.find(:all,
        :conditions => {:team => @team, :order => @order})
      contest = contests[0]
      contest.notes = data["notes"]
      contest.music = data["music"]
      contest.save
    end

    @page = Page.find_by_url('contest2nd')
    @page.touch
    redirect_to root_url + 'contest2nd', :notice => '曲名の編集に成功しました。'
  end

  def scoreupdate
    @tunes = params[:tune]
    @tunes.each do |tune|
      data = tune[1]
      @order = data["order"]
      @team = data["team"]

      contests = Contest2nd.find(:all,
        :conditions => {:team => @team, :order => @order})
      contest = contests[0]
      contest.a_score = data["a_score"] if data["a_score"].length > 0
      contest.a_bp = data["a_bp"] if data["a_bp"].length > 0
      contest.b_score = data["b_score"] if data["b_score"].length > 0
      contest.b_bp = data["b_bp"] if data["b_bp"].length > 0
      contest.c_score = data["c_score"] if data["c_score"].length > 0
      contest.c_bp = data["c_bp"] if data["c_bp"].length > 0
      contest.url = data["url"] if data["url"]
      contest.save
    end

    @page = Page.find_by_url('contest2nd')
    @page.touch
    redirect_to root_url + 'contest2nd', :notice => '対戦結果の編集に成功しました。'
  end

  def index
    @contest2nds = Contest2nd.all
    @title = 'データ編集'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @contest2nds }
    end
  end

  def show
    @contest2nd = Contest2nd.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @contest2nd }
    end
  end

  def new
    @contest2nd = Contest2nd.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @contest2nd }
    end
  end

  def edit
    @contest2nd = Contest2nd.find(params[:id])
  end

  def create
    @contest2nd = Contest2nd.new(params[:contest2nd])

    respond_to do |format|
      if @contest2nd.save
        format.html { redirect_to @contest2nd,
          :notice => 'Contest2nd was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @contest2nd = Contest2nd.find(params[:id])

    respond_to do |format|
      if @contest2nd.update_attributes(params[:contest2nd])
        format.html { redirect_to root_url + 'contest2nd',
          :notice => '対戦結果の編集に成功しました。' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @contest2nd.errors,
          :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @contest2nd = Contest2nd.find(params[:id])
    @contest2nd.destroy

    respond_to do |format|
      format.html { redirect_to contest2nds_url }
      format.json { head :no_content }
    end
  end
end
