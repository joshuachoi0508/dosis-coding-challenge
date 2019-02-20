class PannelsController < ApplicationController
    def index
        @pannel = Pannel.new
        @pannels = Pannel.all.order("date ASC")
    end

    def create
        @pannel = Pannel.new(pannel_params)
        @pannels = Pannel.all.order("date ASC")

        if @pannel.amount && @pannel.reading
            @pannel.acceptance = (@pannel.amount/@pannel.reading).round(1)
        elsif @pannel.advisement && @pannel.reading
            @pannel.acceptance = (@pannel.advisement/@pannel.reading).round(1)
        end

        
        if @pannel.amount && @pannel.advisement
            @pannel.accepted = ((@pannel.amount / @pannel.advisement) * 100).round
        else 
            pannels = Pannel.all.order("date ASC")
            index = Pannel.all.length - 1
            last_pannel = pannels[index]

            if last_pannel.nil?
                @pannel.accepted = nil
            else 
                advisement = last_pannel.advisement
            end


            while advisement.nil? && last_pannel
                index -= 1;
                last_pannel = Pannel.all[index]
                if last_pannel.advisement 
                    advisement = last_pannel.advisement
                else 
                    break
                end
            end

            if @pannel.amount && advisement 
                @pannel.accepted = ((@pannel.amount / advisement) * 100).round
            end
        end


        if @pannel.save
            redirect_to pannels_url
        else
            flash.now[:errors] = @pannel.errors.full_messages
            render :index
        end
    end

  def edit
    @pannel = Pannel.find(params[:id])
    render :edit
  end

  def update
    @pannel = Pannel.find(params[:id])

    if @pannel.update(pannel_params)
      redirect_to pannels_url
    else
      flash.now[:errors] = @pannel.errors.full_messages
      render :edit
    end
  end

  private
  def pannel_params
    params.require(:pannel).permit(:PID, :SID, :date, :reading, :amount, :advisement)
  end
end