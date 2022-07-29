//
//  QuoteView.swift
//  Meliora
//
//  Created by Yura on 7/29/22.
//

import SwiftUI

struct QuoteView: View {
    @State private var welcome = false
    
    var body: some View {
        Text("\"Courage starts with showing up and letting ourselves be seen.\"")
            .font(.custom("SpecialElite-Regular", size: 17))
            .padding(.top, 50)
            .opacity(welcome ? 1.0 : 0.0)
            .animation(Animation.linear(duration: 2.0), value: welcome)
        
            .onAppear(perform: { welcome = true })
            .onDisappear(perform: { welcome = false })
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView()
    }
}
