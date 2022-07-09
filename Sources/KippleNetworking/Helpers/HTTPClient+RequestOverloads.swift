// Copyright © 2022 Brian Drelling. All rights reserved.

// import Foundation

// public extension HTTPClient {
//     // MARK: Data Response

//     /// Creates and sends a request which fetches raw data from an endpoint.
//     /// - Parameter request: An object defining properties to make the request with.
//     /// - Parameter validators: An array of validators that will be applied to the response.
//     /// - Parameter interceptor: An object that can intercept the url request. Defaults to `nil`.
//     /// - Parameter dispatchQueue: The dispatch queue that the completion will be called on. Defaults to `.main`.
//     /// - Parameter completion: The completion block to call when the request is completed.
//     /// - Returns: The configured `Request` object that is performed upon execution of this method.
//     @discardableResult
//     func request(
//         _ request: URLRequestConvertible,
//         validators: [ResponseValidator] = [],
//         interceptor: RequestInterceptor? = nil,
//         dispatchQueue: DispatchQueue = .main,
//         completion: DataTaskCompletion? = nil
//     ) -> Request? {
//         var convertedRequest: URLRequest

//         do {
//             convertedRequest = try request.asURLRequest()
//         } catch {
//             dispatchQueue.async {
//                 completion?(.failure(error))
//             }
//             return nil
//         }

//         return self.request(
//             convertedRequest,
//             validators: validators,
//             interceptor: interceptor,
//             dispatchQueue: dispatchQueue,
//             completion: completion
//         )
//     }

//     /// Creates and sends a request which fetches raw data from an endpoint.
//     /// - Parameter url: The URL for the request. Accepts a URL or a String.
//     /// - Parameter method: The HTTP method for the request. Defaults to `GET`.
//     /// - Parameter parameters: The parameters to be converted into a String-keyed dictionary to send in the query string or HTTP body.
//     /// - Parameter headers: The HTTP headers to send with the request.
//     /// - Parameter encoding: The parameter encoding method. If nil, uses the default encoding for the provided HTTP method.
//     /// - Parameter validators: An array of validators that will be applied to the response.
//     /// - Parameter interceptor: An object that can intercept the url request. Defaults to `nil`.
//     /// - Parameter dispatchQueue: The dispatch queue that the completion will be called on. Defaults to `.main`.
//     /// - Parameter completion: The completion block to call when the request is completed.
//     /// - Returns: The configured `Request` object that is performed upon execution of this method.
//     @discardableResult
//     func request(
//         _ url: URLConvertible,
//         method: HTTPMethod = .get,
//         parameters: ParameterDictionaryConvertible? = nil,
//         headers: HTTPHeaderDictionaryConvertible? = nil,
//         encoding: ParameterEncoding? = nil,
//         validators: [ResponseValidator] = [],
//         interceptor: RequestInterceptor? = nil,
//         dispatchQueue: DispatchQueue = .main,
//         completion: DataTaskCompletion? = nil
//     ) -> Request? {
//         let request: URLRequest

//         do {
//             request = try .init(
//                 url: url,
//                 method: method,
//                 parameters: parameters,
//                 headers: headers,
//                 encoding: encoding
//             )
//         } catch {
//             dispatchQueue.async {
//                 completion?(.failure(error))
//             }
//             return nil
//         }

//         return self.request(
//             request,
//             validators: validators,
//             interceptor: interceptor,
//             dispatchQueue: dispatchQueue,
//             completion: completion
//         )
//     }

//     /// Creates and sends a request which fetches raw data from an endpoint.
//     /// - Parameter url: The URL for the request. Accepts a URL or a String.
//     /// - Parameter method: The HTTP method for the request. Defaults to `GET`.
//     /// - Parameter parameters: The `Encodable` object to be converted into a String-keyed dictionary to send in the query string or HTTP body.
//     /// - Parameter headers: The HTTP headers to send with the request.
//     /// - Parameter encoding: The parameter encoding method. If nil, uses the default encoding for the provided HTTP method.
//     /// - Parameter validators: An array of validators that will be applied to the response.
//     /// - Parameter interceptor: An object that can intercept the url request. Defaults to `nil`.
//     /// - Parameter dispatchQueue: The dispatch queue that the completion will be called on. Defaults to `.main`.
//     /// - Parameter completion: The completion block to call when the request is completed.
//     /// - Returns: The configured `Request` object that is performed upon execution of this method.
//     @discardableResult
//     // swiftlint:disable:next function_default_parameter_at_end
//     func request(
//         _ url: URLConvertible,
//         method: HTTPMethod = .get,
//         parameters: Encodable,
//         headers: HTTPHeaderDictionaryConvertible? = nil,
//         encoding: ParameterEncoding? = nil,
//         validators: [ResponseValidator] = [],
//         interceptor: RequestInterceptor? = nil,
//         dispatchQueue: DispatchQueue = .main,
//         completion: DataTaskCompletion? = nil
//     ) -> Request? {
//         self.request(
//             url,
//             method: method,
//             parameters: try? parameters.asDictionary(),
//             headers: headers,
//             encoding: encoding,
//             validators: validators,
//             interceptor: interceptor,
//             dispatchQueue: dispatchQueue,
//             completion: completion
//         )
//     }

//     // MARK: Decodable Object Response

