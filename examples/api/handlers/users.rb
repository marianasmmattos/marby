class Users < ApplicationHandler
  include ::User

  def index
    users = records { |data| data.all }

    render status: 200, type: :json, body: users
  end

  def show
    render status: 200, type: 'html', body: '<h1>Hello!</h1>'
  end

  def create
    user = records { |data| data.insert(params.to_h) }

    render status: 200, type: :json, body: user
  end
end