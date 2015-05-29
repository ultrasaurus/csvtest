class DataMagic
  class << self
    require 'csv'

    def import_csv(datafile)
      data = datafile.read
      puts data
      arr = CSV.parse(data)
      numlines = arr.length - 1
      fields = arr[0]    # assume we have a header
      fields.map(&:strip!)
      return [numlines, fields ]
    end

  end

end
