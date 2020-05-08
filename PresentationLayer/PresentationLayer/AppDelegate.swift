//
//  AppDelegate.swift
//  Presentation
//
//  Created by Victor C Tavernari on 02/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import CoreData
import Crashlytics
import Firebase
import Sentry
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        FirebaseApp.initialize()
        Crashlytics.initialize()
        SentrySDK.start(options: [
            "dsn": "https://e9ffdf1077ae48ada023975dda78567a@o163739.ingest.sentry.io/5218118",
            "enableAutoSessionTracking": true,
            "sessionTrackingIntervalMillis": 60000,
            "debug": true,
        ])

        return true
    }
}
