//
//  Staging.swift
//  Meliora
//
//  Created by Yura on 7/29/22.
//

import SwiftUI
import Joint

struct Staging: View {
    let user: AppUser
    @ObservedObject var session: Session
    
    @State private var showPreview = false
    @State private var handleSelection = "Anonymous"
    @State private var audienceSelection = "Everyone"
    
    var body: some View {
        VStack {
            QuoteView()
            Spacer()
            VStack {
//                List {
//                    Section(header: Text("Make your choices")) {
//                        /// Stream Settings
//                        HStack {
//                            Text("Handle: ")
//                            Picker("Choose handle", selection: $handleSelection) {
//                                ForEach(Array(Set(["Anonymous", user.given])), id: \.self) { handle in
//                                    Text(handle)
//                                }
//                            }
//                            .pickerStyle(.segmented)
//                        }
//                        HStack {
//                            Text("Audience: ")
//                            Picker("Choose audience", selection: $audienceSelection) {
//                                ForEach(Array(["Everyone", "Custom..."]), id: \.self) { handle in
//                                    Text(handle)
//                                }
//                            }
//                            .pickerStyle(.segmented)
//                        }
//                    }
//                }
//                .listStyle(.insetGrouped)
//                .cornerRadius(10)
//                .padding([.top, .bottom], 25)
                
                Button {
                    showPreview = true
                } label: {
                    HStack {
                        Image(systemName: "eye.fill")
                        Text("Preview")
                    }
                    .padding()
                }
            }
        }
        .sheet(isPresented: $showPreview,
               onDismiss: dismissPreview,
               content: {
            BeSeen(user: user, session: session)
        })
        .padding()
    }
    
    func dismissPreview() {
        showPreview = false
    }
}

struct Staging_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Staging(user: AppUser(first: "Yura", last: "Filatov", email: "yura.fila@gmail.com",
                                  appleID: "UUID-1",
                                  rank: User.Rank(id: 1),
                                  createdAt: Date()),
                    session: Session())
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
        .previewDisplayName("iPhone 13 Pro Max")
    }
}
