// Copyright © 2022 Brian Drelling. All rights reserved.

/// HTTP headers are components of the header section of request and response messages.
///
/// HTTP headers allow the client and the server to pass additional information with the request or the response.
/// An HTTP header consists of its case-insensitive name followed by a colon ':', then by its value (without line breaks).
/// Leading white space before the value is ignored.
///
/// Sources:
/// - [Mozilla - HTTP Headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers)
/// - [Wikipedia - List of HTTP Header Fields](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields)
public enum HTTPHeader: String {
    // MARK: Request

    /// Media type(s) that is/are acceptable for the response.
    case accept = "Accept"

    /// Acceptable instance-manipulations for the request
    case acceptableInstanceManipulations = "A-IM"

    /// Character sets that are acceptable.
    case acceptCharset = "Accept-Charset"

    /// List of acceptable encodings.
    case acceptEncoding = "Accept-Encoding"

    /// List of acceptable human languages for response.
    case acceptLanguage = "Accept-Language"

    /// Acceptable version in time.
    case acceptDatetime = "Accept-Datetime"

    /// Contains the credentials to authenticate a user agent with a server.
    case authorization = "Authorization"

    /// An HTTP cookie previously sent by the server with Set-Cookie.
    case cookie = "Cookie"

    /// Indicates that particular server behaviors are required by the client.
    case expect = "Expect"

    /// Disclose original information of a client connecting to a web server through an HTTP proxy.
    case forwarded = "Forwarded"

    /// The email address of the user making the request.
    case from = "From"

    /// The domain name of the server (for virtual hosting), and the TCP port number on which the server is listening.
    /// The port number may be omitted if the port is the standard port for the service requested.
    ///
    /// Mandatory since HTTP/1.1. If the request is generated directly in HTTP/2, it should not be used.
    case host = "Host"

    /// Only perform the action if the client supplied entity matches the same entity on the server.
    ///
    /// This is mainly for methods like `PUT` to only update a resource if it has not been modified since the user last updated it.
    case match = "If-Match"

    /// Allows a `304 Not Modified` to be returned if content is unchanged.
    case ifModifiedSince = "If-Modified-Since"

    /// Allows a `304 Not Modified` to be returned if content is unchanged.
    case ifNoneMatch = "If-None-Match"

    /// If the entity is unchanged, send me the part(s) that I am missing; otherwise, send me the entire new entity.
    case ifRange = "If-Range"

    /// Only send the response if the entity has not been modified since a specific time.
    case ifUnmodifiedSince = "If-Unmodified-Since"

    /// Limit the number of times the message can be forwarded through proxies or gateways.
    case maxForwards = "Max-Forwards"

    /// Initiates a request for cross-origin resource sharing (asks server for Access-Control-* response fields).
    case origin = "Origin"

    /// Contains the credentials to authenticate a user agent with a proxy server.
    case proxyAuthorization = "Proxy-Authorization"

    /// Request only part of an entity. Bytes are numbered from 0.
    case range = "Range"

    /// This is the address of the previous web page from which a link to the currently requested page was followed.
    ///
    /// (The word “referrer” has been misspelled in the RFC as well as in most implementations to the point that
    /// it has become standard usage and is considered correct terminology)
    case referer = "Referer"

    /// Specifies the transfer encodings the user agent is willing to accept.
    ///
    /// The same values as for the response header field Transfer-Encoding can be used,
    /// plus the "trailers" value (related to the "chunked" transfer method) to notify the server
    /// it expects to receive additional fields in the trailer after the last, zero-sized, chunk.
    /// Only `trailers` is supported in HTTP/2.
    case te = "TE" // swiftlint:disable:this identifier_name

    /// The user agent string of the user agent.
    case userAgent = "User-Agent"

    // MARK: Response

    /// Indicates whether the response can be shared with requesting code from the given origin.
    case accessControlAllowOrigin = "Access-Control-Allow-Origin"

    /// Tells browsers whether to expose the response to frontend JavaScript code when the
    /// request's credentials mode (Request.credentials) is "include".
    case accessControlAllowCredentials = "Access-Control-Allow-Credentials"

    /// Indicates which headers can be exposed as part of the response by listing their names.
    case accessControlExposeHeaders = "Access-Control-Expose-Headers"

    /// Indicates how long the results of a preflight request (that is the information
    /// contained in the Access-Control-Allow-Methods and Access-Control-Allow-Headers headers) can be cached.
    case accessControlMaxAge = "Access-Control-Max-Age"

    /// Specifies the method or methods allowed when accessing the resource in response to a preflight request.
    case accessControlAllowMethods = "Access-Control-Allow-Methods"

    /// Used in response to a preflight request which includes the Access-Control-Request-Headers
    /// to indicate which HTTP headers can be used during the actual request.
    case accessControlAllowHeaders = "Access-Control-Allow-Headers"

    /// Specifies which patch document formats this server supports.
    case acceptPatch = "Accept-Patch"

