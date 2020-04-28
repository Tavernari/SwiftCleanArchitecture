//
//  CustomEmptyView.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 22/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import SwiftUI

struct CustomEmptyView: View {
    var text = ""
    var body: some View {
        VStack(alignment: .center) {
            Text(text)
                .font(.body)
                .foregroundColor(.gray)
                .frame(maxHeight: .infinity)
                .padding(20)
        }
    }
}

struct CustomEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        CustomEmptyView()
    }
}
