require 'spec_helper'
require 'data_magic'

describe DataMagic do
  scenario "#import_csv" do
    data_str = <<-eos
a,b
1,2
3,4
eos
    data = StringIO.new(data_str)
    num_rows, fields = DataMagic.import_csv(data)
    expect(num_rows).to be(2)
    expect(fields).to eq( [:a,:b] )
  end
end
