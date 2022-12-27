// Copyright © 2022 Brian Drelling. All rights reserved.

#if os(iOS) || os(macOS)

import SwiftUI
import UniformTypeIdentifiers

@available(macOS 11.0, iOS 14.0, *)
struct ReorderableForEach<Content: View, Placeholder: View, Item: Identifiable & Equatable>: View {
    typealias ContentBlock = (_ item: Item, _ index: Int, _ isDragging: Bool) -> Content

    let content: ContentBlock

    @Binding var items: [Item]

    // A little hack that is needed in order to make view back opaque
    // if the drag and drop hasn't ever changed the position
    // Without this hack the item remains semi-transparent
    @State private var hasChangedLocation: Bool = false

    @State private var draggingItem: Item?

    init(
        _ items: Binding<[Item]>,
        @ViewBuilder content: @escaping ContentBlock
    ) {
        self._items = items
        self.content = content
    }

    var body: some View {
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
                        listData: self.items,
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

// MARK: - Convenience

@available(macOS 11.0, iOS 14.0, *)
extension ReorderableForEach where Placeholder == EmptyView {
    init(
        _ items: Binding<[Item]>,
        @ViewBuilder content: @escaping ContentBlock
    ) {
        self._items = items
        self.content = content
    }
}

// MARK: - Supporting Types

@available(macOS 11.0, iOS 14.0, *)
private struct DragRelocateDelegate<Item: Equatable>: DropDelegate {
    let item: Item
    var listData: [Item]

    @Binding var draggingItem: Item?
    @Binding var hasChangedLocation: Bool

    let moveAction: (IndexSet, Int) -> Void

    func dropEntered(info: DropInfo) {
        guard let draggingItem = self.draggingItem, self.item != self.draggingItem else { return }
        guard let from = self.listData.firstIndex(of: draggingItem), let to = self.listData.firstIndex(of: self.item) else { return }

        self.hasChangedLocation = true

        if self.listData[to] != draggingItem {
            self.moveAction(IndexSet(integer: from), to > from ? to + 1 : to)
        }
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        self.hasChangedLocation = false
        self.draggingItem = nil
        return true
    }
}

#endif
