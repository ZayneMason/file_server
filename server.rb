require "erubis"
require "sinatra"
require "sinatra/reloader" if development?

get '/' do
  @files = Dir.glob("public/*").map {|file| File.basename(file)}.sort_by{ |name| [name[/\d+/].to_i ? name[/\d+/].to_i : name, name] }

  @files.reverse! if params[:sort] == "desc"
  erb :files
end

get '/upload' do
  erb :upload
end

post '/upload' do
  # Check if user uploaded a file
  if params[:image] && params[:image][:filename]
    filename = params[:image][:filename]
    file = params[:image][:tempfile]
    path = "./public/#{filename}"

    # Write file to disk
    File.open(path, 'wb') do |f|
      f.write(file.read)
    end
  end
  redirect '/'
end