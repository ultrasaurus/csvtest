
class HomeController < ApplicationController
  def index
  end

  def upload
    require 'data_magic'
    
    numlines, fields = DataMagic.import_csv(params[:datafile])
    render :text => "File has been uploaded successfully. Data file has #{numlines} rows with fields: #{fields.join(',')}"
  end
end
