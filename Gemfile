source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby

gem 'fullcalendar-rails'
gem 'momentjs-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'devise'

gem 'less-rails' # Railsでlessを使えるようにする。Bootstrapがlessで書かれているため
gem 'twitter-bootstrap-rails' # Bootstrapの本体

gem 'rails_12factor', group: :production # railsを動かすためのgem

gem "carrierwave"

gem 'bootstrap3-datetimepicker-rails' # 日付日時をカレンダーから取得する為のgem

group :development, :test do
  gem 'hirb'         # モデルの出力結果を表形式で表示するGem
  gem 'hirb-unicode' # 日本語などマルチバイト文字の出力時の出力結果のずれに対応

  gem 'pry-rails'  # rails console(もしくは、rails c)でirbの代わりにpryを使われる
  gem 'pry-doc'    # methodを表示
  gem 'pry-byebug' # デバッグを実施

  gem 'better_errors' # エラーを見やすく表示
  gem 'binding_of_caller' # 例外が発生した際に変数の内容を出力する為のgem

  gem 'rspec-rails' # Rails専用の機能を追加するRSpecのラッパーライブラリ
  gem 'factory_girl_rails' # フィクスチャをファクトリで置き換える為のgem
  gem 'guard-rspec' # テストの自動実行の為のgem
end

group :test do
	gem 'faker' # 名前やメールアドレスなどのプレースホルダをファクトリに追加
	gem 'capybara' # Webアプリケーションのやりとりをプログラム上でシュミレートするためのgem
	gem 'database_cleaner' # テストデータベースを掃除する為のgem
	gem 'launchy' # 好きなタイミングでデフォルトのwebブラウザを開く為のgem
	gem 'selenium-webdriver' # ブラウザ上でJavaScriptを利用する機能をcapybaraでテストする為のgem(GUI)
	gem 'shoulda-matchers' # 便利なマッチャを使う為のgem
  gem 'poltergeist' # ブラウザを動かす為のgem(CUI)
end

gem 'websocket-rails' #websocket通信を利用するためのgem

gem 'kaminari' #ペ−ジネーションのためのgem
gem 'kaminari-bootstrap' #kaminariのviewをbootstrap用にカスタマイズするためのgem
