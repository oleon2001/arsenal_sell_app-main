import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Google Maps
    if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
       let plist = NSDictionary(contentsOfFile: path),
       let apiKey = plist["GOOGLE_MAPS_API_KEY"] as? String {
      GMSServices.provideAPIKey(apiKey)
    } else {
      GMSServices.provideAPIKey("AIzaSyA5X9eJe3Ih4Yfo4txSQzScZmVZpoO8mf8")
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}