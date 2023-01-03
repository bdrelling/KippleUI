// Copyright © 2023 Brian Drelling. All rights reserved.

#if os(iOS) || os(macOS)

import SwiftUI
import UniformTypeIdentifiers

@available(macOS 11.0, iOS 14.0, *)
public struct ReorderableForEach<Content: View, Item: Hashable>: View {
    public typealias ContentBlock = (_ item: Item, _ index: Int, _ isDragging: Bool) -> Content

    @Binding private var items: [Item]
    @Binding private var isReorderable: Bool

    @State private var draggedItem: Item?
    @State private var hasChangedLocation: Bool = false

    public let content: ContentBlock

    public init(
        _ items: Binding<[Item]>,
        isReorderable: Binding<Bool>,
        @ViewBuilder content: @escaping ContentBlock
    ) {
        self._items = items
        self._isReorderable = isReorderable
        self.content = content
    }

    public init(
        _ items: Binding<[Item]>,
        isReorderable: Bool = true,
        @ViewBuilder content: @escaping ContentBlock
    ) {
        self.init(items, isReorderable: .constant(isReorderable), content: content)
    }

    public var body: some View {
        ForEach(self.items, id: \.self) { item in
            let index = self.items.firstIndex(of: item) ?? -1

            if self.isReorderable {
                let isDragging = self.draggedItem == item && self.hasChangedLocation
                self.content(item, index, isDragging)
                    .onDrag {
                        self.draggedItem = item
                        return NSItemProvider(object: "\(item.hashValue)" as NSString)
                    }
                    .onDrop(
                        of: [UTType.plainText],
                        delegate: DragRelocateDelegate(
                            item: item,
                            items: self.$items,
                            draggedItem: self.$draggedItem,
                            hasChangedLocation: self.$hasChangedLocation
                        )
                    )
            } else {
                self.content(item, index, false)
            }
        }
    }
}

// MARK: - Supporting Types

// References:
// - https://stackoverflow.com/questions/62606907/swiftui-using-ondrag-and-ondrop-to-reorder-items-within-one-single-lazygrid
// - https://stackoverflow.com/questions/72181072/swiftui-ondrop-overlay-not-going-away-in-lazyvgrid/72181964#72181964
// - https://stackoverflow.com/questions/72384177/swiftui-drag-and-drop-reorder-detect-object-release/72387161#72387161
// - https://stackoverflow.com/questions/72545702/swiftui-how-to-notice-that-drag-drop-finished-outside-view-app (no answers)
// - https://swiftuirecipes.com/blog/swiftui-drag-to-reorder-foreach-stack-grid
@available(macOS 11.0, iOS 14.0, *)
public struct DragRelocateDelegate<Item: Equatable>: DropDelegate {
    public let item: Item

    @Binding public var items: [Item]
    @Binding public var draggedItem: Item?
    @Binding public var hasChangedLocation: Bool

    public init(
        item: Item,
        items: Binding<[Item]>,
        draggedItem: Binding<Item?>,
        hasChangedLocation: Binding<Bool>
    ) {
        self.item = item
        self._items = items
        self._draggedItem = draggedItem
        self._hasChangedLocation = hasChangedLocation
    }

    public func dropEntered(info: DropInfo) {
        print("dropEntered \(info)")

        guard self.item != self.draggedItem, let draggedItem = self.draggedItem else {
            return
        }

        guard let from = self.items.firstIndex(of: draggedItem), let to = self.items.firstIndex(of: self.item) else {
            return
        }

        self.hasChangedLocation = true

        if self.items[to] != draggedItem {
            withAnimation {
                self.items.move(
                    fromOffsets: IndexSet(integer: from),
                    toOffset: to > from ? to + 1 : to
                )
            }
        }
    }

    public func dropUpdated(info: DropInfo) -> DropProposal? {
        print("dropUpdated \(info)")
        return .init(operation: .move)
    }

    public func dropExited(info: DropInfo) {
        print("dropExited \(info)")
    }

    public func performDrop(info: DropInfo) -> Bool {
        print("performDrop \(info)")

        self.hasChangedLocation = false
        self.draggedItem = nil
        return true
    }
}

#endif
