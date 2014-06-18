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
            XCTAssertNotNil(socket, "socket could not find to localhost")
            connectionExpectation.fulfill()
        })

        self.waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testFalse() {
        var connectionExpectation: XCTestExpectation = self.expectationWithDescription("should connect to localhost")
        var falseExpectation: XCTestExpectation = self.expectationWithDescription("should work with false")

        SIOSocket.socketWithHost("http://localhost:3000", response: { (socket: SIOSocket!) in
            XCTAssertNotNil(socket, "socket could not find to localhost")
            connectionExpectation.fulfill()
            
            socket.on("false", perform: {
                XCTAssertFalse($0.boolValue)
                falseExpectation.fulfill()
            })
            
            socket.emit("false", arguments: nil)
        })
        
        self.waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testUTF8MultibyteCharacters() {
        var connectionExpectation: XCTestExpectation = self.expectationWithDescription("should connect to localhost")
        var utf8MultibyteCharactersExpectation: XCTestExpectation = self.expectationWithDescription("should work with utf8 multibyte characters")
        
        var correctStrings: String[] = [
            "てすと",
            "Я Б Г Д Ж Й",
            "Ä ä Ü ü ß",
            "utf8 — string",
            "utf8 — string"
        ]
        
        SIOSocket.socketWithHost("http://localhost:3000", response: { (socket: SIOSocket!) in
            XCTAssertNotNil(socket, "socket could not find to localhost")
            connectionExpectation.fulfill()
            
            var numberOfCorrectStrings: Int = 0
            socket.on("takeUtf8", perform: {
                XCTAssertEqualObjects($0 as? NSObject, correctStrings[numberOfCorrectStrings], "\($0) is not equal to \(correctStrings[numberOfCorrectStrings])")
                numberOfCorrectStrings++
                
                if numberOfCorrectStrings == correctStrings.count {
                    utf8MultibyteCharactersExpectation.fulfill()
                }
            })
            
            socket.emit("getUtf8", arguments: nil)
        })

        self.waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testEmitDateAsString() {
        var connectionExpectation: XCTestExpectation = self.expectationWithDescription("should connect to localhost")
        var stringExpectation: XCTestExpectation = self.expectationWithDescription("should emit date as string")
        
        SIOSocket.socketWithHost("http://localhost:3000", response: { (socket: SIOSocket!) in
            XCTAssertNotNil(socket, "socket could not find to localhost")
            connectionExpectation.fulfill()
            
            socket.on("takeDate", perform: {
                XCTAssert($0.isKindOfClass(NSString), "\($0) is not a string")
                stringExpectation.fulfill()
            })
            
            socket.emit("getDate", arguments: nil)
        })
        
        self.waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testEmitDateAsObject() {
        var connectionExpectation: XCTestExpectation = self.expectationWithDescription("should connect to localhost")
        var stringExpectation: XCTestExpectation = self.expectationWithDescription("should emit date as object")
        
        SIOSocket.socketWithHost("http://localhost:3000", response: { (socket: SIOSocket!) in
            XCTAssertNotNil(socket, "socket could not find to localhost")
            connectionExpectation.fulfill()
            
            socket.on("takeDateObj", perform: {
                XCTAssert($0.isKindOfClass(NSDictionary), "\($0) is not a dictionary")
                XCTAssert($0.objectForKey("date").isKindOfClass(NSString), "\($0)['date'] is not a string")
                
                stringExpectation.fulfill()
            })
            
            socket.emit("getDateObj", arguments: nil)
        })
        
        self.waitForExpectationsWithTimeout(10, handler: nil)
    }
    
}
