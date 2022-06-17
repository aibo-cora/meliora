//
//  Identity.swift
//  Nexus
//
//  Created by Yura on 11/14/21.
//

import SwiftUI
import Joint

struct Identity: View {
    @State private var didAppear = false
    
    let user: User
    
    var body: some View {
        HStack {
            Image(systemName: "touchid")
                .font(.title)
            Spacer()
            VStack(alignment: .center) {
                Text("\(user.given)")
                Text("\(user.email)")
                    .font(.footnote)
                    .lineLimit(1)
            }
            .opacity(didAppear ? 0.5 : 1)
        }
        .padding()
        .onAppear {
            self.didAppear.toggle()
        }
    }
}

struct Identity_Previews: PreviewProvider {
    static var previews: some View {
        Identity(user: User(first: "Yura", email: "yura.fila@gmail.com"))
    }
}
