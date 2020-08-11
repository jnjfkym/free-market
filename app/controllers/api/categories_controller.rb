class Api::CategoriesController < ApplicationController

  def index
    "-----------------"
    "受け取ったカテゴリのID"
    params[:category_id]
    "-----------------"
    category = Category.find(params[:category_id])
    @categories = category.children
    ## -----追加ここから-----
    "-----------------"
    "子孫カテゴリ"
    @categories.pluck(:name)
    "-----------------"
    ## -----追加ここまで-----
  end

end