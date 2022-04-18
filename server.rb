require "erubis"
require "sinatra"
require "sinatra/reloader" if development?

get '/' do
  @files = Dir.glob("public/*").map {|file| File.basename(file)}.sort_by{ |name| [name[/\d+/].to_i ? name[/\d+/].to_i : name, name] }

  @files.reverse! if params[:sort] == "desc"
  erb :files
end