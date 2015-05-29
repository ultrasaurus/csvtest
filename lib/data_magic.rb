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
        row = row.to_hash
        puts row.class
        puts row.inspect
        eclient.index index:'myindex', type:'mydata', body: row

        num_rows += 1
      end

      puts "indexing complete"
      puts eclient.search index: 'myindex', body: { query: { match: { content: 'love' } } }
      return [num_rows, fields ]
    end

  end

end
