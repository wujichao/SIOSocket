//
//  SwiftSocketIO.swift
//  SwiftSocketIO
//
//  Created by Patrick Perini on 6/17/14.
//
//

import XCTest

class SwiftSocketIO: XCTestCase {
    
    func testConnectToLocalhost() {
        var connectionExpectation: XCTestExpectation = self.expectationWithDescription("should connect to localhost")
        SIOSocket.socketWithHost("http://localhost:3000", response: { (socket: SIOSocket!) in
            XCTAssertNotNil(socket, "socket could not find to localhost", file: __FILE__, line: __LINE__)
            XCTAssert(socket.isConnected, "socket could not connect to localhost", file: __FILE__, line: __LINE__)
            
            connectionExpectation.fulfill()
        })

        self.waitForExpectationsWithTimeout(10, handler: nil)
    }
    
}
