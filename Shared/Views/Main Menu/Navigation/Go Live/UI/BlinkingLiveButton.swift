//
//  BlinkingLiveButton.swift
//  Meliora
//
//  Created by Yura on 6/12/22.
//

import SwiftUI

struct BlinkingLiveButton: View {
    @State private var blink = false
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 20, height: 20)
            Text("Live")
                
        }
        .padding(.all, 10)
        .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(.red, lineWidth: 4))
        .opacity(blink ? 0 : 1)
        .onAppear() {
            withAnimation(Animation
                .linear(duration: 1)
                .repeatForever()) { blink.toggle() }
        }
        .foregroundColor(.red)
        .padding(.bottom, 100)
    }
}

struct BlinkingLiveButton_Previews: PreviewProvider {
    static var previews: some View {
        BlinkingLiveButton()
    }
}
