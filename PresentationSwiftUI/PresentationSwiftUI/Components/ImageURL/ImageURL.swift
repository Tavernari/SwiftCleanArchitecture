//
//  ImageURL.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 22/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import SwiftUI

struct ImageURL: View {
    @ObservedObject var imageLoaderVM: ImageLoaderViewModel

    init(url: String) {
        imageLoaderVM = .init(urlString: url)
    }

    var body: some View {
        Image(uiImage: $imageLoaderVM.image.wrappedValue!)
            .resizable()
    }
}

struct ImageURL_Previews: PreviewProvider {
    static var previews: some View {
        ImageURL(url: "")
    }
}
