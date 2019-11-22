'use strict';

exports.handler = (event, context, callback) => {
    const request = event.Records[0].cf.request;
    console.log("Path result: " + request.uri)
    callback(null, request);
};