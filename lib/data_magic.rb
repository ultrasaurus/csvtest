class DataMagic
  class << self
    require 'csv'
    require 'elasticsearch'
    @@eclient = Elasticsearch::Client.new log: true

    def eclient
      puts "--------- eclient: #{@@eclient}"
      @@eclient
    end

    def import_csv(datafile)

      data = datafile.read
      puts data
      fields = nil
      num_rows = 0
      CSV.parse(data, headers:true, :header_converters=> lambda {|f| f.strip.to_sym }) do |row|
        fields ||= row.headers
        params = row
        params[:index] = 'myindex'
        params[:type] = 'mydata'

        puts params.inspect
        eclient.index params

        num_rows += 1
      end

      puts "indexing complete"
      puts client.search index: 'myindex',  query: { match: { content: 'love' } }
      return [num_rows, fields ]
    end

  end

end
