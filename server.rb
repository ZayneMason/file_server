require "erubis"
require "sinatra"
require "sinatra/reloader" if development?

get '/' do
  @files = Dir.glob("public/*").map {|file| File.basename(file)}.sort do |a, b|
    if ('0'..'9').cover?(a.split) && ('0'..'9').cover?(b.split)
      a.scan("/\^[0-9]/").to_i <=> b.scan("/\^[0-9]/").to_i
    else
      a <=> b
    end
  end

  @files.reverse! if params[:sort] == "desc"
  erb :files
end