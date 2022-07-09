// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(SwiftUI)
    import SwiftUI

    public extension View {
        func subscribeToPublishers<T: PublisherSubscribing>(with subscriber: T) -> some View {
            self.onLoad(perform: subscriber.onAppear)
//            self.onAppear(perform: subscriber.onAppear)
                .onDisappear(perform: subscriber.onDisappear)
        }
    }
#endif
