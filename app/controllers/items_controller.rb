class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]
  before_action :initialize_sort, only: :index

  def index
    @items = Item.all
    handle_search
    handle_filter
    handle_sort
    prepare_filter_content
    handle_index_response
  end

  def show
  end

  def new
    @item = Item.new
    @form_cancel_link = items_path
  end

  def edit
    @form_cancel_link = items_path
  end

  def create
    @item = Item.new(item_params)

    # respond_to do |format|
    #   if @item.save
    #     format.html { redirect_to items_path, notice: "Item was successfully created." }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #   end
    # end
    if @item.save
      redirect_to items_path
      flash[:success] = "Item was successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      redirect_to items_path
      flash[:success] = "Item was successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path
    flash[:success] = "Item was successfully binned"
  end

  def clear_filters
    clear_session(:filter_any_topic_of, :keyword)
    redirect_to items_path
  end

  def filter
    clear_session(:filter_any_topic_of, :keyword)
    session[:keyword] = params[:keyword] || session[:keyword]
    set_session(:any_topic_of)
    redirect_to items_path
  end

  private

  def handle_filter
    @items = ItemQuery.new(session, @items).call
    # %w[any_topic_of].each do |key|
    #   @items = @items.send(key, session["filter_#{key}"]) if session["filter_#{key}"].present?
    # end
  end

  def prepare_filter_content
    @topics = Item.topics
  end

  def initialize_sort
    session[:item_sort_option] = params[:item_sort_option] || session[:item_sort_option] || "date_desc"
  end

  def handle_search
    return if session[:keyword].blank?
    @items = @items.keyword(session[:keyword])
  end

  def handle_sort
    @items = @items.send("order_by_#{session[:item_sort_option]}")
  end

  def handle_index_response
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

    def set_item
      @item = Item.find(params.expect(:id))
    end

    def item_params
      params.expect(item: [ :date, :topic, :subtopic, :content ])
    end
end
