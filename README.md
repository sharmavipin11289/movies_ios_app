# Movies iOS App (SwiftUI)

Native SwiftUI host app that embeds the Flutter movies module.
Tap **Show List of Movies** to open the Flutter list; tap a movie and the
app returns to native and plays the trailer on a native screen.

## Repositories (clone side by side)

```
some_folder/
├── movies_flutter_module/   <- Flutter module repo
└── movies_ios_app/          <- this repo
```

The Podfile points to `../movies_flutter_module`, so both repos must live in the same parent folder.

## Setup

Prerequisites: Xcode, Flutter SDK, CocoaPods.

```bash
git clone https://github.com/sharmavipin11289/movies_flutter_module.git  movies_flutter_module
git clone https://github.com/sharmavipin11289/movies_ios_app.git movies_ios_app

cd movies_flutter_module
# add your TMDB key, see the module README
flutter pub get

cd ../movies_ios_app
pod install
open MoviesiOSApp.xcworkspace
```

Select a simulator and press Run.

Notes:
- **User Script Sandboxing = No** is required for the app target (already set in the project).
- If `pod install` fails with "Xcode project version (110)", run
  `sed -i '' 's/objectVersion = 110;/objectVersion = 77;/' MoviesiOSApp.xcodeproj/project.pbxproj`
  and try again (older CocoaPods with a newer Xcode).

## Architecture

- `FlutterCoordinator`: owns the pre-warmed Flutter engine, presents Flutter, listens on the channel, dismisses Flutter and then shows the trailer.
- `TrailerRequest`: parses the channel arguments and builds the YouTube embed HTML (unit tested).
- `TrailerView` + `YouTubePlayerView`: native trailer screen using `WKWebView`.

## Channel contract

| | |
|---|---|
| Channel | `com.vipin.movies/bridge` |
| Method | `openTrailer` |
| Args | `movieId: Int`, `title: String`, `youtubeKey: String?` |

## Design decision

The Flutter module calls TMDB `/movie/{id}/videos` and sends the YouTube key
to native, so the native apps never need the TMDB API key.

## Known limitation

Some studios disable embedding for their trailers (YouTube error 152). The
trailer screen offers an **Open on YouTube** fallback.

## Tests

`Cmd+U` in Xcode, or:

```bash
xcodebuild test -workspace MoviesiOSApp.xcworkspace -scheme MoviesiOSApp \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro'
```


