class CsvProcessor
  require 'csv'

  attr_accessor :attributes, :model_name

  def initialize(attributes, model_name)
    self.attributes = attributes
    self.model_name = model_name
  end

  def generate
    CSV.generate(headers: true) do |csv|
      csv << attributes
      model_name.constantize.find_each do |model_object|
        csv << attributes.map { |attr| model_object.send(attr) }
      end
    end
  end
end
