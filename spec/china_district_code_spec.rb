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
      expect(ChinaDistrictCode::find_citys_by_province('河北省')).to include('石家庄市')
    end
    it "find areas by citys"
    it "find province by city"
    it "find city,province by area"
    it "find area by district code"
  end

  context "post code" do
    it "find post code  by district code"
  end
end