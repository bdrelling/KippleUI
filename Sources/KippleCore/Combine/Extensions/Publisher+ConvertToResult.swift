// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(Combine)

    import Combine

    public extension Publisher {
        func convertToResult() -> AnyPublisher<Result<Output, Failure>, Never> {
            self.map(Result.success)
                .catch { Just(.failure($0)) }
                .eraseToAnyPublisher()
        }
    }

#endif
