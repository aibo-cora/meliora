import AVFoundation

class CameraManager: ObservableObject {
    @Published var error: CameraError?

    let session = AVCaptureSession()
    
    private let sessionQueue = DispatchQueue(label: "capture.session.serial")
    private let videoOutput = AVCaptureVideoDataOutput()
    private var status = Status.unconfigured
    
    var streaming = false

    enum Status {
        case unconfigured
        case configured
        case unauthorized
        case failed
    }
    
    public static let shared = CameraManager()
    private init() {
        configure()
    }

    private func configure() {
        checkPermissions()
        sessionQueue.async {
            self.configureCaptureSession()
        }
    }
    
    private func set(error: CameraError?) {
        DispatchQueue.main.async {
            self.error = error
        }
    }
    
    private func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined:
            sessionQueue.suspend()
                
            AVCaptureDevice.requestAccess(for: .video) { authorized in
                if !authorized {
                    self.status = .unauthorized
                    self.set(error: .deniedAuthorization)
                }
                self.sessionQueue.resume()
            }
            case .restricted:
                status = .unauthorized
                set(error: .restrictedAuthorization)
            case .denied:
                status = .unauthorized
                set(error: .deniedAuthorization)
            case .authorized:
                break
            @unknown default:
                status = .unauthorized
                set(error: .unknownAuthorization)
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
    }
    
    public func stop() {
        print("stop capture session, session is '\(status)'")
        sessionQueue.async {
            if self.session.isRunning {
                self.session.stopRunning()
            }
        }
    }
}
