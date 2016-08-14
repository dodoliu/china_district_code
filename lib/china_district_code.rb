#encoding: utf-8
require 'logger'

require "china_district_code/version"
require 'china_district_code/china_district_code/loader'

LOGGER = Logger.new(File.join(File.dirname(__FILE__),'/china_district_code/log/debug.log'))

module ChinaDistrictCode

  load_file 'models'
  load_file 'helpers'

  include CsvHelper
  include DistrictHelper

  #reload china district code from 'http://www.stats.gov.cn/tjsj/tjbz/xzqhdm/201401/t20140116_501070.html'
  def self.load_china_district_code
    DistrictHelper::get_china_district_code
  end

  #find citys by province  
  def self.find_citys_by_province(name)
    result = DistrictHelper::find_citys_by_province(name)
    puts result.to_s
    result
  end

  #find areas by city
  def self.find_areas_by_city(name)
    result = DistrictHelper::find_areas_by_city(name)
    puts result.to_s
    result
  end

  #find province by city
  def self.find_province_by_city(name)
    result = DistrictHelper::find_province_by_city(name)
    puts result.to_s
    result
  end

  #find province,city by area
  def self.find_province_city_by_area(name)
    result = DistrictHelper::find_province_city_by_area(name)
    puts result.to_s
    result
  end
end

