// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

/// A list of standard HTTP response status codes.
///
/// All HTTP response status codes are separated into five classes (or categories).
/// The first digit of the status code defines the class of response.
/// The last two digits do not have any class or categorization role.
///
/// The five categories are:
/// - 1xx (Informational): The request was received and understood.
/// - 2xx (Success): The action requested by the client was received, understood and accepted.
/// - 3xx (Redirection): The client must take additional action to complete the request.
/// - 4xx (Client Error): The error seems to have been caused by the client.
/// - 5xx (Server Error): The server failed to fulfill a request.
///
/// Sources:
/// - [Mozilla - HTTP Status Codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)
/// - [Wikipedia - List of HTTP Status Codes](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes)
public enum HTTPStatusCode: Int, CaseIterable, Codable {
    // MARK: ResponseType

    /// The response class representation of status codes, these get grouped by their first digit.
    public enum ResponseType {
        /// Indicates that the request was received and understood.
        ///
        /// It is issued on a provisional basis while request processing continues.
        /// It alerts the client to wait for a final response.
        /// The message consists only of the status line and optional header fields, and is terminated by an empty line.
        case informational

        /// Indicates that the action requested by the client was received, understood and accepted.
        case success

        /// Indicates that the client must take additional action to complete the request.
        ///
        /// Many of these status codes are used in URL redirection.
        case redirection

        /// Indicates that the error seems to have been caused by the client.
        ///
        /// Except when responding to a HEAD request, the server should include an entity containing an explanation of the error situation,
        /// and whether it is a temporary or permanent condition.
        case clientError

        /// Indicates that the server failed to fulfill a request.
        ///
        /// Indicates cases in which the server is aware that it has encountered an error or is otherwise incapable of performing the request.
        /// Except when responding to a HEAD request, the server should include an entity containing an explanation of the error situation,
        /// and indicate whether it is a temporary or permanent condition.
        case serverError

        /// Indicates a status code that is not specified by any standard.
        case undefined
    }

    // MARK: 1xx - Informational

    /// This interim response indicates that everything so far is OK and that the client should
    /// continue with the request or ignore it if it is already finished.
    case `continue` = 100

    /// This code is sent in response to an Upgrade request header by the client, and indicates the protocol the server is switching to.
    case switchingProtocols = 101

    /// This code indicates that the server has received and is processing the request, but no response is available yet.
    case processing = 102

    /// This status code is primarily intended to be used with the Link header to allow the
    /// user agent to start preloading resources while the server is still preparing a response.
    case earlyHints = 103

    // MARK: 2xx - Success

    /// The request has succeeded.
    ///
    /// The meaning of a success varies depending on the HTTP method:
    /// - `GET`: The resource has been fetched and is transmitted in the message body.
    /// - `HEAD`: The entity headers are in the message body.
    /// - `PUT` or `POST`: The resource describing the result of the action is transmitted in the message body.
    /// - `TRACE`: The message body contains the request message as received by the server
    case ok = 200 // swiftlint:disable:this identifier_name

    /// The request has succeeded and a new resource has been created as a result of it.
    ///
    /// This is typically the response sent after a POST request, or after some PUT requests.
    case created = 201

    /// The request has been received but not yet acted upon.
    ///
    /// It is non-committal, meaning that there is no way in HTTP to later send an asynchronous response
    /// indicating the outcome of processing the request.
    /// It is intended for cases where another process or server handles the request, or for batch processing.
    case accepted = 202

    /// This response code means returned meta-information set is not exact set as available from the origin server,
    /// but collected from a local or a third party copy.
    ///
    /// Except this condition, 200 OK response should be preferred instead of this response.
    case nonAuthoritativeInformation = 203

    /// There is no content to send for this request, but the headers may be useful.
    ///
    /// The user-agent may update its cached headers for this resource with the new ones.
    case noContent = 204

    /// This response code is sent after accomplishing request to tell user agent reset document view which sent this request.
    case resetContent = 205

    /// This response code is used because of range header sent by the client to separate download into multiple streams.
    case partialContent = 206

    /// A Multi-Status response conveys information about multiple resources in situations where multiple status codes might be appropriate.
    case multiStatus = 207

    /// Indicates that the members of a DAV binding have already been enumerated in a preceding part of the (multistatus) response,
    /// and are not being included again.
    case alreadyReported = 208

