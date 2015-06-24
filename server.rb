#!/usr/bin/env ruby

require 'sinatra'
require 'erb'
require 'json'

@@driver_positions = {
    example1: {lat: "37.804259", lng: "-122.413289", example: true },
    example2: {lat: "37.782928", lng: "-122.393076", example: true } 
}

def get_drivers
    @@driver_positions.map {|k, v| v.merge({id: k})}
end

get '/' do
  send_file 'views/index.html'
end

get '/api/driver_position/?' do
  content_type :json
  { drivers: get_drivers }.to_json
end

# @param android_id
# @param lat
# @param lng
post '/api/update_position/?' do
    @@driver_positions[params['android_id']] = {
        lat: params['lat'],
        lng: params['lng']
    }
    content_type :json
    { success: true }.to_json
end
