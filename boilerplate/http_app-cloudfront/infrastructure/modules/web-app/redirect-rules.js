'use strict';

// ==========================================================================================//
// This is an example of lambda@edge function that modifies path for requests that are 
// forwarded to origin.
// ==========================================================================================//

exports.handler = (event, context, callback) => {
    const request = event.Records[0].cf.request;

    // Modify request path by for example appending index.html to your requests if needed
    // var originReqPath = request.uri    
    // const requestResource = originReqPath.match(/[^\\]*\.(\w+)$/)
    // if (!requestResource) {        
    //     originReqPath = originReqPath.replace(/\/$/, "") + "/index.html" // append index.html to non-resource requests
    // }

    console.log("Path result: " + originReqPath)
    request.uri = originReqPath
    callback(null, request);
};