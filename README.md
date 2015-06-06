lunchr-ios
======

Suggests random lunch destinations from a list, using the [Foursquare API](http://api.foursquare.com).

iOS version of the lunchr web app, available at https://github.com/irace/lunchr (demo: http://lunchr.irace.me/) and is written in Swift with a dependency of Alamofire.

The app is definitely built with some suspect code, but it works, and was built in about 30 minutes.  Pull requests welcome (e.g. auto layout added).

To run your own Lunchr:

* Create a [Foursquare list](https://foursquare.com/lists) and populate it with the places you'd like to choose from
* Fork this project and replace my list's ID with yours: `let listId : String = "55726bba498e410d55d35db2"`
* [Register a Foursquare API application](https://foursquare.com/developers/register) and set your client ID and secret as environment variables `clientId` and `clientSecret`

## License

Available for use under the MIT license: [http://bryan.mit-license.org](http://bryan.mit-license.org)

The [fork and knife ("utensils") icon](https://thenounproject.com/term/utensils/15480/) is designed by [Diego Naive](https://thenounproject.com/diegonaive/), from The Noun Project.
