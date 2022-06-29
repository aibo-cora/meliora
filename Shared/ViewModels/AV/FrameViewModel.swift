//
//  FrameViewModel.swift
//  Nexus (iOS)
//
//  Created by Yura on 2/6/22.
//

import Foundation
import CoreImage

class FrameViewModel: ObservableObject {
    @Published var frame: CGImage?
    
    private let supplier = FrameSupplier.shared
    
    init() {
        setupSubscriptions()
    }
    
    private func setupSubscriptions() {
        supplier.$current
            .receive(on: RunLoop.main, options: nil)
            .compactMap { CGImage.create(from: $0) }
            .assign(to: &$frame)
    }
}
