require 'json'

# te didnt' cause problem. request queing did. May still be an issue but never hit. 
# 2. website was still available, but stopped working.

# we need to prevent requests from queing sohigh. 

# server id: 6045686
# api key: cc659be4c291962f0e985477be1458fa370865269cfc4ea

response=`curl -X GET 'https://api.newrelic.com/v2/servers/6045686/metrics/data.json' \
     -H 'X-Api-Key:cc659be4c291962f0e985477be1458fa370865269cfc4ea' -i \
     -d 'names[]=Controller/sessions/sub_callback'`

after_headers=response[response.index("{")..-1]

JSON.parse(after_headers)["metric_data"]["metrics"][0]["timeslices"][-1]["values"]["max_response_time"]
     
# {"from"=>"2014-12-16T15:50:00+00:00", "to"=>"2014-12-16T15:51:00+00:00", "values"=>{"average_response_time"=>0, "calls_per_minute"=>0, "call_count"=>0, "min_response_time"=>0, "max_response_time"=>0, "average_exclusive_time"=>0, "average_value"=>0, "total_call_time_per_minute"=>0, "requests_per_minute"=>0, "standard_deviation"=>0, "throughput"=>0, "average_call_time"=>0, "min_call_time"=>0, "max_call_time"=>0, "total_call_time"=>0}}

