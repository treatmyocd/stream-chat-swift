//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

@testable import StreamChat
@testable import StreamChatUI
import XCTest

class ChatMessageComposerVC_Tests: XCTestCase {
    let defaultSize = CGSize(width: 360, height: 80)

    func test_emptyAppearance() {
        let vcInitial = ChatMessageComposerVC()
        vcInitial.state = .initial
        AssertSnapshot(vcInitial, screenSize: defaultSize)

        let mockedMessage = ChatMessage.mock(id: .unique, text: "", author: .mock(id: .unique))

        let vcEdit = ChatMessageComposerVC()
        vcEdit.state = .edit(mockedMessage)
        AssertSnapshot(vcEdit, screenSize: CGSize(width: 360, height: 130), suffix: "edit")

        let vcQuote = ChatMessageComposerVC()
        vcQuote.state = .quote(mockedMessage)
        AssertSnapshot(vcQuote, screenSize: CGSize(width: 360, height: 180), suffix: "quote")

        let vcCommand = ChatMessageComposerVC()
        vcCommand.state = .slashCommand(.init(name: "Mute", description: "", set: "", args: "[@username]"))
        AssertSnapshot(vcCommand, screenSize: defaultSize, suffix: "command")
    }

    func test_defaultAppearance() {
        class TestVC: ChatMessageComposerVC {
            override func updateContent() {
                super.updateContent()
                textView.text = "Hello World!"
            }
        }

        UIView.setAnimationsEnabled(false)

        let vcInitial = TestVC()
        vcInitial.state = .initial
        AssertSnapshot(vcInitial.view, size: defaultSize)

        let mockedMessage = ChatMessage.mock(id: .unique, text: "Hello World!", author: .mock(id: .unique))

        let vcEdit = TestVC()
        vcEdit.state = .edit(mockedMessage)
        AssertSnapshot(vcEdit.view, size: CGSize(width: 360, height: 130), suffix: "edit")

        let vcQuote = TestVC()
        vcQuote.state = .quote(mockedMessage)
        AssertSnapshot(vcQuote.view, size: CGSize(width: 360, height: 180), suffix: "quote")

        let vcCommand = TestVC()
        vcCommand.state = .slashCommand(.init(name: "Mute", description: "", set: "", args: "[@username]"))
        AssertSnapshot(vcCommand.view, size: defaultSize, suffix: "command")
    }

    func test_appearanceCustomization_usingUIConfig() {}

    func test_appearanceCustomization_usingAppearanceHook() {}

    func test_appearanceCustomization_usingSubclassing() {}
}
