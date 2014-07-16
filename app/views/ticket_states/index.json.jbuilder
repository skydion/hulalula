json.array!(@ticket_states) do |ticket_state|
  json.extract! ticket_state, :id, :name
  json.url ticket_state_url(ticket_state, format: :json)
end
