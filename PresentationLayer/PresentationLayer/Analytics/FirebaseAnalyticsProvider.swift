//
//  FirebaseAnalyticsProvider.swift
//  PresentationLayer
//
//  Created by Victor C Tavernari on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Analytics
import Firebase

class FirebaseAnalyticsProvider: AnalyticsProviderType {
    var name: String = "FirebaseAnalytics"
    var enable: Bool = true
}

extension FirebaseAnalyticsProvider: AnalyticsEventDispatcher {
    func event(event: AnalyticsEventType) {
        let eventName = event.name
        let params = event.data
        Firebase.Analytics.logEvent(eventName, parameters: params)
    }
}

extension FirebaseAnalyticsProvider: AnalyticsScreenEventDispatcher {
    func screen(event: AnalyticsScreenEventType) {
        let screenName = event.name
        let className = String(describing: event.classValue)
        Firebase.Analytics.setScreenName(screenName, screenClass: className)
    }
}

extension FirebaseAnalyticsProvider: AnalyticsUserPropertiesDispatcher {
    func user(properties: [String: Any]) {
        properties.forEach { key, value in

            guard let value = value as? String else {
                print("[Warning ]Firebase need String value ")
                return
            }

            Firebase.Analytics.setUserProperty(value, forName: key)
        }
    }
}

extension FirebaseAnalyticsProvider: AnalyticsUserIdentificationDispatcher {
    func user(id: String?, name _: String?, email _: String?) {
        Firebase.Analytics.setUserID(id)
    }
}
