// Copyright © 2022 Brian Drelling. All rights reserved.

/// Determines the method by which parameters are encoded when sent via HTTP bodies.
public enum HTTPBodyEncoding: String {
    /// Encodes the HTTP body as application/json.
    case json = "application/json"
    /// Encodes the HTTP body as application/x-www-form-urlencoded.
    case wwwFormURLEncoded = "application/x-www-form-urlencoded; charset=utf-8"
}
