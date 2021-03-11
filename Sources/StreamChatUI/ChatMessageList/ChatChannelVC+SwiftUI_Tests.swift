//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

@testable import StreamChat
import StreamChatTestTools
@testable import StreamChatUI
import SwiftUI
import XCTest

@available(iOS 13.0, *)
class ChatChannelVC_SwiftUI_Tests: iOS13TestCase {
    var chatChannel: ChatChannelView!

    static let mockedChannelController: ChatChannelController_Mock<NoExtraData> = ChatChannelController_Mock.mock()

    static let channel: ChatChannel = ChatChannel.mock(
        cid: .unique,
        name: "Channel",
        imageURL: TestImages.yoda.url,
        lastMessageAt: .init(timeIntervalSince1970: 1_611_951_526_000)
    )

    override func setUp() {
        super.setUp()
        chatChannel = ChatChannelVC.View(
            channelController: ChatChannelVC_SwiftUI_Tests.mockedChannelController
        )

        ChatChannelVC_SwiftUI_Tests.mockedChannelController.simulateInitial(
            channel: ChatChannelVC_SwiftUI_Tests.channel,
            messages: [
                ChatMessage.mock(
                    id: "2",
                    text: "Hello there!",
                    author: .mock(id: "Vader"),
                    createdAt: .init(timeIntervalSince1970: 1_611_951_528_000)
                ),
                ChatMessage.mock(
                    id: "1",
                    text: "What's up?",
                    author: .mock(id: "Vader2"),
                    createdAt: .init(timeIntervalSince1970: 1_611_951_527_000)
                )
            ],
            state: .localDataFetched
        )
    }

    func test_chatChannelList_isPopulated() {
        AssertSnapshot(chatChannel, isEmbeddedInNavigationController: true)
    }

    func test_customNavigationViewValues_arePopulated() {
        struct CustomChatChannelView: View {
            var body: some View {
                NavigationView {
                    ChatChannelVC.View(channelController: ChatChannelVC_SwiftUI_Tests.mockedChannelController)
                        .navigationBarItems(
                            leading:
                            Button("Leading") {},
                            trailing:
                            Button("Trailing") {}
                        )
                }
            }
        }

        let customView = CustomChatChannelView()
        AssertSnapshot(customView)
    }
}