//     /// Creates and sends a request which fetches raw data from an endpoint and decodes it.
//     /// - Parameter request: An object defining properties to make the request with.
//     /// - Parameter validators: An array of validators that will be applied to the response. Defaults to ensuring a JSON mime type on the response.
//     /// - Parameter interceptor: An object that can intercept the url request. Defaults to `nil`.
//     /// - Parameter dispatchQueue: The dispatch queue that the completion will be called on. Defaults to `.main`.
//     /// - Parameter decoder: The `JSONDecoder` to use when decoding the response data. Defaults to `JSONDecoder()`.
//     /// - Parameter completion: The completion block to call when the request is completed.
//     /// - Returns: The configured `Request` object that is performed upon execution of this method.
//     @discardableResult
//     func request<T: Decodable>(
//         _ request: URLRequestConvertible,
//         validators: [ResponseValidator] = [.ensureMimeType(.json)],
//         interceptor: RequestInterceptor? = nil,
//         dispatchQueue: DispatchQueue = .main,
//         decoder: JSONDecoder = .init(),
//         completion: DecodableTaskCompletion<T>? = nil
//     ) -> Request? {
//         var convertedRequest: URLRequest

//         do {
//             convertedRequest = try request.asURLRequest()
//         } catch {
//             dispatchQueue.async {
//                 completion?(.failure(error))
//             }
//             return nil
//         }

//         return self.request(
//             convertedRequest,
//             validators: validators,
//             interceptor: interceptor,
//             dispatchQueue: dispatchQueue,
//             decoder: decoder,
//             completion: completion
//         )
//     }

//     /// Creates and sends a request which fetches raw data from an endpoint and decodes it.
//     /// - Parameter url: The URL for the request. Accepts a URL or a String.
//     /// - Parameter method: The HTTP method for the request. Defaults to `GET`.
//     /// - Parameter parameters: The parameters to be converted into a String-keyed dictionary to send in the query string or HTTP body.
//     /// - Parameter headers: The HTTP headers to send with the request.
//     /// - Parameter encoding: The parameter encoding method. If nil, uses the default encoding for the provided HTTP method.
//     /// - Parameter validators: An array of validators that will be applied to the response. Defaults to ensuring a JSON mime type on the response.
//     /// - Parameter interceptor: An object that can intercept the url request. Defaults to `nil`.
//     /// - Parameter dispatchQueue: The dispatch queue that the completion will be called on. Defaults to `.main`.
//     /// - Parameter decoder: The `JSONDecoder` to use when decoding the response data. Defaults to `JSONDecoder()`.
//     /// - Parameter completion: The completion block to call when the request is completed.
//     /// - Returns: The configured `Request` object that is performed upon execution of this method.
//     @discardableResult
//     func request<T: Decodable>(
//         _ url: URLConvertible,
//         method: HTTPMethod = .get,
//         parameters: ParameterDictionaryConvertible? = nil,
//         headers: HTTPHeaderDictionaryConvertible? = nil,
//         encoding: ParameterEncoding? = nil,
//         validators: [ResponseValidator] = [.ensureMimeType(.json)],
//         interceptor: RequestInterceptor? = nil,
//         dispatchQueue: DispatchQueue = .main,
//         decoder: JSONDecoder = .init(),
//         completion: DecodableTaskCompletion<T>? = nil
//     ) -> Request? {
//         let request: URLRequest

//         do {
//             request = try .init(
//                 url: url,
//                 method: method,
//                 parameters: parameters,
//                 headers: headers,
//                 encoding: encoding
//             )
//         } catch {
//             dispatchQueue.async {
//                 completion?(.failure(error))
//             }
//             return nil
//         }

//         return self.request(
//             request,
//             validators: validators,
//             interceptor: interceptor,
//             dispatchQueue: dispatchQueue,
//             decoder: decoder,
//             completion: completion
//         )
//     }

//     /// Creates and sends a request which fetches raw data from an endpoint and decodes it.
//     /// - Parameter url: The URL for the request. Accepts a URL or a String.
//     /// - Parameter method: The HTTP method for the request. Defaults to `GET`.
//     /// - Parameter parameters: The `Encodable` object to be converted into a String-keyed dictionary to send in the query string or HTTP body.
//     /// - Parameter headers: The HTTP headers to send with the request.
//     /// - Parameter encoding: The parameter encoding method. If nil, uses the default encoding for the provided HTTP method.
//     /// - Parameter validators: An array of validators that will be applied to the response. Defaults to ensuring a JSON mime type on the response.
//     /// - Parameter interceptor: An object that can intercept the url request. Defaults to `nil`.
//     /// - Parameter dispatchQueue: The dispatch queue that the completion will be called on. Defaults to `.main`.
//     /// - Parameter decoder: The `JSONDecoder` to use when decoding the response data. Defaults to `JSONDecoder()`.
//     /// - Parameter completion: The completion block to call when the request is completed.
//     /// - Returns: The configured `Request` object that is performed upon execution of this method.
//     @discardableResult
//     // swiftlint:disable:next function_default_parameter_at_end
//     func request<T: Decodable>(
//         _ url: URLConvertible,
//         method: HTTPMethod = .get,
//         parameters: Encodable,
//         headers: HTTPHeaderDictionaryConvertible? = nil,
//         encoding: ParameterEncoding? = nil,
//         validators: [ResponseValidator] = [.ensureMimeType(.json)],
//         interceptor: RequestInterceptor? = nil,
//         dispatchQueue: DispatchQueue = .main,
//         decoder: JSONDecoder = .init(),
//         completion: DecodableTaskCompletion<T>? = nil
//     ) -> Request? {
//         self.request(
//             url,
//             method: method,
//             parameters: try? parameters.asDictionary(),
//             headers: headers,
//             encoding: encoding,
//             validators: validators,
//             interceptor: interceptor,
//             dispatchQueue: dispatchQueue,
//             decoder: decoder,
//             completion: completion
//         )
//     }
// }
