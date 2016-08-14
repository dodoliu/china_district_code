require 'spec_helper'
require 'china_district_code'
require 'csv'

describe "China district code" do
  context "district" do
    it "get province,city,area info" do
      ChinaDistrictCode::load_china_district_code
      csv_folder_path = File.join(File.expand_path('../..',__FILE__),'lib','china_district_code','csv')
      provinces = CSV.read(File.join(csv_folder_path,'province.csv'))
      expect(provinces[0][0]).to eq('11')
    end
    it "find citys by province" do
      expect(ChinaDistrictCode::find_citys_by_province('河北省')).to include(["130100", "石家庄市"])
    end
    it "find areas by city" do
      expect(ChinaDistrictCode::find_areas_by_city('石家庄市')).to include(["130103", "桥东区"])
    end
    it "find province by city" do
      expect(ChinaDistrictCode::find_province_by_city('太原')).to eql(["140000", "山西省"])
    end
    it "find city,province by area" do
      expect(ChinaDistrictCode::find_province_city_by_area('桥东区')).to eql([["130000", "河北省"], ["130100", "石家庄市"]])
    end
    # it "find area by district code"
  end

  context "post code" do
    it "find post code  by district code"
  end
end