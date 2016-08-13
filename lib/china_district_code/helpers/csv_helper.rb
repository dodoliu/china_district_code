require "csv"

module CsvHelper
  @root_dir = File.expand_path("..",File.dirname(__FILE__))

  #array data to csv file,writing file to local csv folder
  def self.data_to_csv(name,data)
    CSV.open("#{@root_dir}/csv/#{name}.csv", "wb") do |csv|
      data.each do |d|
        csv << d
      end
    end
  end

  #read the data from local csv folder,
  def self.data_from_csv(name)
    CSV.read "#{@root_dir}/csv/#{name}.csv"
  end
end