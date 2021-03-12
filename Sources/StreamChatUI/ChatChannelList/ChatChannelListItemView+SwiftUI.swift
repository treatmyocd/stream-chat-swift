//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import SwiftUI

// MARK: - Base implementation
@available(iOS 13.0, *)
public protocol BaseSwiftUIView: View {
    init()
}

@available(iOS 13.0, *)
struct WrappedSwiftUIView<Content: BaseSwiftUIView, DataSource: _View & ObservableObject>: View {
    let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
    
    var body: some View {
        Content().environmentObject(dataSource)
    }
}

@available(iOS 13.0, *)
public class BaseSwiftUIWrapper<Content: BaseSwiftUIView, DataSource: _View & ObservableObject>: _View {
    var hostingController: UIHostingController<WrappedSwiftUIView<Content, DataSource>>?
    
    let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
        
        super.init(frame: .zero)
    }
    
    // swiftlint:disable unavailable_function
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public var intrinsicContentSize: CGSize {
        hostingController?.view.intrinsicContentSize ?? super.intrinsicContentSize
    }

    override public func setUp() {
        super.setUp()

        let view = WrappedSwiftUIView<Content, DataSource>(dataSource: dataSource)
        hostingController = UIHostingController(rootView: view)
    }

    override public func setUpLayout() {
        embed(hostingController!.view)
    }
}

// MARK: - Wrapper implementation
@available(iOS 13.0, *)
extension _ChatChannelListItemView {
    public typealias SwiftUIView = BaseSwiftUIView

    public class DataSource: _ChatChannelListItemView<ExtraData>, ObservableObject
    {
        override public func updateContent() {
            objectWillChange.send()
        }
    }

    public class SwiftUIWrapper<Content: BaseSwiftUIView, ExtraData: ExtraDataTypes>: DataSource {
        var baseWrapper: BaseSwiftUIWrapper<Content, DataSource>?

        override public func setUp() {
            super.setUp()

            baseWrapper = BaseSwiftUIWrapper<Content, DataSource>(dataSource: self)
        }

        override public func setUpLayout() {
            embed(baseWrapper!)
        }
    }
}
