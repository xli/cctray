# CCTray

Simply fetch and parse cctray feed xml as ruby objects.


## Example

```ruby
tray = CCTray.new("http://server/cctray.xml", 'user', 'pass')
projects = tray.fetch

projects.each do |proj|
  proj.name                # String
  proj.activity            # String
  proj.last_build_status   # String
  proj.last_build_label    # String
  proj.last_build_time     # DateTime
  proj.last_build_time_str # The original String value of lastBuildTime parsed out from feed
  proj.web_url             # String
  proj.messages.each do |mes|
    mes.kind               # String
    mes.text               # String
  end
end
```
