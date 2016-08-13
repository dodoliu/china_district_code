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

  #通过省份查城市 
  def self.find_citys_by_province(name)
    result = DistrictHelper::find_citys_by_province(name)
    puts result
    result
  end


  #通过城市查区县

  #通过城市查省份

  #通过区县查城市-省份

  #通过区域代码查区域



end

# ChinaDistrictCode.reload_china_district_code

