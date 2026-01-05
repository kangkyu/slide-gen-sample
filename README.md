# slide-gen-sample

Fetch data from YouTube API data, and automatically generate Google
Slides file with it, for a use case of both API in Ruby (use `yt`
gem and `gslide` gem).

```sh
bin/rails server
```

- Environment variables

  Get these from Google Cloud [Console](https://console.cloud.google.com/apis/dashboard)
(client id, client secret, and api key).
```
export YT_CLIENT_ID='...'
export YT_CLIENT_SECRET='...'
export YT_API_KEY='...'
```
