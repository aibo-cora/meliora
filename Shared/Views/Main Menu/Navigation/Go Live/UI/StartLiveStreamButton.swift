//
//  StartLiveStreamButton.swift
//  Meliora
//
//  Created by Yura on 6/12/22.
//

import SwiftUI

struct StartLiveStreamButton: View {
    
    var body: some View {
        HStack {
            Image(systemName: "record.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.red)
                .clipped()
                .padding(.bottom, 100)
        }
        
    }
}

struct StartLiveStreamButton_Previews: PreviewProvider {
    static var previews: some View {
        StartLiveStreamButton()
    }
}
