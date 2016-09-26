# 4.0.0
*Released: 2016-09-26*

**Breaking Changes:**

- Dropped Swift 2.x support - @vknabel
- Added Travis support - @vknabel
- Added missing `Tests` suffix for `Tests/ValidatedExtension` - @vknabel
- Added support for `$ swift test` on Linux

# 3.0.1
*Released: 16/08/2016*

**Other Changes:**

- Migrated to Swift 3.0 Beta 6 - @vknabel

#3.0
*Released: 04/08/2016*

**Breaking API Changes:**

- Renamed Validated to ValidatedExtension in order to be distributed as CocoaPod - @vknabel
- Removed first generic Parameter on `Validated` - @vknabel
- `Validator.validate` now additionally throws - @vknabel

**API Additions:**

- Added `ValidatedType` protocol - @jersonperpetua

**Other Changes:**

- Added support for Swift Package Manager - @vknabel
- Additionally supports Swift 3.0 - @vknabel
- Included Jazzy-parsed Docs - @vknabel
- Generated Github Pages - @vknabel
- Restructured Repository - @vknabel
- Added Swiftlint - @vknabel

#2.0.1
*Released: 05/05/2016*

- Lowered iOS Deployment Target to 8.0 - @loganmoseley
- Update usage of `typealias` to `associatedtype` - @AndrewSB

#2.0
*Released: 03/02/2016*

**Breaking API Changes:**

- Removed `Validated2` and `Validated3` in favor of introduced logical wrapper validators - @Ben-G on suggestion of @tomquist
- Failable initializer of `Validated` now requires explicit `value` argument due to introduction of throwing initializer - @Ben-G

**API Additions:**

- Added wrapper validators for logical operators - @tomquist
- Added throwing initializer for `Validated` - @Ben-G upon suggestion of @radex

**Other Changes:**

- Major Refactoring of `Validated` Type - @dehesa
- Addition of OSX, tvOS and watchOS targets - @dehesae

#1.0
*Released: 02/24/2016*

 - Initial Release - @Ben-G
