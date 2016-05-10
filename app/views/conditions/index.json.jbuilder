json.array!(@conditions) do |condition|
  json.extract! condition, :id, :user_id, :cday, :mp, :hp, :temperature, :whether, :sleep_time, :eja_times, :noting
  json.url condition_url(condition, format: :json)
end
