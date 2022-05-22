//
//  StreamerList.swift
//  Nexus (iOS)
//
//  Created by Yura on 4/1/22.
//

import SwiftUI
import Joint

struct StreamerList: View {
    @State private var active = false
    
    var streamers: [Streamer]
    let session: Session?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(streamers.indices, id: \.self) { index in
                    GeometryReader { proxy in
                        let scale = configureScale(proxy: proxy)
                        
                        NavigationLink(destination:
                            Watching(streamer: streamers[index], session: session)
                                .ignoresSafeArea()) {
                            VStack {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .padding(30)
                                    .cornerRadius(5.0)
                                    .scaleEffect(scale)
                                    .frame(width: 100, height: 150, alignment: .center)
                                
                                Text(streamers[index].name)
                                    .fixedSize()
                                    .truncationMode(.tail)
                            }
                        }
                    }
                }
                .padding(.trailing, 75)
            }
            .padding()
        }
    }
    
    internal func configureScale(proxy: GeometryProxy) -> CGFloat {
        var scale = 1.0
        let offset = proxy.frame(in: .global).minX
        
        if abs(offset) < 150.0 {
            scale += (150.0 - abs(offset)) / 500
        }
        return scale
    }
}

struct StreamerList_Previews: PreviewProvider {
    static var previews: some View {
        StreamerList(streamers: [Streamer](), session: nil)
    }
}
