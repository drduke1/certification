# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#!!!!!!!!!!!!! 4/17/2014 basic layout made, 'rake db:seed' NOT RUN.
product_list = [
  [ "GXP2200", "ip_voice" ],
  [ "GXP2160", "ip_voice" ], 
  [ "GXP2140", "ip_voice" ], 
  [ "GXP2130", "ip_voice" ],
  [ "GXP2124", "ip_voice" ],
  [ "GXP2120", "ip_voice" ],
  [ "GXP2110", "ip_voice" ],
  [ "GXP2100", "ip_voice" ],
  [ "GXP1450", "ip_voice" ],
  [ "GXP1405", "ip_voice" ],
  [ "GXP1400", "ip_voice" ],
  [ "GXP1165", "ip_voice" ],
  [ "GXP1160", "ip_voice" ],
  [ "GXP1105", "ip_voice" ],
  [ "GXP1100", "ip_voice" ],
  [ "UCM6100", "ip_pbx" ],
  [ "DP715", "ip_voice" ],
  [ "GXV3140", "ip_video_telephony" ],
  [ "GXV3175", "ip_video_telephony" ],
  [ "GXV3175v2", "ip_video_telephony" ],
  [ "HT502", "consumer_atas" ],
  [ "HT503", "consumer_atas" ],
  [ "HT701", "consumer_atas" ],
  [ "HT702", "consumer_atas" ],
  [ "HT704", "consumer_atas" ],
  [ "GXW4004", "enterprise_gateways" ],
  [ "GXW4008", "enterprise_gateways" ],
  [ "GXW410x", "enterprise_gateways" ],
  [ "GXW4216", "enterprise_gateways" ],
  [ "GXW4224", "enterprise_gateways" ],
  [ "GXW4232", "enterprise_gateways" ],
  [ "GXW4248", "enterprise_gateways" ],
  [ "GXV3504", "ip_video_surveillance" ],
  [ "GXV3601", "ip_video_surveillance" ],
  [ "GXV3601_HD", "ip_video_surveillance" ],
  [ "GXV3610_HD", "ip_video_surveillance" ],
  [ "GXV3610_FHD", "ip_video_surveillance" ],
  [ "GXV3611_HD", "ip_video_surveillance" ],
  [ "GXV3615", "ip_video_surveillance" ],
  [ "GXV3662_HD", "ip_video_surveillance" ],
  [ "GXV3662_FHD", "ip_video_surveillance" ],
  [ "GXV3651_FHD", "ip_video_surveillance" ],
  [ "GXV3500", "ip_video_surveillance" ],
  [ "GXV3615_WP_HD", "ip_video_surveillance" ],
  [ "GXV3672_HD", "ip_video_surveillance" ],
  [ "GXV3672_FHD", "ip_video_surveillance" ],
  [ "GXV3672_HD/FHD_36", "ip_video_surveillance" ],
  [ "GXV3674_HD/FHD_VF", "ip_video_surveillance" ],
  [ "GXW4248", "ip_video_surveillance" ],
  [ "GXW4248", "ip_video_surveillance" ],
  [ "GXW4248", "ip_video_surveillance" ]
  ]
  product_list.each do |name, category|
    Product.create( name: name, category: category )
end