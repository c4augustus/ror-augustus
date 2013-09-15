json.array!(@diagrams) do |diagram|
  json.extract! diagram, :filename, :title, :revision, :revision_date, :width, :height
  json.url diagram_url(diagram, format: :json)
end
