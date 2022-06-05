//
//  MissionControl2.swift
//  Meliora
//
//  Created by Yura on 6/5/22.
//

import SwiftUI

struct MissionControl2: View {
    @StateObject var model = ControlModel()
    @State private var dragPosition: CGPoint?
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .center, spacing: 20, content: {
                    Image(systemName: "face.smiling")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(.yellow)
                    Text("Courage starts with showing up and letting ourselves be seen.")
                })
                
                Spacer()
                
                VStack {
                    ScrollView(.horizontal) {
                        HStack(alignment: .center, spacing: 30) {
                            ForEach(model.controls, id: \.id) { control in
                                control
                            }
                        }
                    }
                    .padding(.bottom, 50)
                    
//                    let drag = DragGesture()
//                        .onChanged { value in
//                            self.dragPosition = value.location
//                        }
//                    Button {
//
//                    } label: {
//                        Image(systemName: "eye")
//                            .scaledToFit()
//                    }
                }
                
            }
            .padding()
        }
    }
}

class ControlModel: ObservableObject {
    @Published var selection = 0
    
    let controls = [
        Control(description: ""),
        Control(description: "WATCH"),
        Control(description: "GO LIVE"),
        Control(description: "COMMS"),
        Control(description: "SETTINGS"),
        Control(description: ""),
    ]
}

struct Control: View, Identifiable {
    let selected = false
    
    let id = UUID()
    let description: String
    
    var body: some View {
        ZStack {
            if selected {
                Circle()
            }
            
            Text(description)
                .font(.custom("SpecialElite-Regular", size: 16))
        }
        
            
    }
}

struct MissionControl2_Previews: PreviewProvider {
    static var previews: some View {
        MissionControl2()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
            .previewDisplayName("iPhone 13 Pro Max")

        MissionControl2()
            .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            .previewDisplayName("iPhone X")
    }
}
