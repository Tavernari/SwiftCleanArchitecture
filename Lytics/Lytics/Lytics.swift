//
//  Lytics.swift
//  Analytics
//
//  Created by Victor C Tavernari on 07/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

public enum LyticsError: Error {
    case cannotAddProviderTwice
}

public class Lytics: ProvidersContainerType {
    private static var providersList: [ProviderType] = []

    public static var providers: [ProviderType] { providersList }

    public static func register(provider: ProviderType) throws {
        guard providersList.isEmpty || providersList.contains(where: { $0.name != provider.name}) else {
            throw LyticsError.cannotAddProviderTwice
        }

        providersList.append(provider)
    }

    public static func unregister(provider: ProviderType) {
        providersList.removeAll { $0.name == provider.name }
    }

    public static func unregisterAllProviders() {
        providersList.removeAll()
    }

}
