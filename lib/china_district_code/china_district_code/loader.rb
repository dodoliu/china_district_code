def load_file(folder)
  dir = File.dirname(__FILE__)
  root_dir = File.expand_path("..",dir)
  Dir[File.expand_path("#{root_dir}/#{folder}/*.rb")].uniq.each do |file|
    require file
  end
end