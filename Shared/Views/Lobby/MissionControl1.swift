//
//  MissionControl.swift
//  Meliora
//
//  Created by Yura on 6/3/22.
//

import SwiftUI

//struct MissionControl1: View {
//    @StateObject var model = ControlModel()
//    @State var timeInterval = 0
//    @State var hudIsVisible = false
//
//    let timer = Timer
//        .publish(every: 1, on: .main, in: .default)
//        .autoconnect()
//
//    var body: some View {
//        VStack {
//            if hudIsVisible {
//                VStack {
//                    Spacer()
//                    HStack {
//                        ForEach(model.controls, id: \.id) { control in
//                            control
//                        }
//                        Control(color: .blue, interactive: true, name: "eye.slash.fill", action: {
//                            hudIsVisible.toggle()
//                        })
//                    }
//                }.animation(Animation.default, value: hudIsVisible)
//            } else {
//                VStack {
//                    Spacer()
//                    Control(color: .blue, interactive: true, name: "eye.fill", action: {
//                        hudIsVisible.toggle()
//                    })
//                    .padding([.trailing, .leading, .bottom], 10)
//                    .onReceive(timer) { time in
//                        timeInterval += 1
//                    }
//                    .opacity(timeInterval % 10 == 0 ? 0 : 1)
//                    .onAppear() {
//                        withAnimation(Animation.spring(response: 2.0, dampingFraction: 2.0, blendDuration: 1.0).repeatForever()) {}
//                    }
//                }
//            }
//        }
//
//    }
//}
//
//struct MissionControl1_Previews: PreviewProvider {
//    static var previews: some View {
//        MissionControl1()
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
//            .previewDisplayName("iPhone 13 Pro Max")
//
//        MissionControl1()
//            .previewDevice(PreviewDevice(rawValue: "iPhone X"))
//            .previewDisplayName("iPhone X")
//    }
//}

//class ControlModel: ObservableObject {
//    let controls = [
//        Control(color: .brown, interactive: true, name: "tv.fill", action: { }),
//        Control(color: .red, interactive: true, name: "video.fill", action: { }),
//        Control(color: .green, interactive: false, name: "square.and.arrow.up.fill", action: { }),
//        Control(color: .blue, interactive: false, name: "mail", action: { }),
//        Control(color: .gray, interactive: false, name: "gearshape.2.fill", action: { }),
//    ]
//}
//
//struct Control: View, Identifiable {
//    let color: Color
//    let interactive: Bool
//    let id = UUID()
//    let name: String
//    let action: () -> Void
//
//    init(color: Color, interactive: Bool, name: String, action: @escaping () -> Void) {
//        self.color = color
//        self.interactive = interactive
//        self.name = name
//        self.action = action
//    }
//
//    var body: some View {
//        withAnimation(Animation.spring(response: 0, dampingFraction: 0, blendDuration: 0), {
//            Button() {
//                action()
//            } label: {
//                Image(systemName: name)
//                    .foregroundColor(color)
//                    .font(.system(size: 30, weight: .bold, design: .serif))
//            }
//            .padding([.trailing, .leading, .bottom], 10)
//            .disabled(!interactive)
//            .opacity(interactive ? 1 : 0.5)
//        })
//    }
//
//}
