//
//  CaseStudyScrollViewReader.swift
//  ViewLifecycle
//
//  Created by Steven Harris on 1/13/23.
//

import SwiftUI

struct CaseStudyScrollViewReader: View {
    private static let initialItemCount = 40
    @State private var items: [Item] = (1...Self.initialItemCount).map { i in
        Item(id: "Item \(i)")
    }
    @State private var nextID: Int = Self.initialItemCount + 1

    var body: some View {
        ScrollViewReader { proxy in
            List {
                ForEach(items) { item in
                    LifecycleMonitor(label: item.id)
                }
                .onDelete { offsets in
                    items.remove(atOffsets: offsets)
                }
            }
            .safeAreaInset(edge: .bottom) {
                Text("Embedding a `List` in a `ScrollViewReader` does not change the `List` behavior of recycling views during scrolling. `onAppear` gets called often, but `List` preserves the state for all list items. Use of the `proxy` to scroll doesn't impact the state preservation in the `List`.")
                    .font(.callout)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.regularMaterial)
            }
            .toolbar {
                ToolbarItem {
                    Button("Top") {
                        proxy.scrollTo(items[0].id)
                    }
                }
                ToolbarItem {
                    Button("Random") {
                        proxy.scrollTo(items[Int.random(in: 0..<items.count)].id)
                    }
                }
                ToolbarItem {
                    Button("Bottom") {
                        proxy.scrollTo(items[items.count - 1].id)
                    }
                }
                ToolbarItem {
                    Button("Prepend") {
                        let newItem = Item(id: "Item \(nextID)")
                        nextID += 1
                        items.insert(newItem, at: 0)
                    }
                }
                ToolbarItem {
                    Button("Append") {
                        let newItem = Item(id: "Item \(nextID)")
                        nextID += 1
                        items.append(newItem)
                    }
                }
            }
            .animation(.default, value: items)
            .navigationTitle("ScrollViewReader")
        }
    }
}

struct CaseStudyScrollViewReader_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CaseStudyListDynamic()
        }
    }
}