    /// The server has fulfilled a GET request for the resource, and the response is a representation
    /// of the result of one or more instance-manipulations applied to the current instance.
    case imUsed = 226

    // MARK: 3xx - Redirection

    /// The request has more than one possible response.
    ///
    /// The user-agent or user should choose one of them.
    /// There is no standardized way of choosing one of the responses.
    case multipleChoices = 300

    /// This response code means that the URI of the requested resource has been changed permanently.
    case movedPermanently = 301

    /// This response code means that the URI of requested resource has been changed temporarily.
    ///
    /// Previously "Moved temporarily". Superseded by 303 and 307.
    case found = 302

    /// The server sent this response to direct the client to get the requested resource at another URI with a GET request.
    case seeOther = 303

    /// This is used for caching purposes. It tells the client that the response has not been modified,
    /// so the client can continue to use the same cached version of the response.
    case notModified = 304

    /// The requested resource is available only through a proxy, the address for which is provided in the response.
    /// No longer used by most HTTP clients due to security concerns regarding in-band configuration of a proxy.
    case useProxy = 305

    /// Indicates that subsequent requests should use the specified proxy. No longer used.
    case switchProxy = 306

    /// The server sends this response to direct the client to get the requested resource
    /// at another URI with same method that was used in the prior request.
    ///
    /// This has the same semantics as the 302 Found HTTP response code,
    /// with the exception that the user agent must not change the HTTP method used:
    /// If a POST was used in the first request, a POST must be used in the second request.
    case temporaryRedirect = 307

    /// This means that the resource is now permanently located at another URI, specified by the Location: HTTP Response header.
    ///
    /// This has the same semantics as the 301 Moved Permanently HTTP response code,
    /// with the exception that the user agent must not change the HTTP method used:
    /// If a POST was used in the first request, a POST must be used in the second request.
    case permanentRedirect = 308

    // MARK: 4xx - Client Errors

    /// This response means that server could not understand the request due to invalid syntax.
    case badRequest = 400

    /// This response means that the client must authenticate itself to get the requested response.
    case unauthorized = 401

    /// This response code is reserved for future use.
    /// Initial aim for creating this code was using it for digital payment systems however this is not used currently.
    case paymentRequired = 402

    /// The client does not have access rights to the content (eg. they are unauthorized) so the server is rejecting to give proper response.
    ///
    /// Unlike 401, the client's identity is known to the server.
    case forbidden = 403

    /// The server can not find the requested resource.
    ///
    /// In the browser, this means the URL is not recognized.
    /// In an API, this can also mean that the endpoint is valid but the resource itself does not exist.
    /// Servers may also send this response instead of 403 to hide the existence of a resource from an unauthorized client.
    case notFound = 404

    /// The request method is known by the server but has been disabled and cannot be used.
    ///
    /// For example, an API may forbid `DELETE`-ing a resource.
    /// The two mandatory methods, GET and HEAD, must never be disabled and should not return this error code.
    case methodNotAllowed = 405

    /// This response is sent when the web server, after performing server-driven content negotiation,
    /// doesn't find any content following the criteria given by the user agent.
    ///
    /// For more information,
    /// see [server-driven content negotiation](https://developer.mozilla.org/en-US/docs/HTTP/Content_negotiation#Server-driven_negotiation).
    case notAcceptable = 406

    /// This is similar to 401 but authentication is needed to be done by a proxy.
    case proxyAuthenticationRequired = 407

    /// This response is sent on an idle connection by some servers, even without any previous request by the client.
    /// It means that the server would like to shut down this unused connection.
    ///
    /// This response is used much more since some browsers, like Chrome, Firefox 27+, or IE9,
    /// use HTTP pre-connection mechanisms to speed up surfing.
    /// Also note that some servers merely shut down the connection without sending this message.
    case requestTimeout = 408

    /// This response is sent when a request conflicts with the current state of the server.
    case conflict = 409

    /// This response would be sent when the requested content has been permanently deleted from server, with no forwarding address.
    ///
    /// Clients are expected to remove their caches and links to the resource.
    /// The HTTP specification intends this status code to be used for "limited-time, promotional services".
    /// APIs should not feel compelled to indicate resources that have been deleted with this status code.
    case gone = 410

    /// Server rejected the request because the Content-Length header field is not defined and the server requires it.
    case lengthRequired = 411

    /// The client has indicated preconditions in its headers which the server does not meet.
    case preconditionFailed = 412

