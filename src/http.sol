// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import { Vm } from "forge-std/Vm.sol";
import { StringMap } from "./StringMap.sol";

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
}