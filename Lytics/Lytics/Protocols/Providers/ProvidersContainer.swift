//
//  AnalyticsEventProviders.swift
//  Analytics
//
//  Created by Victor C Tavernari on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public protocol ProvidersContainer {
    static var providers: [ProviderType] { get }
    static func register(provider: ProviderType) throws
    static func unregister(provider: ProviderType) 
    static func unregisterAllProviders()
}
