# CCTray

Simply fetch and parse out cctray feed xml as ruby objects.


## Example

```ruby
tray = CCTray.new("http://server/cctray.xml", 'user', 'pass')
projects = tray.fetch

projects.each do |proj|
  proj.name
  proj.activity
  proj.last_build_status
  proj.last_build_label
  proj.last_build_time
  proj.web_url
  proj.messages.each do |mes|
    mes.kind
    mes.text
  end
end
```
