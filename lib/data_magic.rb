class DataMagic
  class << self
    require 'csv'

    def import_csv(datafile)
      data = datafile.read
      puts data
      fields = nil
      num_rows = 0
      CSV.parse(data, headers:true, :header_converters=> lambda {|f| f.strip}) do |row|
        fields ||= row.headers
        num_rows += 1
      end

      return [num_rows, fields ]
    end

  end

end
