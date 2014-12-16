class Visual < ActiveRecord::Base
  validates_uniqueness_of :standard_url
  belongs_to :trip
  before_create :destroy_extra_visuals


private

def destroy_extra_visuals
  if Visual.count >500
    Visual.select(:id).limit(100).destroy_all
  end

  response=`curl -X GET 'https://api.newrelic.com/v2/servers/6045686/metrics/data.json' \
       -H 'X-Api-Key:cc659be4c291962f0e985477be1458fa370865269cfc4ea' -i \
       -d 'names[]=Controller/sessions/sub_callback'`

  after_headers=response[response.index("{")..-1]
  max_time=JSON.parse(after_headers)["metric_data"]["metrics"][0]["timeslices"][-1]["values"]["max_response_time"]
  puts " @@@@@@@@@@@@@ MAX TIME: #{max_time} @@@@@@@@@@@@@@@"

  if max_time >1000
    Instagram.delete_subscription(object: "all")
  end

end

end

