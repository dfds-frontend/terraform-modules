'use strict';

exports.handler = (event, context, callback) => {
    const request = event.Records[0].cf.request;
    var originReqPath = request.uri    
    var requestResource = originReqPath.match(/[^\\]*\.(\w+)$/)
    if (!requestResource) {        
        originReqPath = originReqPath.replace(/\/$/, "") + "/index.html"
    }
    // strip /assets/mys3bucketapp from URL request path
    originReqPath = originReqPath.replace(/^\/assets\/mys3bucketapp/, "")

    // strip /router/mys3bucketapp from URL request path
    originReqPath = originReqPath.replace(/^\/router\/mys3bucketapp/, "")
    console.log("Path result: " + originReqPath)
    request.uri = originReqPath
    callback(null, request);
};