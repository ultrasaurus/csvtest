class HomeController < ApplicationController
  def index
  end

  def upload
    puts "*"*40
    puts params[:datafile].inspect
    datafile = params[:datafile]
    puts "-"*40
    puts datafile.read
    render :text => "File has been uploaded successfully"
  end
end
