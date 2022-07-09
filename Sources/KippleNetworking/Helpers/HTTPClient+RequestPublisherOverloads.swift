// Copyright © 2022 Brian Drelling. All rights reserved.

//// Copyright © 2022 Brian Drelling. All rights reserved.
//
// #if canImport(Combine)
//    import Combine
//    import Foundation
//
//    @available(iOS 13, macOS 10.15, tvOS 13.0, watchOS 6, *)
//    public extension HTTPClient {
//        // MARK: Data Response
//
//        /// Creates a request publisher which fetches raw data from an endpoint.
//        /// - Parameter request: An object defining properties to make the request with.
//        /// - Parameter validators: An array of validators that will be applied to the response.
//        /// - Parameter interceptor: An object that can intercept the url request. Defaults to `nil`.
//        /// - Parameter dispatchQueue: The dispatch queue on which the response will be published. Defaults to `.main`.
//        /// - Returns: A publisher that wraps a data task for the URL.
//        func requestPublisher(
//            _ request: URLRequestConvertible,
//            validators: [ResponseValidator] = [],
//            interceptor: RequestInterceptor? = nil,
//            dispatchQueue: DispatchQueue = .main
//        ) -> AnyPublisher<Data, Error> {
//            let convertedRequest: URLRequest
//
//            do {
//                convertedRequest = try request.asURLRequest()
//            } catch {
//                return Result<Data, Error>.Publisher(error).eraseToAnyPublisher()
//            }
//
//            return self.requestPublisher(
//                convertedRequest,
//                validators: validators,
//                interceptor: interceptor,
//                dispatchQueue: dispatchQueue
//            )
//        }
//
//        /// Creates a request publisher which fetches raw data from an endpoint.
//        /// - Parameter url: The URL for the request. Accepts a URL or a String.
//        /// - Parameter method: The HTTP method for the request. Defaults to `GET`.
//        /// - Parameter parameters: The parameters to be converted into a String-keyed dictionary to send in the query string or HTTP body.
//        /// - Parameter headers: The HTTP headers to send with the request.
//        /// - Parameter encoding: The parameter encoding method. If nil, uses the default encoding for the provided HTTP method.
//        /// - Parameter validators: An array of validators that will be applied to the response.
//        /// - Parameter interceptor: An object that can intercept the url request. Defaults to `nil`.
//        /// - Parameter dispatchQueue: The dispatch queue on which the response will be published. Defaults to `.main`.
//        /// - Returns: A publisher that wraps a data task for the URL.
//        func requestPublisher(
//            _ url: URLConvertible,
//            method: HTTPMethod = .get,
//            parameters: ParameterDictionaryConvertible? = nil,
//            headers: HTTPHeaderDictionaryConvertible? = nil,
//            encoding: ParameterEncoding? = nil,
//            validators: [ResponseValidator] = [],
//            interceptor: RequestInterceptor? = nil,
//            dispatchQueue: DispatchQueue = .main
//        ) -> AnyPublisher<Data, Error> {
//            let request: URLRequest
//
//            do {
//                request = try .init(
//                    url: url,
//                    method: method,
//                    parameters: parameters,
//                    headers: headers,
//                    encoding: encoding
//                )
//            } catch {
//                return Result<Data, Error>.Publisher(error)
//                    .receive(on: dispatchQueue)
//                    .eraseToAnyPublisher()
//            }
//
//            return self.requestPublisher(
//                request,
//                validators: validators,
//                interceptor: interceptor,
//                dispatchQueue: dispatchQueue
//            )
//        }
//
//        /// Creates a request publisher which fetches raw data from an endpoint.
//        /// - Parameter url: The URL for the request. Accepts a URL or a String.
//        /// - Parameter method: The HTTP method for the request. Defaults to `GET`.
//        /// - Parameter parameters: The `Encodable` object to be converted into a String-keyed dictionary to send in the query string or HTTP body.
//        /// - Parameter headers: The HTTP headers to send with the request.
//        /// - Parameter encoding: The parameter encoding method. If nil, uses the default encoding for the provided HTTP method.
//        /// - Parameter validators: An array of validators that will be applied to the response.
//        /// - Parameter interceptor: An object that can intercept the url request. Defaults to `nil`.
//        /// - Parameter dispatchQueue: The dispatch queue on which the response will be published. Defaults to `.main`.
//        /// - Returns: A publisher that wraps a data task for the URL.
//        // swiftlint:disable:next function_default_parameter_at_end
//        func requestPublisher(
//            _ url: URLConvertible,
//            method: HTTPMethod = .get,
//            parameters: Encodable,
//            headers: HTTPHeaderDictionaryConvertible? = nil,
//            encoding: ParameterEncoding? = nil,
//            validators: [ResponseValidator] = [],
//            interceptor: RequestInterceptor? = nil,
//            dispatchQueue: DispatchQueue = .main
//        ) -> AnyPublisher<Data, Error> {
//            return self.requestPublisher(
//                url,
//                method: method,
//                parameters: try? parameters.asDictionary(),
//                headers: headers,
//                encoding: encoding,
//                validators: validators,
//                interceptor: interceptor,
//                dispatchQueue: dispatchQueue
//            )
//        }
//
//        // MARK: Decodable Object Response
//
//        /// Creates a request publisher which fetches raw data from an endpoint and decodes it.
//        /// - Parameter request: The `URLRequest` to make the request with.
//        /// - Parameter validators: An array of validators that will be applied to the response. Defaults to ensuring a JSON mime type.
//        /// - Parameter interceptor: An object that can intercept the url request. Defaults to `nil`.
//        /// - Parameter dispatchQueue: The dispatch queue on which the response will be published. Defaults to `.main`.
//        /// - Parameter decoder: The `JSONDecoder` to use when decoding the response data. Defaults to `JSONDecoder()`.
//        /// - Returns: A publisher that wraps a data task for the URL.
//        func requestPublisher<T: Decodable>(
//            _ request: URLRequestConvertible,
//            validators: [ResponseValidator] = [.ensureMimeType(.json)],
//            interceptor: RequestInterceptor? = nil,
//            dispatchQueue: DispatchQueue = .main,
//            decoder: JSONDecoder = .init()
//        ) -> AnyPublisher<T, Error> {
//            let convertedRequest: URLRequest
//
//            do {
//                convertedRequest = try request.asURLRequest()
//            } catch {
//                return Result<T, Error>.Publisher(error).eraseToAnyPublisher()
//            }
//
//            return self.requestPublisher(
//                convertedRequest,
//                validators: validators,
//                interceptor: interceptor,
//                dispatchQueue: dispatchQueue,
//                decoder: decoder
//            )
//        }
//
//        /// Creates a request publisher which fetches raw data from an endpoint and decodes it.
//        /// - Parameter url: The URL for the request. Accepts a URL or a String.
//        /// - Parameter method: The HTTP method for the request. Defaults to `GET`.
//        /// - Parameter parameters: The parameters to be converted into a String-keyed dictionary to send in the query string or HTTP body.
//        /// - Parameter headers: The HTTP headers to send with the request.
//        /// - Parameter encoding: The parameter encoding method. If nil, uses the default encoding for the provided HTTP method.
//        /// - Parameter validators: An array of validators that will be applied to the response. Defaults to ensuring a JSON mime type.
//        /// - Parameter interceptor: An object that can intercept the url request. Defaults to `nil`.
//        /// - Parameter dispatchQueue: The dispatch queue on which the response will be published. Defaults to `.main`.
//        /// - Parameter decoder: The `JSONDecoder` to use when decoding the response data. Defaults to `JSONDecoder()`.
//        /// - Returns: A publisher that wraps a data task for the URL.
//        func requestPublisher<T: Decodable>(
//            _ url: URLConvertible,
//            method: HTTPMethod = .get,
//            parameters: ParameterDictionaryConvertible? = nil,
//            headers: HTTPHeaderDictionaryConvertible? = nil,
//            encoding: ParameterEncoding? = nil,
//            validators: [ResponseValidator] = [.ensureMimeType(.json)],
//            interceptor: RequestInterceptor? = nil,
//            dispatchQueue: DispatchQueue = .main,
//            decoder: JSONDecoder = .init()
//        ) -> AnyPublisher<T, Error> {
//            let request: URLRequest
//
//            do {
//                request = try .init(
//                    url: url,
//                    method: method,
//                    parameters: parameters,
//                    headers: headers,
//                    encoding: encoding
//                )
//            } catch {
//                return Result<T, Error>.Publisher(error)
//                    .receive(on: dispatchQueue)
//                    .eraseToAnyPublisher()
//            }
//
//            return self.requestPublisher(
//                request,
//                validators: validators,
//                interceptor: interceptor,
//                dispatchQueue: dispatchQueue,
//                decoder: decoder
//            )
//        }
//
//        /// Creates a request publisher which fetches raw data from an endpoint and decodes it.
//        /// - Parameter url: The URL for the request. Accepts a URL or a String.
//        /// - Parameter method: The HTTP method for the request. Defaults to `GET`.
//        /// - Parameter parameters: The `Encodable` object to be converted into a String-keyed dictionary to send in the query string or HTTP body.
//        /// - Parameter headers: The HTTP headers to send with the request.
//        /// - Parameter encoding: The parameter encoding method. If nil, uses the default encoding for the provided HTTP method.
//        /// - Parameter validators: An array of validators that will be applied to the response. Defaults to ensuring a JSON mime type.
//        /// - Parameter interceptor: An object that can intercept the url request. Defaults to `nil`.
//        /// - Parameter dispatchQueue: The dispatch queue on which the response will be published. Defaults to `.main`.
//        /// - Parameter decoder: The `JSONDecoder` to use when decoding the response data. Defaults to `JSONDecoder()`.
//        /// - Returns: A publisher that wraps a data task for the URL.
//        // swiftlint:disable:next function_default_parameter_at_end
//        func requestPublisher<T: Decodable>(
//            _ url: URLConvertible,
//            method: HTTPMethod = .get,
//            parameters: Encodable,
//            headers: HTTPHeaderDictionaryConvertible? = nil,
//            encoding: ParameterEncoding? = nil,
//            validators: [ResponseValidator] = [.ensureMimeType(.json)],
//            interceptor: RequestInterceptor? = nil,
//            dispatchQueue: DispatchQueue = .main,
//            decoder: JSONDecoder = .init()
//        ) -> AnyPublisher<T, Error> {
//            return self.requestPublisher(
//                url,
//                method: method,
//                parameters: try? parameters.asDictionary(),
//                headers: headers,
//                encoding: encoding,
//                validators: validators,
//                interceptor: interceptor,
//                dispatchQueue: dispatchQueue,
//                decoder: decoder
//            )
//        }
//    }
//
// #endif
