# Workforce Challenge

## Setup

cd wf_challenge
<br/>
bundle install
<br/>
rails s to start the server on localhost:3000/

### Optional exercises

1. Edit User Details
   <br/>
   Added edits function and routes to properly edit their own name and email.

2. Editing Shifts

```ruby
      def update
        date = shift_params[:date]
        start_datetime = parse_date_time(date, shift_params[:start])
        finish_datetime = parse_date_time(date, shift_params[:finish])
        @shift = Shift.update(params[:id], start: start_datetime, finish: finish_datetime, break_length: shift_param[:break_length])
    end
```

<br/>

3.  Overnight Shifts and penalty on sundays
    Hourly rate is doubled when worked on sunday

```ruby
       def calc_shift_cost(start, finish, hours, rate, break_hours)
        sunday_hours = 0
        normal_hours = 0
        #sunday penalty
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
```

## Excercises not complete

1. Departed Employee Shift storage
   My idea would've been creating a new table for departed employees as a new schema and add to this table whenever a employee leaves the organization and add possibly a depedent on the shifts to remove it prior.

2. Multiple breaks
   Add these breaks into a data structure, possibly an array and sum that data to be the total break_length. Possibly with the frontend side and add how many breaks taken and then seperate them into x amount of structures.
3. Single Page App / Javascript Enhancements
   Had ideas on how I would have structured this with react. Below would be a code snippet I woulda used for ajax calls to the backend for user authentication and then add reducers and a store to initialize the state in react.

   ```javascript
   ./util/session_api_util.js

   export const login = (user) => {
       return $.ajax({
           method: "POST",
           url: "/login",
           data: {user}
       })
   }

     export const signup = (user) => {
       return $.ajax({
           method: "POST",
           url: "/signup",
           data: {user}
       })
   }

     export const logout = () => {
       return $.ajax({
           method: "DELETE",
           url: "/logout",
       })
   }
   ```

4. Multiple organizations and Filtering shifts.
