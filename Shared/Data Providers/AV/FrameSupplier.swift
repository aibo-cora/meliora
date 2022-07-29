//
//  FrameSupplier.swift
//  Nexus (iOS)
//
//  Created by Yura on 2/6/22.
//

import Foundation
import AVFoundation
import Joint

class FrameSupplier: NSObject, ObservableObject {
    static let shared = FrameSupplier()
    
    @Published
    var current: CVPixelBuffer?
    
    let videoOutputQueue = DispatchQueue(label: "video.output.queue",
                                           qos: .userInitiated,
                                    attributes: [],
                          autoreleaseFrequency: .workItem,
                                        target: nil)
    
    private override init() {
        super.init()
    }
}

extension FrameSupplier: VideoDisplayDelegate {
    func processSampleBuffer(buffer: CMSampleBuffer) {
        if let buffer = buffer.imageBuffer {
            DispatchQueue.main.async {
                self.current = buffer
            }
        }
    }
}
