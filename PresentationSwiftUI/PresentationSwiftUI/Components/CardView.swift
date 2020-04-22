//
//  CardView.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 22/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var title: String
    var subtitle: String
    var description: String
    var image: UIImage
    var primary_icon: String
    var primary_counter: String
    var second_icon: String
    var second_counter: String
    var thirty_icon: String
    var thirty_counter: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
                .shadow(color: .gray, radius: 5, x: 2, y: 2)

            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .padding(.top, 20)

                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.title)
                            .foregroundColor(.black)

                        Text(subtitle)
                            .font(.body).fontWeight(.medium)
                            .foregroundColor(.gray)
                            .padding(.top, 15)
                    }
                    .padding(20)
                    .multilineTextAlignment(.leading)
                }
                .padding(.leading, 20)

                Text(description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(20)
                Spacer()
                HStack(spacing: 30) {
                    if !primary_counter.isEmpty {
                        HStack(spacing: 10) {
                            Image(systemName: primary_icon)
                            Text(primary_counter)
                                .font(.footnote)
                                .foregroundColor(.black)
                        }
                    }

                    if !second_counter.isEmpty {
                        HStack(spacing: 10) {
                            Image(systemName: second_icon)
                            Text(second_counter)
                                .font(.footnote)
                                .foregroundColor(.black)
                        }
                    }

                    if !thirty_counter.isEmpty {
                        HStack(spacing: 10) {
                            Image(systemName: thirty_icon)
                            Text(thirty_counter)
                                .font(.footnote)
                                .foregroundColor(.black)
                        }
                    }
                }

                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            }
        }
        .frame(minHeight: 200)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: String(), subtitle: String(), description: String(), image: UIImage(),
                 primary_icon: String(), primary_counter: String(),
                 second_icon: String(), second_counter: String(),
                 thirty_icon: String(), thirty_counter: String())
    }
}
