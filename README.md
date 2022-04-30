# meliora
This is a streaming app that is using a custom video streaming framework `Joint`. The framework uses MQTT protocol to deliver live video stream.
<br><br>

<h2> Steps to configure your app for live streaming </h2>
<ol>
<li> Broker <br><br>
  Create a broker cluster with HiveMQ (or any other solution) @ https://console.hivemq.cloud/, there are different tiers for your needs. I'd go with the free tier for development purposes. Declare a <code>Broker</code> instance in your app and use the information provided in your dashboard for arguments.
  
  <b> Dashboard Example </b><br><br>
  URL 2457aa93d1444b8cb0dd5d5891a3c3d6.s1.eu.hivemq.cloud<br>
  PORT(TLS) 8883 <br>
  <br>
  Client app credentials to authenticate with the server
  <br>
  <i>Manage Cluster->Access Management->Add User & Password</i><br>
  <br>
  USERNAME test.admin<br>
  PASSWORD P2ssword<br>
  <br>
  
  <pre>
  let broker = Broker(ip: "2457aa93d1444b8cb0dd5d5891a3c3d6.s1.eu.hivemq.cloud",
                    port: 8883,
                username: "test.admin",
                password: "P2ssword")
    </pre> </li>
<li> Capture Components <br><br>
  <pre>
    lazy var components = CaptureComponents(captureSession: CameraManager.shared.session,
                                                  delegate: FrameSupplier.shared)
  </pre>
  
  <code>captureSession</code> Configure an <code>AVCaptureSession</code> instance by adding video input. <code>Joint</code> takes care of the audio input and AV output, so you do not need to do anything here. Do not install taps on the microphone in your app, it might result in unexpected behavior. Adding video output is also not needed. The framework will remove it and add another one that is configured to the required specs.
  <br><br>
  <code>delegate</code> Conform an object supplying <code>CVPixelBuffer</code> for your video preview to <code>VideoDisplayDelegate</code>. This object will be receiving sample buffers from the AV capture session you configured. If you are using <code>SwiftUI</code>, make sure you setup a chain of modifiers to convert <code>CMSampleBuffer</code> to <code>Image</code>. Refer to the sample app for a way to do it.
  </li>
<li style="color:blue"> Joint Session </li>
  <pre>
  jointSession = JointSession(apiKey: "C!9X5&/WPuU(6pp5",
                              broker: broker,
                   captureComponents: components,
                            delegate: nil,
                         loggingFlag: false)
  </pre>
  <br>
  <code>apiKey</code> shown provides basic (free) scopes for live streaming and video conference (future release) applications. <br>
  <code>delegate</code> is reserved for future use. Use <code>nil</code> for now.
  <code>loggingFlag</code> Set to <code>true</code> to see detailed logs.
  <h4> Publishers </h4>
  <code>jointSession?.$sessionStatus</code> Use this to give feedback to users about the status of the session.<br>
  <code>jointSession?.$activeStreamers</code> This is a <code>Set</code> of <code>Streamer</code>. Use this to display active streamers on the network.
<li> Connect to broker </li>
  <pre>
  await jointSession?.configureClient()
  </pre>
  <code>configureClient()</code> will verify the API key first, then attempt connecting to the broker that you have configured.
</ol>
<br>
<code>Streamer</code> Is a unique entity on your network. An object of this type should have a name, email and channel associated with it.
<br>
<h3>Live streaming</h3>
<code>jointSession?.startSession(streamer: Streamer())</code> Start Live session.<br>
<code>jointSession?.stopSession()</code> Stop Live session.<br><br>

<h3>Watching stream</h3>
<pre>
jointSession?.configurePlayer(watching: streamer, using: player)
</pre>
<code>watching</code> Active streamer on the network.<br>
<code>using</code> An instance of <code>AVQueuePlayer</code> in your view.
