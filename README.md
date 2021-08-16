# Workforce Challenge

## Setup

cd wf_challenge
<br/>
bundle install
<br/>
rails s to start the server on localhost:3000/

### Optional exercises

1.Edit User Details
<br/>
Added edits function and routes to properly edit their own name and email.
<br/>
2.Editing Shifts

```ruby
      def update
        date = shift_params[:date]
        start_datetime = parse_date_time(date, shift_params[:start])
        finish_datetime = parse_date_time(date, shift_params[:finish])
        @shift = Shift.update(params[:id], start: start_datetime, finish: finish_datetime, break_length: shift_param[:break_length])
    end
```
<br/>

3. 