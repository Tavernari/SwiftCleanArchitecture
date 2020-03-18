//
//  ContentView.swift
//  PresentationSwiftUI
//
//  Created by Victor C Tavernari on 09/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import SwiftUI
import Domain
import DataSource
import Combine

struct RootView: View {

    var body: some View {
        NavigationView {
            ListGitRepoView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
