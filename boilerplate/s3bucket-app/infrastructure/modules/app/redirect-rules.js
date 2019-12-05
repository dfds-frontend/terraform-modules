'use strict';

// ==========================================================================================//
// This is an example of lambda@edge function that modifies path for requests that are 
// forwarded to origin that is expected to support l
// It supports request path that is of the following pattern */app_path/*. It meant to support 
// An example of a supported request could be as follows: 
//                         https://www.my-example.com/[locale]/my-business-unit/my-application/
// This code can handle requesting resources, that are placed at following paths at the origin:
// ├── [root]/
//     ├── [locale]/
//         ├── my-business-unit
//             ├── my-application
//     ├── assets
//         ├── my-business-unit
//             ├── my-application
//     ├── router
//         ├── my-business-unit
//             ├── my-application
// ==========================================================================================//

exports.handler = (event, context, callback) => {
    const request = event.Records[0].cf.request;
    var originReqPath = request.uri    
    var requestResource = originReqPath.match(/[^\\]*\.(\w+)$/)
    if (!requestResource) {        
        originReqPath = originReqPath.replace(/\/$/, "") + "/index.html" // append index.html to non-resource requests
    }
    // ==========================================================================================//
    // The following allows a proper routing of assets and error response handling in applications
    // The supported behavior path, for an application, has the following pattern: */{app_path}/ 
    // A path pattern can support multiple path levels. Example: my-business-unit/my-application
    // ==========================================================================================//
    var app_path = "my-business-unit/my-application"
    // strip /assets/{app_path} from URL request path
    originReqPath = originReqPath.replace("/assets/" + app_path, "") 
    // strip /router/{app_path} from URL request path
    originReqPath = originReqPath.replace("/router/" + app_path, "")

    console.log("Path result: " + originReqPath)
    request.uri = originReqPath
    callback(null, request);
};