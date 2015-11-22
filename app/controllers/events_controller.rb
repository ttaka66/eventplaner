class EventsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_event, only: [:show, :edit, :update, :destroy, :deside, :comment_page]

  respond_to :html

  def index
    @events = current_user.events
    # respond_with(@events)
  end

  def host
    @events = Event.where(owner: current_user).order(created_at: :desc)
  end

  def gest
    @plans = current_user.timeplans.select(:event_id).distinct
  end

  def show
    # GoogleMapの表示

    @comment = Comment.new
    @comments = @event.comments.page(params[:comment_page]).per(5).
      order(created_at: :desc)

    # イベント未確定の場合
    if @event.color == 'yellow'
      # イベントに関するプラン取得
      @timeplans = @event.timeplans

      # 個々のプラン取得
      @timeplans.each do |tp|
        # Timeplanに関する参加人数を集計
        cnt = Entry.where(timeplan_id: tp.id, attendance: true).count
        # attend_cntに代入
        tp.attend_cnt = cnt
        # 自分の出欠を取得
        entry = Entry.find_by(user_id: current_user, timeplan_id: tp.id)
        # my_attendにentryオブジェクトを代入
        tp.my_entry = entry

      end

    end
    respond_with(@event)
  end

  def new
    @act = params[:act]
    @event = Event.new

    if @act == 'group'
      2.times { @event.timeplans.build }
    end
    
    respond_with(@event)
    
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @act = params[:act]
    if @act == 'group'

      @event.timeplans.each do |tp|
        # 自分を候補日時に関連させる
        tp.users << current_user

        # 招待メンバーのユーザー名を取得
        params['invitees'].each do |inv|
          # Userモデルを取得
          if i = User.find_by(username: inv)
            # 候補日時に関連するユーザーを作成
            tp.users << i
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
          flash[:act] = @act
          render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    @event.update(event_params)
    respond_with(@event) 
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
