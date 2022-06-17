//
//  SessionControlLabel.swift
//  Meliora
//
//  Created by Yura on 6/17/22.
//

import SwiftUI

struct SessionControlLabel: View {
    let condition: Bool
    let label: String
    
    var body: some View {
        if self.condition {
            BlinkingLabel(label: self.label)
                .padding(.bottom, 25)
        } else {
            StartSessionLabel()
                .padding(.bottom, 25)
        }
    }
}

struct SessionControlLabel_Previews: PreviewProvider {
    static var previews: some View {
        SessionControlLabel(condition: false, label: "")
    }
}
