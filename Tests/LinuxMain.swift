import XCTest
@testable import ValidatedExtension
import ValidatedExtensionTests

var tests = [XCTestCaseEntry]()
tests += ValidatedExtensionTests.ValidatedTests.allTests()
XCTMain(tests)
