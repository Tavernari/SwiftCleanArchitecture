//
//  ImageLoader.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 22/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    var downloadedImage: UIImage?
    let didChange = PassthroughSubject<ImageLoader?, Never>()

    func load(url: String) {
        guard let imageURL = URL(string: url) else {
            fatalError("ImageURL is not correct!")
        }

        URLSession.shared.dataTask(with: imageURL) { data, _, error in

            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.didChange.send(nil)
                }
                return
            }

            self.downloadedImage = UIImage(data: data)
            DispatchQueue.main.async {
                self.didChange.send(self)
            }

        }.resume()
    }
}