    /// Request entity is larger than limits defined by server;
    /// the server might close the connection or return an Retry-After header field.
    case payloadTooLarge = 413

    /// The URI requested by the client is longer than the server is willing to interpret.
    case URITooLong = 414

    /// The media format of the requested data is not supported by the server, so the server is rejecting the request.
    case unsupportedMediaType = 415

    /// The range specified by the Range header field in the request can't be fulfilled;
    /// it's possible that the range is outside the size of the target URI's data.
    case rangeNotSatisfiable = 416

    /// The server cannot meet the requirements of the Expect request-header field.
    case expectationFailed = 417

    /// The server refuses the attempt to brew coffee with a teapot.
    ///
    /// This HTTP status is used as an Easter egg in some websites.
    case teapot = 418

    /// The request was directed at a server that is not able to produce a response.
    ///
    /// This can be sent by a server that is not configured to produce responses for the combination
    /// of scheme and authority that are included in the request URI.
    case misdirectedRequest = 421

    /// The request was well-formed but was unable to be followed due to semantic errors.
    case unprocessableEntity = 422

    /// The resource that is being accessed is locked.
    case locked = 423

    /// The request failed due to failure of a previous request.
    case failedDependency = 424

    /// Indicates that the server is unwilling to risk processing a request that might be replayed.
    case tooEarly = 425

    /// The server refuses to perform the request using the current protocol but might
    /// be willing to do so after the client upgrades to a different protocol.
    ///
    /// The server sends an Upgrade header in this response to indicate the required protocol(s).
    case upgradeRequired = 426

    /// The origin server requires the request to be conditional.
    ///
    /// Intended to prevent the 'lost update' problem, where a client `GET`s a resource's state, modifies it,
    /// and `PUT`s it back to the server, when meanwhile a third party has modified the state on the server, leading to a conflict.
    case preconditionRequired = 428

    /// The user has sent too many requests in a given amount of time.
    ///
    /// This error code is typically returned when a server is intentionally rate limiting requests.
    case tooManyRequests = 429

    /// The server is unwilling to process the request because its header fields are too large.
    ///
    /// The request _may_ be resubmitted after reducing the size of the request header fields.
    case requestHeaderFieldsTooLarge = 431

    /// The user requests an illegal resource, such as a web page censored by a government.
    case unavailableForLegalReasons = 451

    // MARK: 5xx - Server Errors

    /// A generic error message, given when an unexpected condition was encountered and no more specific message is suitable.
    case internalServerError = 500

    /// The server either does not recognize the request method, or it lacks the ability to fulfil the request.
    case notImplemented = 501

    /// The server was acting as a gateway or proxy and received an invalid response from the upstream server.
    case badGateway = 502

    /// The server cannot handle the request, typically because it is overloaded or down for maintenance. Generally, this is a temporary state.
    case serviceUnavailable = 503

    /// The server was acting as a gateway or proxy and did not receive a timely response from the upstream server.
    case gatewayTimeout = 504

    /// The server does not support the HTTP protocol version used in the request.
    case HTTPVersionNotSupported = 505

    /// Transparent content negotiation for the request results in a circular reference.
    case variantAlsoNegotiates = 506

    /// The server is unable to store the representation needed to complete the request.
    case insufficientStorage = 507

    /// The server detected an infinite loop while processing the request (sent instead of 208 Already Reported).
    case loopDetected = 508

    /// Further extensions to the request are required for the server to fulfil it.
    case notExtended = 510

    /// The client needs to authenticate to gain network access.
    ///
    /// Intended for use by intercepting proxies used to control access to the network
    /// (eg. "captive portals" used to require agreement to Terms of Service before granting full Internet access via a Wi-Fi hotspot).
    case networkAuthenticationRequired = 511

    // MARK: Undefined

    /// The client has encountered an undefined status code.
    ///
    /// In the event this is _ever_ returned by a service, look at the actual underlying
    /// status code of the HTTPURLResponse to identify the actual status code returned.
    case undefined = -1

    // MARK: Properties

    /// The category that the status code belongs to.
    public var responseType: ResponseType {
        switch self.rawValue {
        case 100 ..< 200:
            return .informational
        case 200 ..< 300:
            return .success
        case 300 ..< 400:
            return .redirection
        case 400 ..< 500:
            return .clientError
        case 500 ..< 600:
            return .serverError
        default:
            return .undefined
        }
    }
}
