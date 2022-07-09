// Copyright © 2022 Brian Drelling. All rights reserved.

// #if canImport(Combine)
//     import Combine
//     import Foundation

//     @available(iOS 13, macOS 10.15, tvOS 13.0, watchOS 6, *)
//     public extension HTTPClient {
//         // MARK: Data Response

//         /// Creates a request publisher which fetches raw data from an endpoint.
//         /// - Parameter request: The `URLRequest` to make the request with.
//         /// - Parameter validators: An array of validators that will be applied to the response.
//         /// - Parameter interceptor: An object that can intercept the url request. Defaults to `nil`.
//         /// - Parameter dispatchQueue: The dispatch queue on which the response will be published. Defaults to `.main`.
//         /// - Returns: A publisher that wraps a data task for the URL.
//         func requestPublisher(
//             _ request: URLRequest,
//             validators: [ResponseValidator] = [],
//             interceptor: RequestInterceptor? = nil,
//             dispatchQueue: DispatchQueue = .main
//         ) -> AnyPublisher<Data, Error> {
//             self.logStart(of: request)

//             // Get a modified request with a given timeout interval.
//             let request = request.withTimeout(self.timeoutInterval)

//             return self.session
//                 .dataTaskPublisher(for: request)
//                 .tryMap { data, response -> Data in
//                     self.log("Request finished.")

//                     self.log("[Response] \(response)")

//                     if let httpResponse = response as? HTTPURLResponse {
//                         for validator in validators {
//                             try validator.validate(response: httpResponse)
//                         }
//                     }

//                     // Attempt to lob the data as pretty printed JSON, otherwise just encode to utf8
//                     if self.isDebugLoggingEnabled,
//                        let dataString: String = data.asPrettyPrintedJSON ?? String(data: data, encoding: .utf8) {
//                         self.log(dataString)
//                     }

//                     return data
//                 }
//                 .receive(on: dispatchQueue)
//                 .eraseToAnyPublisher()
//         }

//         // MARK: Decodable Object Response

//         /// Creates a request publisher which fetches raw data from an endpoint and decodes it.
//         /// - Parameter request: The `URLRequest` to make the request with.
//         /// - Parameter validators: An array of validators that will be applied to the response. Defaults to ensuring a JSON mime type.
//         /// - Parameter interceptor: An object that can intercept the url request. Defaults to `nil`.
//         /// - Parameter dispatchQueue: The dispatch queue on which the response will be published. Defaults to `.main`.
//         /// - Parameter decoder: The `JSONDecoder` to use when decoding the response data. Defaults to `JSONDecoder()`.
//         /// - Returns: A publisher that wraps a data task for the URL.
//         func requestPublisher<T: Decodable>(
//             _ request: URLRequest,
//             validators: [ResponseValidator] = [.ensureMimeType(.json)],
//             interceptor: RequestInterceptor? = nil,
//             dispatchQueue: DispatchQueue = .main,
//             decoder: JSONDecoder = .init()
//         ) -> AnyPublisher<T, Error> {
//             return self.requestPublisher(
//                 request,
//                 validators: validators,
//                 interceptor: interceptor,
//                 dispatchQueue: dispatchQueue
//             )
//             .decode(type: T.self, decoder: decoder)
//             .mapError { error in
//                 switch error {
//                 case let error as DecodingError:
//                     return NetworkingError.unableToDecode(String(describing: T.self), error)
//                 default:
//                     return error
//                 }
//             }
//             .eraseToAnyPublisher()
//         }
//     }
// #endif
