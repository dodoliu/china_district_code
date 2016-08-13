require "http"

module DistrictHelper
  attr_accessor :provinces,:citys,:areas

  #get data from 'http://www.stats.gov.cn/tjsj/tjbz/xzqhdm/201401/t20140116_501070.html'
  def self.get_china_district_code
    code_html = HTTP.get('http://www.stats.gov.cn/tjsj/tjbz/xzqhdm/201401/t20140116_501070.html').to_s.force_encoding('UTF-8')
    provinces = scan_province code_html
    citys = scan_city code_html
    areas = scan_area code_html
    # LOGGER.debug citys

    #first of all,write provinces to csv
    CsvHelper::data_to_csv 'province',provinces
    CsvHelper::data_to_csv 'city',citys
    CsvHelper::data_to_csv 'area',areas
  end

  #find the province and formatting
  def self.scan_province(html)
    provinces = html.scan /\d{6}&nbsp;&nbsp;&nbsp; [\u4e00-\u9fa5]+/
    result = []
    provinces.each do |e|
      tmp = e.split(/&nbsp;&nbsp;&nbsp; /)
      code = tmp[0]
      name = tmp[1]
      pro_prefix = code[0,2]
      result.push [pro_prefix,code,name]
    end
    result
  end

  #find the city and formatting
  def self.scan_city(html)
    citys = html.scan /\d{6}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [\u4e00-\u9fa5]+/
    result = []
    citys.each do |e|
      tmp = e.split(/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /)
      name = tmp[1]
      next if name.eql?('市辖区') or name.eql?('县')
      code = tmp[0]
      pro_prefix = code[0,2]
      city_prefix = code[2,2]
      result.push [pro_prefix,city_prefix,code,name]
    end
    result
  end

  #find the area and formatting
  def self.scan_area(html)
    areas = html.scan /\d{6}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [\u4e00-\u9fa5]+/
    result = []
    areas.each do |e|
      tmp = e.split(/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /)
      name = tmp[1]
      code = tmp[0]
      pro_prefix = code[0,2]
      city_prefix = code[2,2]
      area_prefix = code[4,2]
      result.push [pro_prefix,city_prefix,area_prefix,code,name]
    end
    result
  end

  def self.load_all_csv_data
    @provinces = CsvHelper::data_from_csv 'province'
    @citys = CsvHelper::data_from_csv 'city'
    @areas = CsvHelper::data_from_csv 'area'
  end
  #find the province all the city below
  def self.find_citys_by_province(name)
    load_all_csv_data
    province = []
    citys = []
    @provinces.each do |pro|
      if pro[2].eql? name
        province = pro
        break
      end
    end
    # LOGGER.debug province
    # LOGGER.debug province[0]
    if province
      @citys.each do |ci|
        LOGGER.debug ci[0]
        if ci[0].eql?(province[0])
          LOGGER.debug ci
          citys.push ci[3]
        end
      end
    end
    citys
  end


end