// Copyright © 2022 Brian Drelling. All rights reserved.

#if os(iOS) || os(macOS)

import SwiftUI
import UniformTypeIdentifiers

@available(macOS 11.0, iOS 14.0, *)
struct ReorderableForEach<Content: View, Placeholder: View, Item: Identifiable & Equatable>: View {
    typealias ContentBlock = (Item, Int) -> Content
    typealias PlaceholderBlock = (Item, Int) -> Placeholder

    let items: [Item]
    let content: ContentBlock
    let placeholder: PlaceholderBlock?
    let moveAction: (IndexSet, Int) -> Void

    // A little hack that is needed in order to make view back opaque
    // if the drag and drop hasn't ever changed the position
    // Without this hack the item remains semi-transparent
    @State private var hasChangedLocation: Bool = false

    @State private var draggingItem: Item?

    init(
        _ items: [Item],
        @ViewBuilder content: @escaping ContentBlock,
        @ViewBuilder placeholder: @escaping PlaceholderBlock,
        moveAction: @escaping (IndexSet, Int) -> Void
    ) {
        self.items = items
        self.content = content
        self.placeholder = placeholder
        self.moveAction = moveAction
    }

    var body: some View {
        ForEach(self.items.indices, id: \.self) { index in
            let item = self.items[index]
            let isDragging = self.draggingItem == item && self.hasChangedLocation

            Group {
                if isDragging {
                    // If a placeholder was provided, use it,
                    // otherwise just re-use the content view and make it translucent.
                    if let placeholder = self.placeholder {
                        placeholder(item, index)
                    } else {
                        self.content(item, index).opacity(0.35)
                    }
                } else {
                    self.content(item, index)
                }
            }
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
                        moveAction(from, to)
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
        _ items: [Item],
        @ViewBuilder content: @escaping ContentBlock,
        moveAction: @escaping (IndexSet, Int) -> Void
    ) {
        self.items = items
        self.content = content
        self.placeholder = nil
        self.moveAction = moveAction
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
