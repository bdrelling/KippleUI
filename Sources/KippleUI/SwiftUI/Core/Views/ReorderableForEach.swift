// Copyright © 2022 Brian Drelling. All rights reserved.

#if os(iOS) || os(macOS)

import SwiftUI
import UniformTypeIdentifiers

@available(macOS 11.0, iOS 14.0, *)
public struct ReorderableForEach<Content: View, Item: Identifiable & Equatable>: View {
    public typealias ContentBlock = (_ item: Item, _ index: Int, _ isDragging: Bool) -> Content

    public let content: ContentBlock

    @Binding public var items: [Item]

    // A little hack that is needed in order to make view back opaque
    // if the drag and drop hasn't ever changed the position
    // Without this hack the item remains semi-transparent
    @State private var hasChangedLocation: Bool = false

    @State private var draggingItem: Item?

    public init(
        _ items: Binding<[Item]>,
        @ViewBuilder content: @escaping ContentBlock
    ) {
        self._items = items
        self.content = content
    }

    public var body: some View {
        ForEach(self.items.indices, id: \.self) { index in
            let item = self.items[index]
            let isDragging = self.draggingItem == item && self.hasChangedLocation

            self.content(item, index, isDragging)
                .onDrag {
                    self.draggingItem = item
                    return NSItemProvider(object: "\(item.id)" as NSString)
                }
                .onDrop(
                    of: [UTType.text],
                    delegate: DragRelocateDelegate(
                        item: item,
                        items: self.items,
                        draggingItem: self.$draggingItem,
                        hasChangedLocation: self.$hasChangedLocation
                    ) { from, to in
                        withAnimation {
                            self.items.move(fromOffsets: from, toOffset: to)
                        }
                    }
                )
        }
    }
}

// MARK: - Supporting Types

@available(macOS 11.0, iOS 14.0, *)
public struct DragRelocateDelegate<Item: Equatable>: DropDelegate {
    public let item: Item
    public var items: [Item]

    @Binding public var draggingItem: Item?
    @Binding public var hasChangedLocation: Bool

    public let moveAction: (IndexSet, Int) -> Void

    public init(
        item: Item,
        items: [Item],
        draggingItem: Binding<Item?>,
        hasChangedLocation: Binding<Bool>,
        moveAction: @escaping (IndexSet, Int) -> Void
    ) {
        self.item = item
        self.items = items
        self._draggingItem = draggingItem
        self._hasChangedLocation = hasChangedLocation
        self.moveAction = moveAction
    }

    public func dropEntered(info: DropInfo) {
        guard let draggingItem = self.draggingItem, self.item != self.draggingItem else { return }
        guard let from = self.items.firstIndex(of: draggingItem), let to = self.items.firstIndex(of: self.item) else { return }

        self.hasChangedLocation = true

        if self.items[to] != draggingItem {
            self.moveAction(IndexSet(integer: from), to > from ? to + 1 : to)
        }
    }

    public func dropUpdated(info: DropInfo) -> DropProposal? {
        DropProposal(operation: .move)
    }

    public func performDrop(info: DropInfo) -> Bool {
        self.hasChangedLocation = false
        self.draggingItem = nil
        return true
    }
}

#endif
