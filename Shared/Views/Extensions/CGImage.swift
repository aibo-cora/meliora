//
//  CGImage.swift
//  Nexus (iOS)
//
//  Created by Yura on 1/17/22.
//

import Foundation
import VideoToolbox

extension CGImage {
    public static func create(from cvPixelBuffer: CVPixelBuffer?) -> CGImage? {
        guard let pixelBuffer = cvPixelBuffer else {
            return nil
        }
        var cgImage: CGImage?
        
        VTCreateCGImageFromCVPixelBuffer(pixelBuffer, options: nil, imageOut: &cgImage)
        
        return cgImage
    }
}
