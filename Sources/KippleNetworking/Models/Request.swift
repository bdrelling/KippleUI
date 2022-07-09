// Copyright © 2022 Brian Drelling. All rights reserved.

//// Copyright © 2022 Brian Drelling. All rights reserved.
//
// import Foundation
//
// public final class Request {
//    // MARK: Properties
//
//    /// The session in which the request will be made.
//    private let session: URLSession
//
//    /// The current session task.
//    public private(set) var task: URLSessionTask?
//
//    /// The block to call when the request has completed.
//    private let completion: DataTaskCompletion?
//
//    /// The dispatch queue that the completion will be called on.
//    private let dispatchQueue: DispatchQueue
//
//    /// The number of request retries that have been attempted.
//    public private(set) var retryCount = 0
//
//    /// Whether or not the `Request` is running.
//    ///
//    /// This may differ from the state of the underlying `URLSessionTask`. A
//    /// `Request` is considered "running" if the underlying task has not yet been
//    /// sent to the server but the `Request` is being adapted by a `RequestInterceptor`,
//    /// or if the underlying task has completed but the `RequestInterceptor` is processing
//    /// the result to determine if a retry should be initiated.
//    public private(set) var isRunning = false
//
//    private enum RequestedState {
//        case cancel
//        case suspend
//    }
//
//    /// A state that was requested prior to a task being initialized.
//    private var requestedState: RequestedState?
//
//    // MARK: Initialization
//
//    /// Create a new instance of a `Request`.
//    /// - Parameters:
//    ///   - session: The session in which the request will be made.
//    ///   - dispatchQueue: The dispatch queue that the completion will be called on. Defaults to `.main`.
//    ///   - completion: The block to call when the request has completed. Defaults to `nil`.
//    public init(session: URLSession,
//                dispatchQueue: DispatchQueue = .main,
//                completion: DataTaskCompletion? = nil) {
//        self.session = session
//        self.dispatchQueue = dispatchQueue
//        self.completion = completion
//    }
//
//    // MARK: Starting a Request
//
//    /// Performs any necessary request adaptation then creates and resumes a `URLSessionTask`.
//    /// - Parameter urlRequest: The request to be sent to the server.
//    func perform(urlRequest: URLRequest) {
//        self.isRunning = true
//
//            // Otherwise, create and resume the task.
//            self.createAndResumeSessionTask(with: urlRequest)
//    }
//
//    /// Creates a new `URLSessionTask` from the given `URLRequest` and resumes the task.
//    /// - Parameter urlRequest: The request to be sent to the server.
//    private func createAndResumeSessionTask(with urlRequest: URLRequest) {
//        let wrappedCompletion: HTTPSessionDelegateCompletion = { data, response, error in
//            self.processCompletedTask(urlRequest: urlRequest,
//                                      data: data,
//                                      urlResponse: response,
//                                      error: error)
//        }
//
//        let task: URLSessionTask
//        // When a background request is made, it must use a delegate
//        // and be a download or upload task. Using a data task will fail
//        // and using a completion will cause an assertion failure.
//        if let delegate = self.session.delegate as? HTTPSessionDelegate {
//            delegate.completion = wrappedCompletion
//            task = self.session.downloadTask(with: urlRequest)
//        } else {
//            task = self.session.dataTask(with: urlRequest, completionHandler: wrappedCompletion)
//        }
//
//        self.task = task
//
//        switch self.requestedState {
//        case .cancel:
//            // A cancellation was requested prior to creating the task.
//            task.cancel()
//        case .suspend:
//            // The task starts in a suspended state, just return.
//            return
//        case .none:
//            // There was no requested state prior to making the task, continue with resuming the task.
//            task.resume()
//        }
//    }
//
//    // MARK: Updating State
//
//    /// Resumes the current task.
//    public func resume() {
//        self.task?.resume()
//    }
//
//    /// Cancels the current task.
//    public func cancel() {
//        if let task = self.task, task.state != .completed {
//            // If we have a stored task and its not completed, cancel it.
//            task.cancel()
//        } else {
//            // Otherwise, store the requested state so we can apply it when the task is created.
//            self.requestedState = .cancel
//        }
//    }
//
//    /// Suspends the current task.
//    public func suspend() {
//        if let task = self.task, task.state != .completed {
//            // If we have a stored task and its not completed, suspend it.
//            task.suspend()
//        } else {
//            // Otherwise, store the requested state so we can apply it when the task is created.
//            self.requestedState = .suspend
//        }
//    }
//
//    // MARK: Response Handling
//
//    /// Processes the result of a completed `URLSessionTask`.
//    /// - Parameters:
//    ///   - urlRequest: The request that was sent to the server.
//    ///   - data: The data returned from the `URLSessionTask`.
//    ///   - urlResponse: The response returned from the `URLSessionTask`.
//    ///   - error: The error returned from the `URLSessionTask`.
//    private func processCompletedTask(urlRequest: URLRequest,
//                                      data: Data?,
//                                      urlResponse: URLResponse?,
//                                      error: Error?) {
//        HTTPClient.shared.log("Request finished.")
//
//        if let urlResponse = urlResponse {
//            HTTPClient.shared.log("[Response] \(urlResponse)")
//        }
//
//        // Convert the URLResponse into an HTTPURLResponse object.
//        // If it cannot be converted, use the undefined HTTPURLResponse object
//        let httpResponse = urlResponse as? HTTPURLResponse
//
//        // Create a result object for improved handling of the response
//        let result: Result<Data, Error> = {
//            if let response = httpResponse {
//                do {
//                    for validator in validators {
//                        try validator.validate(response: response)
//                    }
//                } catch {
//                    return .failure(error)
//                }
//            }
//            if let data = data {
//                return .success(data)
//            } else if let error = error {
//                return .failure(error)
//            } else {
//                return .failure(NetworkingError.unexpectedError)
//            }
//        }()
//
//        switch result {
//        case let .success(data):
//            HTTPClient.shared.log("Response succeeded.")
//
//            // Attempt to get the data as pretty printed JSON, otherwise just encode to utf8
//            if let dataString: String = data.asPrettyPrintedJSON ?? String(data: data, encoding: .utf8) {
//                HTTPClient.shared.log(dataString)
//            }
//
//            self.completeRequest(urlRequest: urlRequest,
//                                 urlResponse: httpResponse,
//                                 data: data,
//                                 result: result)
//        case let .failure(error):
//            HTTPClient.shared.log("Response failed. Error: \(error.localizedDescription)")
//
//            if let interceptor = self.interceptor {
//                interceptor.retry(self, dueTo: error) { shouldRetry in
//                    if shouldRetry {
//                        // If we should retry, bump the retry count and perform the request again.
//                        self.retryCount += 1
//                        self.perform(urlRequest: urlRequest)
//                    } else {
//                        // Otherwise, complete the request.
//                        self.completeRequest(urlRequest: urlRequest,
//                                             urlResponse: httpResponse,
//                                             data: data,
//                                             result: result)
//                    }
//                }
//            } else {
//                self.completeRequest(urlRequest: urlRequest,
//                                     urlResponse: httpResponse,
//                                     data: data,
//                                     result: result)
//            }
//        }
//    }
//
//    /// Completes the request by creating a `DataResponse` object and calling the
//    /// stored `DataTaskCompletion` block.
//    /// - Parameters:
//    ///   - urlRequest: The request that was sent to the server.
//    ///   - urlResponse: The response returned from the `URLSessionTask`.
//    ///   - data: The data returned from the `URLSessionTask`.
//    ///   - result: A `Result` object that can be used to handle the response.
//    private func completeRequest(urlRequest: URLRequest,
//                                 urlResponse: HTTPURLResponse?,
//                                 data: Data?,
//                                 result: Result<Data, Error>) {
//        self.isRunning = false
//
//        // Create the DataResponse object containing all necessary information from the response
//        let dataResponse = DataResponse(request: urlRequest,
//                                        response: urlResponse,
//                                        data: data,
//                                        result: result)
//
//        self.dispatchQueue.async {
//            // Fire the completion!
//            self.completion?(dataResponse)
//        }
//    }
// }
