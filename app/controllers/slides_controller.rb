class SlidesController < ApplicationController
  before_action :ensure_signed_in

  def index
    # TODO: add pagination, possibly
    @slides = current_user.slides.order(created_at: :desc).first(12)
  end

  def new
    @slide = Slide.build(user_id: current_user_id)
  end

  def create
    @slide = Slide.new slides_params.merge(user_id: current_user_id)

    if @slide.save
      redirect_to slide_url(@slide)
    else
      # TODO: maybe a flash message here
      debugger
      render "show", status: :unprocessable_content
    end
  end

  def show
    @slide = Slide.find params[:id]
  end

  def destroy
    @slide = Slide.find params[:id]
    @slide.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to slides_path, status: :see_other }
    end
  end

  private

  def slides_params
    params.require(:slide).permit(:presentation_id)
  end
end
