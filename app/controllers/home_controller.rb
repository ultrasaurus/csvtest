require 'csv'

class HomeController < ApplicationController
  def index
  end

  def upload
    datafile = params[:datafile]
    data = datafile.read
    puts data
    arr = CSV.parse(data)
    numlines = arr.length - 1
    fields = arr[0].join(',')
    render :text => "File has been uploaded successfully. Data file has #{numlines} rows with fields: #{fields}"
  end
end
