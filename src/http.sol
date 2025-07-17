// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Vm} from "forge-std/Vm.sol";
import {StringMap} from "./StringMap.sol";

library HTTP {
    using StringMap for StringMap.StringToStringMap;

    Vm constant vm = Vm(address(bytes20(uint160(uint256(keccak256("hevm cheat code"))))));

    error HTTPArrayLengthMismatch(uint256 a, uint256 b);

    enum Method {
        GET,
        POST,
        PUT,
        DELETE,
        PATCH
    }

    struct Request {
        string url;
        string body;
        Method method;
        StringMap.StringToStringMap headers;
        StringMap.StringToStringMap query;
    }

    struct Response {
        uint256 status;
        string data;
    }

    struct Client {
        Request[] requests;
    }

    function initalize(HTTP.Client storage client) internal returns (HTTP.Request storage) {
        client.requests.push();
        return client.requests[client.requests.length - 1];
    }

    function initialize(HTTP.Client storage client, string memory url) internal returns (HTTP.Request storage) {
        return withUrl(initialize(client), url);
    }

    function instance(HTTP.Client storage client) internal view returns (HTTP.Request storage) {
        return client.requests[client.requests.length - 1];
    }

    function withUrl(HTTP.Request storage req, string memory url) internal returns (HTTP.Request storage) {
        req.url = url;
        return req;
    }

    function withMethod(HTTP.Request storage req, HTTP.Method method) internal returns (HTTP.Request storage) {
        req.method = method;
        return req;
    }

    function GET(HTTP.Request storage req) internal returns (HTTP.Request storage) {
        return withBody(withMethod(req, HTTP.Method.GET), "");
    }

    function GET(HTTP.Request storage req, string memory url) internal returns (HTTP.Request storage) {
        return GET(withUrl(req, url));
    }

    function POST(HTTP.Request storage req) internal returns (HTTP.Request storage) {
        return withMethod(req, HTTP.Method.POST);
    }

    function POST(HTTP.Request storage req, string memory url) internal returns (HTTP.Request storage) {
        return POST(withUrl(req, url));
    }

}
