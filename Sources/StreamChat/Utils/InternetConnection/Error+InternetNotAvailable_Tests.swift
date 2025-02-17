//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

@testable import StreamChat
import XCTest

final class ErrorInternetNotAvailable_Tests: XCTestCase {
    func test_errorIsNSURLErrorNotConnectedToInternet() throws {
        let error = NSError(
            domain: NSURLErrorDomain,
            code: NSURLErrorNotConnectedToInternet,
            userInfo: nil
        )
        
        XCTAssertTrue(error.isInternetOfflineError)
    }
    
    func test_errorIsNSPOSIXErrorDomain50() throws {
        let error = NSError(
            domain: NSPOSIXErrorDomain,
            code: 50,
            userInfo: nil
        )
        
        XCTAssertTrue(error.isInternetOfflineError)
    }
    
    func test_errorDomainIsNotOneOfInternetOfflineError() throws {
        let error = NSError(
            domain: "Some domain",
            code: 50,
            userInfo: nil
        )
        
        XCTAssertFalse(error.isInternetOfflineError)
    }
    
    func test_errorCodeIsNotOneOfInternetOfflineError() throws {
        let error = NSError(
            domain: NSURLErrorDomain,
            code: 50,
            userInfo: nil
        )
        
        XCTAssertFalse(error.isInternetOfflineError)
    }
    
    func test_websocketEngineErrorInternetIsOffline() throws {
        let error = WebSocketEngineError(
            reason: "",
            code: -1009,
            engineError: NSError(
                domain: NSURLErrorDomain,
                code: NSURLErrorNotConnectedToInternet,
                userInfo: nil
            )
        )
        
        XCTAssertTrue(error.isInternetOfflineError)
    }
    
    func test_websocketEngineErrorDomainIsNotInternetIsOffline() throws {
        let error = WebSocketEngineError(
            reason: "",
            code: 304,
            engineError: NSError(
                domain: "Some domain",
                code: NSURLErrorNotConnectedToInternet,
                userInfo: nil
            )
        )
        
        XCTAssertFalse(error.isInternetOfflineError)
    }
    
    func test_websocketEngineErrorCodeIsNotInternetIsOffline() throws {
        let error = WebSocketEngineError(
            reason: "",
            code: 304,
            engineError: NSError(
                domain: NSURLErrorDomain,
                code: 304,
                userInfo: nil
            )
        )
        
        XCTAssertFalse(error.isInternetOfflineError)
    }
}
