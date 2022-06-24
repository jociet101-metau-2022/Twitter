# Project 2 - *twitter*

**Twitter** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **32** hours spent in total

## User Stories

The following **core** features are completed:

**A user should**

- [x] See an app icon in the home screen and a styled launch screen
- [x] Be able to log in using their Twitter account
- [x] See at least the latest 20 tweets for a Twitter account in a Table View
- [x] Be able to refresh data by pulling down on the Table View
- [x] Be able to like and retweet from their Timeline view
- [x] Only be able to access content if logged in
- [x] Each tweet should display user profile picture, username, screen name, tweet text, timestamp, as well as buttons and labels for favorite, reply, and retweet counts.
- [x] Compose and post a tweet from a Compose Tweet view, launched from a Compose button on the Nav bar.
- [x] See Tweet details in a Details view
- [x] App should render consistently all views and subviews in recent iPhone models and all orientations

The following **stretch** features are implemented:

**A user could**

- [x] Be able to **unlike** or **un-retweet** by tapping a liked or retweeted Tweet button, respectively. (Doing so will decrement the count for each)
- [x] Click on links that appear in Tweets
- [ ] See embedded media in Tweets that contain images or videos
- [x] Reply to any Tweet (**2 points**)
  - Replies should be prefixed with the username
  - The `reply_id` should be set when posting the tweet
- [x] See a character count when composing a Tweet (as well as a warning) (280 characters) (**1 point**)
- [x] Load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client
- [x] Click on a Profile image to reveal another user's profile page, including:
  - Header view: picture and tagline
  - Basic stats: #tweets, #following, #followers
- [x] Switch between **timeline**, **mentions**, or **profile view** through a tab bar (**3 points**)
- [ ] Profile Page: pulling down the profile page should blur and resize the header image. (**4 points**)

The following **additional** features are implemented:

- [x] Profile Page Timeline: Displays that user's tweet timeline

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. How to efficiently reuse code, for example, between the tweet cell on the home timeline and the tweet cell on a specific user's timeline.

## Video Walkthrough

Here's a walkthrough of implemented user stories:


Gif 1:
- User can login and loading page has twitter icon
- Home timeline has pull to refresh
- Infinite scrolling of tweets in timelines
- Details view shown when press on tweet
- Tweets can be favorited and retweeted

https://user-images.githubusercontent.com/73032138/175749398-44923e30-fd81-4872-b2ce-116df25c2fe6.mov


Gif 2:
- User can compose tweet from home timeline page
- User can reply to tweet from details view

https://user-images.githubusercontent.com/73032138/175749404-3656d69d-e2b6-41e3-b545-712fff588732.mov


Gif 3:
- Number of characters in tweet is limited to 280 and user is not allowed to tweet if above the limit
- Mention timeline and profile page, Profile page also has timeline

https://user-images.githubusercontent.com/73032138/175749408-8a69367c-27ab-4d42-8ee8-2a148837a890.mov


Gif 4:
- Able to undo favoriting and retweeting
- Links can be accessed in tweet

https://user-images.githubusercontent.com/73032138/175749410-8a5d9d27-9eb0-4451-9a9e-2b9bc8902a71.mov


Gif 5:
- Auto layout working based on change in orientation of device

https://user-images.githubusercontent.com/73032138/175749414-6887ea00-0220-4b88-9db8-5d599cfdce89.mov


Gif 6:
- User's profile page can be accessed by clicking on profile image on timeline view

https://user-images.githubusercontent.com/73032138/175749647-5d5bfe81-1606-4bd0-82d2-f04c672de85b.mov


## Notes

Describe any challenges encountered while building the app: Auto layout was very challenging because the constraints would often conflict and I would have to examine carefully which constraints should be kept or deleted. However, it was nice to see that a lot of effort put into auto layout allows the app to be viewed on different orientations and devices.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [DateTools](https://github.com/MatthewYork/DateTools) - date formatting library

## License

    Copyright [2022] [Jocelyn Tseng]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
