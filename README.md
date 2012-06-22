# Flying Chicken

*Coder sounds now in the browser.*

## Built with

 * Coffeescript
 * Node
 * Zappa
     * Express
     * Socket.io
     * CoffeeKup
 
## Register app with Github
1. Visit https://github.com/account/applications/new
2. ?

** Make sure you have the "repo" permission in your oAuth scope

## Install and Run

1. Install Node
2. Install NPM
3. `npm install`
4. `coffee app.coffee`


## Local Testing

To locally simulate a GitHub post-receive hook, enter this in your terminal while running locally:

	curl -d \
	"payload={\"pusher\":{\"name\":\"samfoy\",\"email\":\"sam.foy.painter@gmail.com\"},\"repository\":{\"name\":\"opencounter\",\"size\":1068,\"has_wiki\":true,\"created_at\":\"2012-06-12T15:19:16-07:00\",\"private\":false,\"watchers\":2,\"url\":\"https://github.com/codeforamerica/opencounter\",\"fork\":false,\"language\":\"JavaScript\",\"pushed_at\":\"2012-06-22T12:10:15-07:00\",\"has_downloads\":true,\"open_issues\":0,\"has_issues\":true,\"forks\":1,\"description\":\"Set up shop in your city.\",\"organization\":\"codeforamerica\",\"owner\":{\"name\":\"codeforamerica\",\"email\":\"labs@codeforamerica.org\"}},\"forced\":false,\"after\":\"4bc3d794a7ca65f5a6dca06afd1c59798a8a296c\",\"head_commit\":{\"added\":[],\"modified\":[\"lib/models/naics.rb\",\"opencounter.rb\",\"spec/codes_spec.rb\"],\"author\":{\"name\":\"Samuel Painter\",\"username\":\"samfoy\",\"email\":\"sam.foy.painter@gmail.com\"},\"removed\":[],\"timestamp\":\"2012-06-22T12:09:45-07:00\",\"url\":\"https://github.com/codeforamerica/opencounter/commit/4bc3d794a7ca65f5a6dca06afd1c59798a8a296c\",\"id\":\"4bc3d794a7ca65f5a6dca06afd1c59798a8a296c\",\"distinct\":true,\"message\":\"Search terms matching the 1st word only as well now promoted to top\",\"committer\":{\"name\":\"Samuel Painter\",\"username\":\"samfoy\",\"email\":\"sam.foy.painter@gmail.com\"}},\"deleted\":false,\"commits\":[{\"added\":[],\"modified\":[\"lib/models/naics.rb\",\"opencounter.rb\",\"spec/codes_spec.rb\"],\"author\":{\"name\":\"Samuel Painter\",\"username\":\"samfoy\",\"email\":\"sam.foy.painter@gmail.com\"},\"removed\":[],\"timestamp\":\"2012-06-22T12:09:45-07:00\",\"url\":\"https://github.com/codeforamerica/opencounter/commit/4bc3d794a7ca65f5a6dca06afd1c59798a8a296c\",\"id\":\"4bc3d794a7ca65f5a6dca06afd1c59798a8a296c\",\"distinct\":true,\"message\":\"Search terms matching the 1st word only as well now promoted to top\",\"committer\":{\"name\":\"Samuel Painter\",\"username\":\"samfoy\",\"email\":\"sam.foy.painter@gmail.com\"}}],\"ref\":\"refs/heads/master\",\"compare\":\"https://github.com/codeforamerica/opencounter/compare/cf0265ef9eec...4bc3d794a7ca\",\"before\":\"cf0265ef9eec9c0eab7f311bf0d14db165e092df\",\"created\":false}" \
	localhost:3000/posthook