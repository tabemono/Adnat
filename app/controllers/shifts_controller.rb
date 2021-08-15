class ShiftsController < ApplicationController
    def shift_params
        params.require(:shift).permit(:date, :start, :finish, :break_length)
    end

    def index
        @shift = Shift.new
        table_details
    end

    def create
        date = shift_params[:date]
        start_datetime = parse_date_time(date, shift_params[:start])
        finish_datetime = parse_date_time(date, shift_params[:finish])
        @shift = Shift.create(user_id: current_user.id, start: start_datetime, finish: finish_datetime, break_length: shift_params[:break_length])
        if @shift.save
            redirect_to shifts_path
        else
            table_details
            render "index"
        end
    end

    def edit
        @shift = Shift.find(params[:id])
    end

    def update
        date = shift_params[:date]
        start_datetime = parse_date_time(date, shift_params[:start])
        finish_datetime = parse_date_time(date, shift_params[:finish])
        @shift = Shift.update(params[:id], start: start_datetime, finish: finish_datetime, break_length: shift_params[:break_length])
        if @shift.errors.any?
            render "edit"
        else
            redirect_to shifts_path
        end
    end

    def destroy
        Shift.destroy(params[:id])
        redirect_to shifts_path
    end

private
    def parse_date_time(date, time)
        # parse into time format
        Time.zone.parse(date + " " + time)
    end

    def calc_shift_length(start, finish)
        # overnight shift
        if start.before? finish
            # same-day shift
            (finish - start) / 60 / 60
        else
            # overnight shift
            (finish.next_day() - start) / 60 / 60
        end
    end

    def calc_shift_cost(start, finish, hours, rate, break_hours)
        sunday_hours = 0
        normal_hours = 0
       #sunday penalty?
        if start.before? finish
            # same-day shift
            if start.sunday? 
                sunday_hours = hours
            else 
                normal_hours = hours
            end
        else
            # overnight shift
            actual_finish = finish.next_day() - (60*60*break_hours)
            difference = 0
            if start.sunday? && actual_finish.monday?
                # shift starts sunday and finishes Monday
                difference = (start.seconds_until_end_of_day + 1)/60/60
            elsif start.saturday? && actual_finish.sunday?
                # shift starts Saturday and finishes Sunday
                ##using built in seconds until midnight
                difference = (actual_finish.seconds_since_midnight)/60/60
            end
            sunday_hours = difference
            normal_hours = hours - difference
        end
        # return shift cost
        return (normal_hours * rate) + (sunday_hours * rate * 2)
    end

    def table_details
    
        @organization = Organization.find(current_user.organization_id)
      
        @shifts = Shift.includes(:user).where(users: {organization_id: current_user.organization_id}).order(created_at: :desc)
        #store in hash
        @names = {} # store the User's name
        @hours_worked = {} # store hours worked
        @shift_costs = {} # store shift costs

        @shifts.each do |shift|
            @names[shift] = User.find(shift.user_id).name
            shift_length = calc_shift_length(shift.start, shift.finish)
            hours_worked = shift_length - Float(shift.break_length) / 60
            shift_cost = calc_shift_cost(shift.start, shift.finish, hours_worked, @organization.hourly_rate, Float(shift.break_length)/60)
            ###
            @hours_worked[shift] = hours_worked.round(2)
            @shift_costs[shift] = shift_cost.round(2)
        end
    end
end
