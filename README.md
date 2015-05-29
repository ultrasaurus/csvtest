

## Get Started

```
brew install elasticsearch
elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml
rails s
```
## Run the app

1. Go to http://localhost:3000
2. upload /spec/fixture/three-sentences.csv or another csv with headers




### Notes

See what's in the index
```
http://127.0.0.1:9200/myindex/mydata/_search
```

Delete an elasticsearch index
```
curl -XDELETE 'http://localhost:9200/myindex'
```
