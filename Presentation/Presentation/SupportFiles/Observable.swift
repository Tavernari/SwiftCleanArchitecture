//
//  Observable.swift
//  Presentation
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Foundation

class Observable<Data: Equatable> {
    typealias Listener = (Data) -> Void

    var listeners: [Listener]? = []

    var value: Data {
        didSet {
            if oldValue != value {
                for listener in listeners! {
                    listener(value)
                }
            }
        }
    }

    init(_ value: Data) {
        self.value = value
    }

    func observe(listener: @escaping Listener) {
        listeners?.append(listener)
        listener(value)
    }

    func removeAllObservers() {
        listeners?.removeAll()
    }
}
