//
//  ListGitRepoRowView.swift
//  PresentationSwiftUI
//
//  Created by Victor C Tavernari on 10/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import SwiftUI
import Domain
import Alamofire
import AlamofireImage
import Combine

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<UIImage, Never>()
    var image = UIImage() {
        didSet {
            didChange.send(image)
        }
    }

    init(urlString:String) {
        AF.request(urlString).responseImage { (response) in
            switch response.result {
            case .success(let image):
                self.image = image
            case .failure:
                break
            }
        }
    }
}


struct ListGitRepoRowView: View {
    private let rowModel: ListGitRepoRowModel
    @State var image: UIImage! = R.image.no_image()
    @ObservedObject var imageLoader: ImageLoader

    init(rowModel: ListGitRepoRowModel){
        self.rowModel = rowModel
        imageLoader = ImageLoader(urlString: rowModel.image)
    }

    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image(uiImage: self.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 54, height: 54)
                VStack(alignment: .leading, spacing: 5){
                    Text(self.rowModel.title).font(.title)
                    Text(self.rowModel.author).font(.subheadline)
                }.alignmentGuide(.leading) { (dimension) -> CGFloat in
                    return 16
                }
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 3, y: 3)
        }
        .padding(.all)
        .onReceive(imageLoader.didChange) { (output) in
            self.image = output.af.imageRoundedIntoCircle()
        }
        .background(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/.opacity(0.2))
    }
}

struct ListGitRepoRowView_Previews: PreviewProvider {

    static var previews: some View {
        var gitRepository = GitRepository()
        gitRepository.author = "Victor C Tavernari"
        gitRepository.description = "Descricao de um repositorio legal"
        gitRepository.forkCount = 100
        gitRepository.image = "https://picsum.photos/id/237/200/300"
        gitRepository.issuesCount = 400
        gitRepository.name = "Repo legal com titulo grande"
        gitRepository.starCount = 1000
        let rowModel = ListGitRepoRowModel(item: gitRepository)
        return ListGitRepoRowView(rowModel: rowModel)
    }
}
