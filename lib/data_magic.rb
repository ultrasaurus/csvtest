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
      index_name = 'myindex'
      type_name = 'mydata'

      eclient.indices.delete index: '_all'
      eclient.indices.create index: index_name,
        body: {
          mappings: {
            mydata: {
              properties: {
                content: {
                  type: 'string',
                  term_vector: 'with_positions_offsets_payloads',
                  store: "yes",
                  term_statistics: true,
                  analyzer: "whitespace"
                }
              }
            }
          }
        }
      puts "-"*80
      puts eclient.indices.get_mapping
      puts "-"*80
      data = datafile.read
      puts data
      fields = nil
      num_rows = 0
      CSV.parse(data, headers:true, :header_converters=> lambda {|f| f.strip.to_sym }) do |row|
        fields ||= row.headers
        row = row.to_hash
        puts row.class
        puts row.inspect
        eclient.index index: index_name, type:type_name, body: row, refresh: true

        num_rows += 1
      end

      puts "indexing complete"
      result = eclient.search index: index_name, body: { query: { match: { content: 'love' } } }
      puts result
      puts "-"*80
      puts result["hits"]
      puts "-hits-"
      puts result["hits"].class
      result["hits"]["hits"].each do |hit|
        puts id = hit["_id"]
        eclient.termvector index: index_name, type: type_name, id: id

      end

      return [num_rows, fields ]
    end

  end

end
