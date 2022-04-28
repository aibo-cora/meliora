//
//  FrameViewModel.swift
//  Nexus (iOS)
//
//  Created by Yura on 2/6/22.
//

import Foundation
import CoreImage

class FrameViewModel: ObservableObject {
    @Published
    var frame: CGImage?
    
    private let supplier = FrameSupplier.shared
    
    init() {
        setupSubscriptions()
    }
    
    private func setupSubscriptions() {
        supplier.$current
            .receive(on: RunLoop.main, options: nil)
            .compactMap { buffer in
                return CGImage.create(from: buffer)
            }
            .assign(to: &$frame)
    }
}
