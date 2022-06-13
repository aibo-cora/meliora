# "Courage starts with showing up and letting ourselves be seen."
<br>
<br>
    This is a streaming app that is using a proprietary video streaming framework `Joint` - https://github.com/aibo-cora/joint-spm
<br>
<br>
This app is just a shell for now, proof of concept. You are more than welcome to contribute to this project or use this as an example to create your own amazing application.

<br><br>
<h2> Purpose </h2>
The purpose of this project is to bring developers, designers, sponsors, investors together to make an awesome streaming application, an environment where users decide what content is right for them.

<h2> Teams </h2>
<ol>  
 <li> Eleutheria </li>
    <ul> 
        <li> Users decide what kind of content the app delivers (Content Control - CC) </li>
            <ul>
                <li> Design content & focus filter UI </li>
                <li> Card based 􀉿 and dislike for content. Rewind? </li>
            </ul>
    </ul>
 <li> Theia </li> 
    <ul> 
        <li> Video classification </li>
            <ul>
                <li> Analyze and tag each video for CC filtering </li>
            </ul>
    </ul> 
 <li> Soteria </li> 
    <ul> 
        <li> Video watermarking </li>
            <ul>
                <li> Embed digital footprint for IP </li>
            </ul>
    </ul> 
</ol>  

<h4> Future features </h4>
<ol>  
 <li> UI </li>
    <ul> 
        <li> Await for framework update to interactively add additional streams (multiple camera angles or co-hosts) into the main stream in <code>Go Live</code> </li>
        <li> Redesign <code>Staging</code> to send a request to be added to a stream </li>
    </ul>
</ol> 

<h4> Known Issues </h4>
<ol>  
 <li> Authentication </li>
    <ul> 
        <li> If the API server is down, users signing in won't be in the database </li>
            <ul>
                <li> Sync with DB on app launch </li>
            </ul>
    </ul>
 <li> Performance - Redraws </li>
    <ul> 
        <li> Staging </li>
    </ul> 
 <li> Performance - Energy Use </li>
    <ul> 
        <li> During stream </li>
            <ul>
                <li> Device becomes way too hot </li>
            </ul>
    </ul> 
</ol> 
<br><br>
Joint version: <code>1.0.12</code>
