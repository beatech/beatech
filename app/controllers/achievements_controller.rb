# -*- coding: utf-8 -*-
class AchievementsController < ApplicationController
  def index
    @title = "成果報告"
    @achievement = Achievement.new

    @achievements = Achievement.all
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
