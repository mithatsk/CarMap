# CarMap

Main objective is to illustrate custom annotation views on a map and a list.

## Architecture:
Separation of business logic and UI is quite handy and important for maintainability so I decided to use MVVM

## Frameworks:

I tried to keep external dependencies at minimum so I used the following frameworks:

1. Alamofire for Networking
2. Swinject for dependency injection
3. Kingfisher for downloading and caching images

### UI Components
It is always good to have reusable components especially for UI related elements to reduce code redundancy so I created following components:

1. LoadingIndicatorView for displaying custom loading indicator during network calls
2. DialogAlertView for displaying user friendly alerts


### Style Guide
[Raywenderlich style guide](https://github.com/raywenderlich/swift-style-guide) is a good one for having a code standard so I followed this guideline.  

#### Helpful Resources

[MapKit](https://developer.apple.com/documentation/mapkit)
[MapKit Annotations](https://developer.apple.com/documentation/mapkit/mapkit_annotations/annotating_a_map_with_custom_data)
