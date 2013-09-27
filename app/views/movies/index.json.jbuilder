json.array!(@movies) do |movie|
  json.extract! movie, :filename, :title, :revision, :revision_data, :width, :height
  json.url movie_url(movie, format: :json)
end
