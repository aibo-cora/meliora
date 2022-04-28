//
//  CameraPermission.swift
//  Nexus (iOS)
//
//  Created by Yura on 12/11/21.
//

import SwiftUI
import AVKit

struct MicrophonePermission: View {
    @Binding var permissionGranted: Bool
    
    var body: some View {
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .authorized:
            HStack {
                ProgressView()
                    .progressViewStyle(.automatic)
                    .padding()
                Text("Starting up...")
            }
            .onAppear(perform: {
                permissionGranted = true
            })
            .padding()
        case .notDetermined:
            Text("For the best possible experience, are you ready to grant Microphone permissions to start a stream?")
                .padding()
            Button {
                AVCaptureDevice.requestAccess(for: .audio) { granted in
                    DispatchQueue.main.async {
                        if granted {
                            permissionGranted.toggle()
                        }
                    }
                }
            } label: {
                Text("Let's do it")
            }
        case .restricted, .denied:
            VStack {
                Text("Microphone permission was denied or restricted previously. Full access is required for the best possible experience during a stream. Change it in Settings.")
                    .padding()
                Button {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!,
                                                 options: [:],
                                       completionHandler: nil)
                } label: {
                    Text("Open Settings")
                }
            }
        @unknown default:
            Text("Microphone access unknown.")
        }
    }
}
