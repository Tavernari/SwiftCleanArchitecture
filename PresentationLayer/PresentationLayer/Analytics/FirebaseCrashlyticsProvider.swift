//
//  FirebaseCrashlyticsProvider.swift
//  PresentationLayer
//
//  Created by Lucas Silveira on 11/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Analytics
import Crashlytics
import Firebase

class FirebaseCrashlyticsProvider: AnalyticsProviderType {
    var name: String = "FirebaseCrashlytics"
    var enable: Bool = true
}

extension FirebaseCrashlyticsProvider: AnalyticsUserPropertiesDispatcher {
    func user(properties: [String: Any]) {
        properties.forEach { key, value in
            Firebase.Crashlytics.sharedInstance().setObjectValue(value, forKey: key)
        }
    }
}

extension FirebaseCrashlyticsProvider: AnalyticsUserIdentificationDispatcher {
    func user(id: String?, name: String?, email: String?) {
        Firebase.Crashlytics.sharedInstance().setUserIdentifier(id)
        Firebase.Crashlytics.sharedInstance().setUserName(name)
        Firebase.Crashlytics.sharedInstance().setUserEmail(email)
    }
}
