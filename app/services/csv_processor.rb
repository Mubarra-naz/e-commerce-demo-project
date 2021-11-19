class CsvProcessor
  require 'csv'
  def initialize(arr, model_name)
    @attributes = arr
    @model_name = model_name
  end

  def generate
    CSV.generate(headers: true) do |csv|
      csv << @attributes
      @model_name.constantize.find_each do |model_object|
        csv << @attributes.map { |attr| model_object.send(attr) }
      end
    end
  end
end
