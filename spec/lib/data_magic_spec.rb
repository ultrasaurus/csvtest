require 'spec_helper'
require 'data_magic'

describe DataMagic do
  scenario "#import_csv" do
    data_str = <<-eos
num,content
1,this is something awesome
2,You love this thing
2,I love you love me
eos
    data = StringIO.new(data_str)
    num_rows, fields = DataMagic.import_csv(data)
    expect(num_rows).to be(3)
    expect(fields).to eq( [:num,:content] )
  end
end
