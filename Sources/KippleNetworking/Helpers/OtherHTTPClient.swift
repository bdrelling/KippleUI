// Copyright © 2022 Brian Drelling. All rights reserved.

// import Foundation

// /// A completion handler for requests that return raw data results.
// public typealias DataTaskCompletion = DecodableTaskCompletion<Data>

// /// A completion handler for requests that return decoded object results.
// public typealias DecodableTaskCompletion<T: Decodable> = (DataResponse<T, Error>) -> Void

// /// A lightweight HTTP Client that supports data tasks
// public class HTTPClient {
//     // MARK: - Shared Instance

//     /// The shared HTTP Client instance.
//     public static let shared = HTTPClient()

//     // MARK: - Properties

//     /// The URLSession that is used for all requests.
//     let session: URLSession

//     /// Whether or not the client should be logging requests. Defaults to `false`.
//     public var isDebugLoggingEnabled = false

//     /// The timeout interval to use when waiting for additional data. When the request timer reaches the specified interval without receiving
//     /// any new data, it triggers a timeout. If this property is set to `nil`, this property is ignored and the default value of 60 seconds is used.
//     ///
//     /// The value can be overridden by the session configuration if the session configuration `timeoutIntervalForRequest` property is
//     /// set to be more restrictive. https://stackoverflow.com/a/54806389
//     public var timeoutInterval: TimeInterval?

//     // MARK: - Methods

//     // MARK: Initializers

//     /// Initializes a new HTTPClient with a given URLSession.
//     /// - Parameter session: The URLSession to use for all requests.
//     public init(session: URLSession = .shared) {
//         self.session = session
//     }

//     // MARK: Data Response

//     /// Creates and sends a request which fetches raw data from an endpoint.
//     /// - Parameter request: The `URLRequest` to make the request with.
//     /// - Parameter validators: An array of validators that will be applied to the response.
//     /// - Parameter interceptor: An object that can intercept the url request. Defaults to `nil`.
//     /// - Parameter dispatchQueue: The dispatch queue that the completion will be called on. Defaults to `.main`.
//     /// - Parameter completion: The completion block to call when the request is completed.
//     /// - Returns: The configured `Request` object that is performed upon execution of this method.
//     @discardableResult
//     public func request(
//         _ request: URLRequest,
//         validators: [ResponseValidator] = [],
//         interceptor: RequestInterceptor? = nil,
//         dispatchQueue: DispatchQueue = .main,
//         completion: DataTaskCompletion? = nil
//     ) -> Request? {
//         self.logStart(of: request)

//         // Get a modified request with a given timeout interval.
//         let urlRequest = request.withTimeout(self.timeoutInterval)

//         let request = Request(session: self.session,
//                               validators: validators,
//                               interceptor: interceptor,
//                               dispatchQueue: dispatchQueue,
//                               completion: completion)

//         // Perform the request.
//         request.perform(urlRequest: urlRequest)

//         return request
//     }

//     // MARK: Decodable Object Response

//     /// Creates and sends a request which fetches raw data from an endpoint and decodes it.
//     /// - Parameter request: The `URLRequest` to make the request with.
//     /// - Parameter validators: An array of validators that will be applied to the response. Defaults to ensuring a JSON mime type on the response.
//     /// - Parameter interceptor: An object that can intercept the url request. Defaults to `nil`.
//     /// - Parameter dispatchQueue: The dispatch queue that the completion will be called on. Defaults to `.main`.
//     /// - Parameter decoder: The `JSONDecoder` to use when decoding the response data. Defaults to `JSONDecoder()`.
//     /// - Parameter completion: The completion block to call when the request is completed.
//     /// - Returns: The configured `Request` object that is performed upon execution of this method.
//     @discardableResult
//     public func request<T: Decodable>(
//         _ request: URLRequest,
//         validators: [ResponseValidator] = [.ensureMimeType(.json)],
//         interceptor: RequestInterceptor? = nil,
//         dispatchQueue: DispatchQueue = .main,
//         decoder: JSONDecoder = .init(),
//         completion: DecodableTaskCompletion<T>? = nil
//     ) -> Request? {
//         return self.request(
//             request,
//             validators: validators,
//             interceptor: interceptor,
//             dispatchQueue: dispatchQueue
//         ) { dataResponse in
//             // Create a result object for improved handling of the response
//             let result: Result<T, Error> = {
//                 switch dataResponse.result {
//                 case let .success(data) where T.self == Data.self:
//                     // If T is Data, we have nothing to decode, so just return it as-is!
//                     if let data = data as? T {
//                         return .success(data)
//                     } else {
//                         return .failure(NetworkingError.unableToDecode(String(describing: T.self), nil))
//                     }
//                 case let .success(data):
//                     do {
//                         let decodedObject = try decoder.decode(T.self, from: data)
//                         return .success(decodedObject)
//                     } catch let error as DecodingError {
//                         return .failure(NetworkingError.unableToDecode(String(describing: T.self), error))
//                     } catch {
//                         return .failure(NetworkingError.unableToDecode(String(describing: T.self), nil))
//                     }
//                 case let .failure(error):
//                     return .failure(error)
//                 }
//             }()

//             // Create the DataResponse object containing all necessary information from the response
//             let response = DataResponse(request: dataResponse.request,
//                                         response: dataResponse.response,
//                                         data: dataResponse.data,
//                                         result: result)

//             // Fire the completion!
//             completion?(response)
//         }
//     }

//     func log(_ message: Any) {
//         guard self.isDebugLoggingEnabled else {
//             return
//         }

//         print("[UtilityBeltNetworking] \(message)")
//     }

//     func logStart(of request: URLRequest) {
//         if self.isDebugLoggingEnabled, let urlString = request.url?.absoluteString {
//             self.log("Starting request to \(urlString): \(request)")
//         }
//     }
// }
