import AVFoundation

class CameraManager: ObservableObject {
    @Published var error: CameraError?
    @Published var streaming = false
    @Published private(set) var status = Status.unconfigured
    
    let session = AVCaptureSession()
    
    private let sessionQueue = DispatchQueue(label: "capture.session.serial")
    
    
    enum Status {
        case unconfigured, configured, unauthorized, failed
    }
    
    public static let shared = CameraManager()
    private init() {
        Task {
            await configure()
        }
        
    }

    private func configure() async {
        let audioResult = await avAuthorization(type: .audio)
        let videoResult = await avAuthorization(type: .video)
        
        if audioResult && videoResult {
            sessionQueue.async {
                self.configureCaptureSession()
            }
        } else {
            self.status = .unauthorized
        }
    }
    
    private func set(error: CameraError?) {
        DispatchQueue.main.async {
            self.error = error
        }
    }
    
    func avAuthorization(type: AVMediaType) async -> Bool {
        let mediaAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: type)
        
        switch mediaAuthorizationStatus {
            case .denied, .restricted: return false
            case .authorized: return true
            case .notDetermined: return await AVCaptureDevice.requestAccess(for: type)
        @unknown default:
            return false
        }
    }
    
    private func configureCaptureSession() {
        session.sessionPreset = .high
        session.beginConfiguration()
        
        do {
            var defaultVideoDevice: AVCaptureDevice?
            
            // Choose the back dual camera, if available, otherwise default to a wide angle camera.
            
            if let dualCameraDevice = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .front) {
                defaultVideoDevice = dualCameraDevice
            } else if let backCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
                // If a rear dual camera is not available, default to the front wide angle camera.
                defaultVideoDevice = backCameraDevice
            } else if let frontCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
                // If the rear wide angle camera isn't available, default to the front wide angle camera.
                defaultVideoDevice = frontCameraDevice
            }
            guard let videoDevice = defaultVideoDevice else {
                print("Default video device is unavailable.")
                
                status = .failed
                session.commitConfiguration()
                
                return
            }
            let videoInput = try AVCaptureDeviceInput(device: videoDevice)
            
            if session.canAddInput(videoInput) {
                session.addInput(videoInput)
            } else {
                print("Couldn't add video device input to the session.")
                
                status = .failed
                session.commitConfiguration()
                
                return
            }
        } catch {
            set(error: .createCaptureInput(error))
            status = .failed
            
            return
        }
        session.commitConfiguration()
        status = .configured
    }
    
    public func start() {
        print("start capture session, session is '\(status)'")
        sessionQueue.async {
            if self.status == .configured {
                self.session.startRunning()
            }
        }
        streaming = true
    }
    
    public func stop() {
        print("stop capture session, session is '\(status)'")
        sessionQueue.async {
            if self.session.isRunning {
                self.session.stopRunning()
            }
        }
        streaming = false
    }
}
