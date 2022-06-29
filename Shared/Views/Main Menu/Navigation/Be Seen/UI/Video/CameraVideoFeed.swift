//
//  CameraVideoFeed.swift
//  Meliora
//
//  Created by Yura on 6/17/22.
//

import SwiftUI

struct CameraVideoFeed: View {
    let frame: CGImage?
    
    var body: some View {
        if let frame = frame {
            GeometryReader { geometry in
                Image(frame, scale: 1.0, orientation: .leftMirrored, label: Text("Camera feed"))
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    .clipped()
            }
        } else {
            ProgressView()
        }
    }
}

struct CameraVideoFeed_Previews: PreviewProvider {
    static var previews: some View {
        CameraVideoFeed(frame: nil)
    }
}
