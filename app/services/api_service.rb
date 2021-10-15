class ApiService
  def self.receive_data(endpoint)
    data = Faraday.get(endpoint)
    JSON.parse(data.body, symbolize_names: true)
  end
end
