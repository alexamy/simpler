class TestsController < Simpler::Controller

  def index
    @time = Time.now
  end

  def create

  end

  def show
    @id = params[:id]
  end

end
