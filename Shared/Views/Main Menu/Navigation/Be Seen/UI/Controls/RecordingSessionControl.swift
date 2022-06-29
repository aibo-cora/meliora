//
//  RecordingSessionControl.swift
//  Meliora
//
//  Created by Yura on 6/17/22.
//

import SwiftUI

struct RecordingSessionControl: View {
    @State private var recording = false
    
    var body: some View {
        Button(action: {
            print(recording ? "Stopped recording" : "Started recording")
            
            recording.toggle()
        }) {
            SessionControlLabel(condition: recording, label: "Recording")
        }
    }
}

struct RecordingSessionControl_Previews: PreviewProvider {
    static var previews: some View {
        RecordingSessionControl()
    }
}
