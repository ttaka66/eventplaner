class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :deside]
  before_action :set_login_user, only: [:index, :host, :gest, :show, :new, :create]

  respond_to :html

  def index
    @events = @login_user.events
    # respond_with(@events)
  end

  def host
    @events = Event.where(orner: @login_user.id).order(created_at: :desc)
  end

  def gest
    @plans = @login_user.timeplans.select(:event_id).distinct
  end

  def show
    # イベント未確定の場合
    if @event.color = 'yellow'
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
      render 'undecided'
    end
    # respond_with(@event)
  end

  def new
    @act = params[:act]
    @event = Event.new

    if @act == 'group'
      # @event.timeplans.build
      3.times { @event.timeplans.build }
    end
    
    respond_with(@event)
    
  end

  def edit
  end

  def create
    if params[:act] == 'group'

      # イベントに対する候補日時を作成
      @event = Event.new(event_params)
      # render json: @event.timeplans
      
      @event.timeplans.each do |tp|
        # 自分を候補日時に関連させる
        tp.users << @login_user

        # 招待メンバーのユーザー名を取得
        params['invitees'].each do |inv|
          # Userモデルを取得
          if i = User.find_by(username: inv)
            # 候補日時に関連するユーザーを作成
            tp.users << i
          end
        end

      end
      @event.save

    else
      @login_user.events.create(event_params)

    end
    redirect_to @event
  end

  def update
    @event.update(event_params)
    respond_with(@event) 
  end

  def deside
    # 確定したプランを取得
    tp = Timeplan.find(params[:tp_id])
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
      @event.timeplans.each do |tp2|
        tp2.entries.destroy_all
        tp2.destroy
      end
      # raise '例外'
      redirect_to @event
    end
  rescue => e
    render text: e.message
  end

  def destroy
    @event.destroy
    respond_with(@event)
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
        :orner,
        :allday,
        :category,
        :place,
        :address,
        :cost,
        :password,
        timeplans_attributes: [:start, :end]
        )
    end

    def set_login_user
      @login_user = User.find(current_user.id)
    end
end
