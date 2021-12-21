//
//  CircleImage.swift
//  Landmarks
//
//  Created by allenlai on 2021/12/20.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    
    var body: some View {
        image
            .clipShape(Circle())    // vs. iOS 15.0+: mask(alignment:_:) / iOS 13.0-15.2: mask(_:)
            .overlay {              // vs. ZStack
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image(.Assets.turtlerock))
    }
}

extension String {
    struct Assets {
        static let turtlerock = "turtlerock"
    }
}
