require 'rubygems'
require 'sinatra'

get '/files' do
  Dir.entries('files').select { |f| f[0] != '.' }.map { |f| "<a href=\"#{URI.encode(url('files/' + f))}\">#{url('files/' + f)}</a>" }.join("<br/>")
end

get '/files/*.*' do
  puts 'Requested' + params[:splat].to_s
  puts params[:splat].join('.')
  send_file 'files/' + params[:splat].join('.')
end

get '/upload' do
  erb :upload
end

post '/upload' do
  unless params[:file] && (tmpfile = params[:file][:tempfile]) && (name = params[:file][:filename])
    return "no file"
  end
  directory = "files"
  path = File.join(directory, name)
  File.open(path, "wb") { |f| f.write(tmpfile.read) }
  "uploaded"
end

