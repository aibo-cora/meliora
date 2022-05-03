# meliora
This is a streaming app that is using a custom video streaming framework `Joint` - https://github.com/aibo-cora/joint-spm
<br>
<br>
This app is just a shell for now, proof of concept. You are more than welcome to contribute to this project.

<h4>Dependencies</h4>
Add these to your pod file.
<pre>
  pod 'SocketRocket', '0.6.0'
  pod 'MQTTClient', '0.15.3'
</pre>

<h4>Known Issues</h4>
- Sign in with Apple does not provide a unique network User.<br>
- Selecting a streamer from the list should display a preview of the stream and show streamer's description.<br>
- Video stream is clipped on top and botton (iPhone X), left and right side (iPad)<br>
