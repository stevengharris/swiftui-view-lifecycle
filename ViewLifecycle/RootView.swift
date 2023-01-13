import SwiftUI

struct RootView: View {
    @State private var columnVisibility: NavigationSplitViewVisibility = .doubleColumn

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            Sidebar()
        } detail: {
            Text("Select an item in the sidebar.")
        }
    }
}

struct Sidebar: View {
    @State private var selection: CaseStudy? = nil

    var body: some View {
        List {
            ForEach(categories) { section in
                Section {
                    ForEach(section.elements) { caseStudy in
                        NavigationLink(value: caseStudy.id) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(caseStudy.label)
                                    .lineLimit(nil)
                                if let description = caseStudy.description {
                                    Text(description)
                                        .font(.callout)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(nil)
                                }
                            }
                        }
                    }
                } header: {
                    Text(section.label)
                }
            }
        }
        .navigationTitle("SwiftUI View Lifecycle")
        #if !os(macOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .navigationDestination(for: CaseStudy.ID.self) { id in
            MainContent(caseStudyID: id)
        }
    }
}

struct MainContent: View {
    var caseStudyID: CaseStudy.ID

    var body: some View {
        switch caseStudyID {
        case .ifElse:
            CaseStudyIfElse()
        case .switch:
            CaseStudySwitch()
        case .id:
            CaseStudyIDModifier()
        case .opacity:
            CaseStudyOpacity()
        case .scrollViewStatic:
            CaseStudyScrollViewStatic()
        case .scrollViewDynamic:
            CaseStudyScrollViewDynamic()
        case .scrollViewReader:
            CaseStudyScrollViewReader()
        case .listDynamic:
            CaseStudyListDynamic()
        case .listStatic:
            CaseStudyListStatic()
        case .lazyVStack:
            CaseStudyLazyVStack()
        case .lazyVGrid:
            CaseStudyLazyVGrid()
        case .navigationStack:
            #if os(macOS)
                CaseStudyNavigationStackMac()
            #else
                CaseStudyNavigationStack()
            #endif
        case .tabView:
            CaseStudyTabView()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