    /// What partial content range types this server supports via byte serving.
    case acceptRanges = "Accept-Ranges"

    /// The age the object has been in a proxy cache in seconds.
    case age = "Age"

    /// Valid methods for a specified resource. To be used for a `405 Method Not Allowed`.
    case allow = "Allow"

    /// An opportunity to raise a "File Download" dialogue box for a known MIME type
    /// with binary format or suggest a filename for dynamic content.
    /// Quotes are necessary with special characters.
    case contentDisposition = "Content-Disposition"

    /// The type of encoding used on the data. See HTTP compression.
    case contentEncoding = "Content-Encoding"

    /// The natural language or languages of the intended audience for the enclosed content.
    case contentLanguage = "Content-Language"

    /// An alternate location for the returned data.
    case contentLocation = "Content-Location"

    /// Where in a full body message this partial message belongs.
    case contentRange = "Content-Range"

    /// Specifies the delta-encoding entity tag of the response.
    case deltaBase = "Delta-Base"

    /// An identifier for a specific version of a resource, often a message digest.
    case eTag = "ETag"

    /// Gives the date/time after which the response is considered stale (in "HTTP-date" format as defined by RFC 7231).
    case expires = "Expires"

    /// Instance-manipulations applied to the response.
    case instanceManipulations = "IM"

    /// The last modified date for the requested object (in "HTTP-date" format as defined by RFC 7231).
    case lastModified = "Last-Modified"

    /// Used to express a typed relationship with another resource, where the relation type is defined by RFC 5988.
    case link = "Link"

    /// Used in redirection, or when a new resource has been created.
    case location = "Location"

    /// Defines the authentication method that should be used to gain access to a resource behind a Proxy server.
    case proxyAuthenticate = "Proxy-Authenticate"

    ///
    case refresh = "Refresh"

    /// If an entity is temporarily unavailable, this instructs the client to try again later.
    /// Value could be a specified period of time (in seconds) or a HTTP-date.
    case retryAfter = "Retry-After"

    /// A name for the server.
    case server = "Server"

    /// An HTTP cookie.
    case setCookie = "Set-Cookie"

    /// CGI header field specifying the status of the HTTP response. Normal HTTP responses use a separate "Status-Line" instead, defined by RFC 7230.
    case status = "Status"

    /// A HSTS Policy informing the HTTP client how long to cache the HTTPS only policy and whether this applies to subdomains.
    case strictTransportSecurity = "Strict-Transport-Security"

    /// Allows the sender to include additional fields at the end of chunked message.
    case trailer = "Trailer"

    /// Specifies the form of encoding used to safely transfer the entity to the user. **Must not be used with HTTP/2.**
    case transferEncoding = "Transfer-Encoding"

    /// Tells downstream proxies how to match future request headers to decide whether
    /// the cached response can be used rather than requesting a fresh one from the origin server.
    case vary = "Vary"

    /// A general warning field containing information about possible problems.
    case warning = "Warning"

    /// Defines the authentication method that should be used to gain access to a resource.
    case wwwAuthenticate = "WWW-Authenticate"

    /// Offers clickjacking protection.
    ///
    /// Possible values:
    /// - deny - no rendering within a frame
    /// - sameorigin - no rendering if origin mismatch
    /// - allow-from - allow from specified location
    /// - allowall - non-standard, allow from any location
    case xFrameOptions = "X-Frame-Options"

    // MARK: Request and Response

    /// Specifies directives for caching mechanisms in both requests and responses.
    case cacheControl = "Cache-Control"

    /// Control options for the current connection and list of hop-by-hop request fields. **Must not be used with HTTP/2**.
    case connection = "Connection"

    /// The length of the request body in octets (8-bit bytes).
    case contentLength = "Content-Length"

    /// A Base64-encoded binary MD5 sum of the content of the request body.
    case contentMD5 = "Content-MD5"

    /// The Media type of the body of the request (used with `POST` and `PUT` requests).
    case contentType = "Content-Type"

    /// The date and time at which the message was originated (in "HTTP-date" format as defined by RFC 7231 Date/Time Formats).
    case date = "Date"

    /// Implementation-specific header that may have various effects anywhere along the request-response chain.
    ///
    /// Used for backwards compatibility with HTTP/1.0 caches where the Cache-Control header is not yet present.
    case pragma = "Pragma"

    /// Ask the server to upgrade to another protocol. **Must not be used in HTTP/2.**
    case upgrade = "Upgrade"

    /// Informs the server of proxies through which the request was sent.
    case via = "Via"
}

// MARK: - Extensions

public extension HTTPHeader {
    /// Shorthand for `.acceptableInstanceManipulations`
    static let aim: HTTPHeader = .acceptableInstanceManipulations

    /// Shorthand for `.instanceManipulations`
    static let im: HTTPHeader = .instanceManipulations // swiftlint:disable:this identifier_name
}
