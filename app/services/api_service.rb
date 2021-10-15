class ApiService
  def self.receive_data(endpoint)
    data = Faraday.get(endpoint)
    data = data.body
    JSON.parse(data, symbolize_names: true)
  end
end
