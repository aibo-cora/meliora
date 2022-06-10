//
//  MissionControl2.swift
//  Meliora
//
//  Created by Yura on 6/5/22.
//

import SwiftUI

/// Onboarding
struct Onboarding: View {
    @StateObject var model = ControlModel()
    
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
                
                ControlDescription(control: model.controls[model.selection])
                
                Spacer()
                VStack {
                    ScrollViewReader { reader in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .center, spacing: 10) {
                                ForEach(Array(model.controls.enumerated()), id: \.element) { index, control in
                                    VStack {
                                        control
                                            .environmentObject(model)
                                            .id(index)
                                    }
                                }
                            }
                        }
                        .padding(.bottom, 50)
                    }
                }
                
                NavigationLink {
                    
                } label: {
                    Image(systemName: "hand.thumbsup")
                        .foregroundColor(.black)
                }

            }
            .padding()
        }
    }
    
    class ControlModel: ObservableObject {
        @Published var selection = 0
        
        let controls = [
            Control(name: "WATCH", description: "Watch videos based on your interests." + "\n\n"
                    + "In addition, the app becomes aware of your preferences based on your browing history. "),
            Control(name: "GO LIVE", description: ""),
            Control(name: "COMMS", description: ""),
            Control(name: "FOR YOU", description: ""),
            Control(name: "SETTINGS", description: "")
        ]
    }
    
    struct ControlDescription: View {
        let control: Control
        
        var body: some View {
            VStack {
                Text(control.description)
                    .padding()
            }
        }
    }
    
    struct Control: View, Identifiable, Hashable {
        static func == (lhs: Onboarding.Control, rhs: Onboarding.Control) -> Bool {
            lhs.id == rhs.id
        }
        
        let id = UUID()
        let name: String
        let description: String
        
        @EnvironmentObject var model: ControlModel
        
        var body: some View {
            VStack {
                Button {
                    for index in 0..<model.controls.count {
                        if model.controls[index].id == id {
                            model.selection = index
                        }
                    }
                } label: {
                    Text(name)
                        .font(.custom("SpecialElite-Regular", size: 16))
                        
                }
                .buttonStyle(GrowingButton())
            }
        }
        
        func hash(into hasher: inout Hasher) {
            
        }
        
        struct GrowingButton: ButtonStyle {
            func makeBody(configuration: Configuration) -> some View {
                configuration.label
                    .padding()
                    .scaleEffect(configuration.isPressed ? 1.3 : 1)
                    .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
            .previewDisplayName("iPhone 13 Pro Max")

        Onboarding()
            .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            .previewDisplayName("iPhone X")
    }
}
