//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

@testable import StreamChat
import XCTest

class MessageEvents_Tests: XCTestCase {
    let eventDecoder = EventDecoder<NoExtraData>()
    let messageId: MessageId = "1ff9f6d0-df70-4703-aef0-379f95ad7366"
    
    func test_new() throws {
        let json = XCTestCase.mockData(fromFile: "MessageNew")
        let event = try eventDecoder.decode(from: json) as? MessageNewEvent
        XCTAssertEqual(event?.userId, "broken-waterfall-5")
        XCTAssertEqual(event?.cid, ChannelId(type: .messaging, id: "general"))
        XCTAssertEqual(event?.messageId, messageId)
        XCTAssertEqual(event?.createdAt.description, "2020-07-17 13:42:21 +0000")
        XCTAssertEqual(event?.watcherCount, 7)
        XCTAssertEqual(event?.unreadCount, .init(channels: 1, messages: 1))
    }
    
    func test_new_withMissingFields() throws {
        let json = XCTestCase.mockData(fromFile: "MessageNew+MissingFields")
        let event = try eventDecoder.decode(from: json) as? MessageNewEvent
        XCTAssertEqual(event?.userId, "broken-waterfall-5")
        XCTAssertEqual(event?.cid, ChannelId(type: .messaging, id: "general"))
        XCTAssertEqual(event?.messageId, messageId)
        XCTAssertEqual(event?.createdAt.description, "2020-07-17 13:42:21 +0000")
        XCTAssertNil(event?.watcherCount)
        XCTAssertNil(event?.unreadCount)
    }
    
    func test_updated() throws {
        let json = XCTestCase.mockData(fromFile: "MessageUpdated")
        let event = try eventDecoder.decode(from: json) as? MessageUpdatedEvent<NoExtraData>
        XCTAssertEqual(event?.userId, "broken-waterfall-5")
        XCTAssertEqual(event?.cid, ChannelId(type: .messaging, id: "general"))
        XCTAssertEqual(event?.messageId, messageId)
        XCTAssertEqual(event?.updatedAt.description, "2020-07-17 13:46:10 +0000")
    }
    
    func test_deleted() throws {
        let json = XCTestCase.mockData(fromFile: "MessageDeleted")
        let event = try eventDecoder.decode(from: json) as? MessageDeletedEvent<NoExtraData>
        XCTAssertEqual(event?.userId, "broken-waterfall-5")
        XCTAssertEqual(event?.cid, ChannelId(type: .messaging, id: "general"))
        XCTAssertEqual(event?.messageId, messageId)
        XCTAssertEqual(event?.deletedAt.description, "2020-07-17 13:49:48 +0000")
    }
    
    func test_read() throws {
        let json = XCTestCase.mockData(fromFile: "MessageRead")
        let event = try eventDecoder.decode(from: json) as? MessageReadEvent
        XCTAssertEqual(event?.userId, "steep-moon-9")
        XCTAssertEqual(event?.cid, ChannelId(type: .messaging, id: "general"))
        XCTAssertEqual(event?.readAt.description, "2020-07-17 13:55:56 +0000")
        XCTAssertEqual(event?.unreadCount, .init(channels: 3, messages: 21))
    }
    
    func test_read_withoutUnreadCount() throws {
        let json = XCTestCase.mockData(fromFile: "MessageRead+MissingUnreadCount")
        let event = try eventDecoder.decode(from: json) as? MessageReadEvent
        XCTAssertEqual(event?.userId, "steep-moon-9")
        XCTAssertEqual(event?.cid, ChannelId(type: .messaging, id: "general"))
        XCTAssertEqual(event?.readAt.description, "2020-07-17 13:55:56 +0000")
        XCTAssertEqual(event?.unreadCount, nil)
    }
}
