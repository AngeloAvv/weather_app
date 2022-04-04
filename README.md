# Weather
A weather app that shows the weather forecast for the next five days using the openweathermap APIs, made with love in Flutter.

![The welcome page](https://ibb.co/TwR0wkz)
![Today forecast](https://ibb.co/VWWJc91)
![Future days forecast](https://ibb.co/M8Y2LXM)

## How to use it
Retrieve the dependencies with the following command:
```terminal
pub get
```

Then run the build_runner to automatically generate support files:
```terminal
flutter pub run build_runner build --delete-conflicting-outputs 
```

Run the application and.. enjoy it!

## Architecture
* Clean Code Architecture (customized)
* BLoC pattern
* Dependency Injection with Provider
* Simplified with Freezed
* Supports both Portrait and Landscape orientations
* Unit and UI Tests

## License

Weather is available under the MIT license. See the LICENSE
file for more info.
