import XCTest
@testable import EasyInject
import ValidatedExtensionTests

var tests = [XCTestCaseEntry]()
tests += ValidatedExtensionTests.ValidatedTests.allTests()
XCTMain(tests)
