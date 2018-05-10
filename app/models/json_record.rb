class JSONRecord < Struct.new(:data)
  def self.all
    @all ||= JSON.parse(File.read(Rails.root.join("db/data/#{to_s.downcase.pluralize}.json"))).collect do |key, data|
      new(data)
    end
  end

  def self.find(slug)
    all.find { |destination| destination.slug == slug } || (raise ActiveRecord::RecordNotFound)
  end
end
