class EventsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_event, only: [:show, :edit, :update, :destroy, :deside, :comment_page]

  respond_to :html

  def index
    @events = current_user.events
    @entries = Entry.where(user_id: current_user.id, attendance: true)
  end

  def desided_all
    @events = current_user.events.where('start > ?', Time.zone.now).order(:start)
    .page(params[:events_page]).per(10)
    @title = t('desided events')
    render action: 'events_list'
  end

  def host
    @events = Event.where(owner: current_user).newer.page(params[:events_page]).per(10)
    @title = t('hoseted events')
    render action: 'events_list'
  end

  def gest
    events_array = current_user.timeplans.pluck(:event_id).uniq
    # render text: events_array
    @events = Event.where(id: events_array).where.not(owner: current_user)
    .newer.page(params[:events_page]).per(10)
    @title = t('invited events')
    render action: 'events_list'
  end

  def show
    @comment = Comment.new
    @comments = @event.comments.page(params[:comment_page]).per(5).
      order(created_at: :desc)

    # イベント未確定の場合
    if @event.color == 'yellow'
      # イベントに関するプラン取得
      @timeplans = @event.timeplans
    end
    respond_with(@event)
  end

  def new
    @act = params[:act]
    @event = Event.new

    if @act == 'group'
      @my_friends = current_user.friends
      2.times { @event.timeplans.build }
    end
    
    respond_with(@event)
    
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @act = params[:act]
    @invitee_ids = params[:invitees]
    if @act == 'group'

      @event.timeplans.each do |tp|
        # 自分を候補日時に関連させる
        tp.users << current_user

        # 招待メンバーのユーザー名を取得
        if @invitee_ids
          @invitee_ids.each do |inv|
            begin
            # Userモデルを取得
            i = User.find(inv)
            # 候補日時に関連するユーザーを作成
            tp.users << i
            rescue
            end
          end

        end

      end

    else
      @event.users << current_user

    end
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: '新しいイベントが作成されました'}
        format.json { render action: 'show', status: :created, location: @event}
      else
        format.html {
          @my_friends = current_user.friends
          flash[:timeplans_cnt] = params[:timeplans_cnt]
          render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    @event.update(event_params)
    redirect_to  @event, notice: '場所を変更しました'
  end

  def deside
    # 確定したプランを取得
    tp = Timeplan.find(params[:tp_id])
    if Entry.where(timeplan_id: tp.id, attendance: true).count == 0
      redirect_to @event, alert: '参加者がいないイベントは登録できません'

    else
      @event.transaction do
        # 開始と終了とカラーを更新
        @event.update(start: tp.start, end: tp.end, color: 'green')
        # イベント情報を更新
        @event.update(event_params)

        # 参加できるユーザーを登録
        tp.entries.each do |ent|
          if ent.attendance == true
            @event.users << ent.user
          end
        end
        # イベントに関連するtimeplansレコードとentriesレコードを削除
        @event.destroy_timeplans_and_entries
        # raise '例外'
         redirect_to @event, notice: 'イベントが確定しました'
      end
    end
  rescue => e
    render text: e.message
  end

  def destroy
    if @event.owner_id
      @event.transaction do
        @event.destroy_timeplans_and_entries
      end

    end
    @event.destroy
    redirect_to root_path, notice: 'イベントを削除しました'
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
      :title,
      :message,
      :start,
      :end,
      :color,
      :owner_id,
      :allday,
      :category,
      :place,
      :address,
      :cost,
      :password,
      timeplans_attributes: [:start, :end]
      )
  end

end
