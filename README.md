# meliora
This is a streaming app that is using a proprietary video streaming framework `Joint` - https://github.com/aibo-cora/joint-spm
<br>
<br>
This app is just a shell for now, proof of concept. You are more than welcome to contribute to this project or use this as an example to create your own amazing application.

<br><br>
<h2> Purpose </h2>
The purpose of this project is to bring developers, designers, sponsors, investors together to make an awesome streaming application. It feels like all the popular apps on the market right now are bland and lack immersiveness. A community application has a much better chance of taking on some of the behemoths, because more creative ideas generated by the contributors and users will be adopted.

<h4>Dependencies</h4>
Add these to your pod file.
<pre>
  pod 'SocketRocket', '0.6.0'
  pod 'MQTTClient', '0.15.3'
</pre>

<h4>Known Issues</h4>
- Sign in with Apple is hadcoded.<br>
    <t> Resolution:
    <t>     <t>need to setup a dedicated container running postgres on AWS.<br>
- Selecting a streamer from the list should display a preview of the stream and show streamer's description.<br>
<br><br>
Joint version: <code>1.0.8</code>
