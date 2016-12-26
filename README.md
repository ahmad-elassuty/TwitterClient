#TwitterClient-Eventtus Swift

##Features
**TwitterClient** implements the following features:

**General:**

- Using the application in the offline mode
- Handling empty states
- Show UIBlocker Loaders

**LogIn:**

- LogIn with Twitter
- Automatic logIn
- Account switching with the following flow:

```
- If user granted access to system accounts:
  - If there is only one account
    - Authenticate user through webView
  - else
    - Authenticate user through system accounts
- else
  - Ask the user to grant access to system accounts
```
 
**Followers view:**

- Show Followers List
- Force refresh and infinite scrolling
- Handling device orientation


**Follower Profile:**

- Show follower profile (name, profile image, background image)
- Show recent 10 Tweets
- Stretchy/Sticky Header

##Screenshots
![TwitterClient-Eventtus Screenshot](https://s27.postimg.org/xlggbvn2r/Launch_Screen.png)
![TwitterClient-Eventtus Screenshot](https://s27.postimg.org/6owh3k49f/Login.png)
![TwitterClient-Eventtus Screenshot](https://s27.postimg.org/5nw8efn9v/Multi_Account.png)
![TwitterClient-Eventtus Screenshot](https://s27.postimg.org/hjdx5hndf/Error_Handling.png)
![TwitterClient-Eventtus Screenshot](https://s27.postimg.org/8pn0oe0er/Followers_View_Controller.png)
![TwitterClient-Eventtus Screenshot](https://s27.postimg.org/jk92428wj/Switch_Accounts.png)
![TwitterClient-Eventtus Screenshot](https://s27.postimg.org/h5cl5w39v/Empty_Followers.png)
![TwitterClient-Eventtus Screenshot](https://s27.postimg.org/heer9k5g3/Profile_View.png)
![TwitterClient-Eventtus Screenshot](https://s27.postimg.org/s8rlxqz6b/Landscape.png)

##Requirements

- IPhone IOS 10+
- Xcode 8+

##Dependency Manager (CocoaPods)
TwitterClient uses CocoaPods as a dependency manager. All pods are included in the repo so you do not need to reinstall the pods.

Pod           | Usage
:---------------: | -------------
[**Fabric**](https://cocoapods.org/pods/Fabric)  | Twitter SDKs manager
[**TwitterKit**](https://cocoapods.org/pods/TwitterKit)  | Handling Twitter authentication and data fetching.
[**ObjectMapper**](https://github.com/Hearst-DD/ObjectMapper)  | Mapping JSON data to the application models.
[**RealmSwift**](https://github.com/realm/realm-cocoa)  | Persisting Twitter API responses for offline support.
[**Kingfisher**](https://github.com/onevcat/Kingfisher)   | Loading and caching images.
[**TTTAttributedLabel**](https://github.com/TTTAttributedLabel/TTTAttributedLabel)  | Calculating text height for the view.
[**NVActivityIndicatorView**](https://github.com/ninjaprox/NVActivityIndicatorView)  | Nice animatable loaders.


##Architecture

###Models:

There are two main models which inherit from Realm `Object` class to persist data to the desk.

Name            | Usage
:---------------:   | -------------
Account       | Represents the logged-In user info. Constructed form `TWTRUser`
User          | Represents any Twitter user. Currently used to represent a Follower Object. Mapped from Twitter JSON response using `ObjectMapper`.

###Controllers:
All view controllers inherits from `BaseViewController` to reuse common functionalities and keep the code **DRY**.

- **LoginViewController** implements `Authenticator` protocol to handle Twitter log-in. 


- **FollowersViewController**  implements `Authenticator` protocol, to handle account switching. It also implements `FollowersDataSourceDelegate` to react to its dataSource updates.
  
  - *Properties*
    - `followersCollectionView: UICollectionView` presents followers list and handle orientation.
    - `dataSource: FollowersDataSource` is responsible for preparing and fetching user followers data.

- **FollowerProfileViewController** implements `TimelineDataSourceDelegate` to react to its dataSource updates.
  - *Properties*
    - `timelineTableView: UITableView` presents user tweets.
    - `timelineDataSource: TimelineDataSource` is responsible for preparing and fetching user tweets.

---

####Notes
- **Authenticator** does not handle Twitter response, instead it asks the conforming object to handle it. Hence, the conforming view controller can customize its view and handle the flow.

- **User tweets** are stored in Realm as `NSData` to take advantage of using `TwitterKit` built-in table view cell that can be configured with `TWTRTweet` object. `TWTRTweet` object can serlialize Twitter JSON response and returns an array of `TWTRTweet`.

---

##ToDo

- Offline Account Switching
- Localization
- Image Overlay
- Custom Layout for `followersCollectionView`
- Detect the links in the User bio property.
- Tests