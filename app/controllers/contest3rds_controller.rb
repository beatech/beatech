# -*- encoding: utf-8 -*-
class Contest3rdsController < ApplicationController
  # GET /contest3rd
  def result
    @contest3rds = Contest3rd.all
    @contestdate3rds = Contestdate3rd.all

    @team = Hash.new

    @clearlamp = ["F", "AC", "EC", "C", "H", "EXH", "FC"]

    @rankpoint = [0, 20, 50]
    @clearbonus = []

    @team_total = Hash.new

    13.times do |i|
      @clearbonus[i] = [].fill(0, 0..6)
      @clearbonus[i][4..6] = [5, 10, 20]
    end

    %w|A B C|.each do |team_char|
      @team[team_char] = Contest3rd.where("team = ?", team_char)
      @team_total[team_char] = 0
    end

    (@contestdate3rds.size).times do |i|

      ranks_a = [@team['A'][i].a_score, @team['B'][i].a_score, @team['C'][i].a_score].sort!
      ranks_b = [@team['A'][i].b_score, @team['B'][i].b_score, @team['C'][i].b_score].sort!
      ranks_c = [@team['A'][i].c_score, @team['B'][i].c_score, @team['C'][i].c_score].sort!

      %w|A B C|.each do |team_char|
        person = @team[team_char][i]
        total = 0

        total += @rankpoint[ranks_a.index(person.a_score)]
        total += @rankpoint[ranks_b.index(person.b_score)]
        total += @rankpoint[ranks_c.index(person.c_score)]

        total += @clearbonus[@team['A'][i].difficulty][person.a_clear] unless @team['A'][i].difficulty.nil? || person.a_clear.nil?
        total += @clearbonus[@team['B'][i].difficulty][person.b_clear] unless @team['B'][i].difficulty.nil? || person.b_clear.nil?
        total += @clearbonus[@team['C'][i].difficulty][person.c_clear] unless @team['C'][i].difficulty.nil? || person.c_clear.nil?

        @team_total[team_char] += total
        person.total = total
      end

    end

    @title = '第三回部内大会'

    respond_to do |format|
      format.html
      format.json { render json: Contest3rd.all }
    end
  end

  def tunesedit
    @difficulty = (1..12).to_a.map do |i|
      ["☆" + i.to_s, i]
    end

    @order = params[:order]
    @tunes = Array.new

    @a_team = Contest3rd.find(:all,
      :conditions => {:team => 'A', :order => @order})
    @tunes[0] = @a_team[0]
    @b_team = Contest3rd.find(:all,
      :conditions => {:team => 'B', :order => @order})
    @tunes[1] = @b_team[0]
    @c_team = Contest3rd.find(:all,
      :conditions => {:team => 'C', :order => @order})
    @tunes[2] = @c_team[0]
  end

  def scoreedit
    lamp = ["F", "AC", "EC", "C", "H", "EXH", "FC"]
    i = -1
    @clearlamp = lamp.map {|t|
      i += 1
      [t, i]
    }
    @order = params[:order]
    @tunes = Array.new
    @a_team = Contest3rd.find(:all,
      :conditions => {:team => 'A', :order => @order})
    @tunes[0] = @a_team[0]
    @b_team = Contest3rd.find(:all,
      :conditions => {:team => 'B', :order => @order})
    @tunes[1] = @b_team[0]
    @c_team = Contest3rd.find(:all,
      :conditions => {:team => 'C', :order => @order})
    @tunes[2] = @c_team[0]
  end

  def tunesupdate
    @tunes = params[:tune]
    @tunes.each do |tune|
      data = tune[1]
      @order = data["order"]
      @team = data["team"]

      contests = Contest3rd.find(:all,
        :conditions => {:team => @team, :order => @order})
      contest = contests[0]
      contest.difficulty = data["difficulty"]
      contest.music = data["music"]
      contest.save
    end

    @entry = Entry.find_by_url('contest3rd')
    @entry.touch
    redirect_to root_url + 'contest3rd', :notice => '曲名の編集に成功しました。'
  end

  def scoreupdate
    @tunes = params[:tune]
    @tunes.each do |tune|
      data = tune[1]
      @order = data["order"]
      @team = data["team"]

      contests = Contest3rd.find(:all,
        :conditions => {:team => @team, :order => @order})
      contest = contests[0]
      contest.a_score = data["a_score"] if data["a_score"].length > 0
      contest.a_clear = data["a_clear"] if data["a_clear"].length > 0
      contest.b_score = data["b_score"] if data["b_score"].length > 0
      contest.b_clear = data["b_clear"] if data["b_clear"].length > 0
      contest.c_score = data["c_score"] if data["c_score"].length > 0
      contest.c_clear = data["c_clear"] if data["c_clear"].length > 0
      contest.url = data["url"] if data["url"]
      contest.save
    end

    @entry = Entry.find_by_url('contest3rd')
    @entry.touch
    redirect_to root_url + 'contest3rd', :notice => '対戦結果の編集に成功しました。'
  end


  def index
    @contest3rds = Contest3rd.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contest3rds }
    end
  end

  # GET /contest3rds/1
  # GET /contest3rds/1.json
  def show
    @contest3rd = Contest3rd.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contest3rd }
    end
  end

  # GET /contest3rds/new
  # GET /contest3rds/new.json
  def new
    @contest3rd = Contest3rd.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contest3rd }
    end
  end

  # GET /contest3rds/1/edit
  def edit
    @contest3rd = Contest3rd.find(params[:id])
  end

  # POST /contest3rds
  # POST /contest3rds.json
  def create
    @contest3rd = Contest3rd.new(params[:contest3rd])

    respond_to do |format|
      if @contest3rd.save
        format.html { redirect_to @contest3rd, notice: 'Contest3rd was successfully created.' }
        format.json { render json: @contest3rd, status: :created, location: @contest3rd }
      else
        format.html { render action: "new" }
        format.json { render json: @contest3rd.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contest3rds/1
  # PUT /contest3rds/1.json
  def update
    @contest3rd = Contest3rd.find(params[:id])

    respond_to do |format|
      if @contest3rd.update_attributes(params[:contest3rd])
        format.html { redirect_to @contest3rd, notice: 'Contest3rd was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contest3rd.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contest3rds/1
  # DELETE /contest3rds/1.json
  def destroy
    @contest3rd = Contest3rd.find(params[:id])
    @contest3rd.destroy

    respond_to do |format|
      format.html { redirect_to contest3rds_url }
      format.json { head :no_content }
    end
  end
end
