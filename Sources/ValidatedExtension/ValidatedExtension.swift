/// This protocol needs to be implemented in order to add a requirement to
/// a wrapped type.
/// Implementers receive the wrapped type and need to determine if its values
/// fulfill the requirements of the wrapper type.
/// ~~~
/// struct NonEmptyStringValidator: Validator {
///     static func validate(value: String) -> Bool {
///         return !value.isEmpty
///     }
/// }
/// ~~~
public protocol Validator {
    associatedtype WrappedType

    /// Validates if a value of the wrapped type fullfills the requirements of the
    /// wrapper type.
    ///
    /// - parameter validate: An instance of the `WrappedType`
    /// - returns: A `Bool` indicating success(`true`)/failure(`false`) of the validation
    static func validate(_ value: WrappedType) throws -> Bool
}

#if !swift(>=3.0)
typealias Error = ErrorType
#endif

/// Error that is thrown when a validation fails. Proivdes the validator type and
/// the value that failed validation
public struct ValidatorError: Error, CustomStringConvertible {
    /// The value that failed validation.
    public let wrapperValue: Any
    /// Type of a specific `Validator`.
    /// `Any` is used because `Validator` has associated type requirements.
    public let validator: Any.Type

    public var description: String {
        #if swift(>=3.0)
        let type = type(of: wrapperValue)
        #else
        let type = wrapperValue.dynamicType
        #endif
        return "Value: '\(wrapperValue)' <\(type)>, "
            + "failed validation of Validator: \(validator.self)"
    }
}

/// Allows behaviour to be added to a validated type via protocol extensions.
///
/// e.g.,
/// ~~~
/// typealias PhoneNumber = Validated<PhoneNumberValidator>
///
/// extension ValidatedType where ValidatorType == PhoneNumberValidator {
///   var regionCode: String {
///     return // Parse and return region code
///   }
/// }
///
/// ...
///
/// let phoneNumber = try PhoneNumber("00 1 917 555 2368")
/// print("\(phoneNumber.regionCode)")
/// ~~~
public protocol ValidatedType {
    associatedtype ValidatorType: Validator
    /// The value that passes the defined `Validator`.
    ///
    /// If you are able to access this property; it means the `ValidatorType.WrappedType` passes the validator.
    var value: ValidatorType.WrappedType { get }
}

/// Wraps a type together with one validator. Provides a failable initializer
/// that will only return a value of `Validated` if the provided `WrapperType` value
/// fulfills the requirements of the specified `Validator`.
public struct Validated<V: Validator>: ValidatedType {
    public typealias ValidatorType = V
    public typealias WrapperType = ValidatorType.WrappedType
    /// The value that passes the defined `Validator`.
    ///
    /// If you are able to access this property; it means the wrappedType passes the validator.
    public let value: ValidatorType.WrappedType

    /// Throwing initializer that will *not* throw an error
    /// if the provided value fulfills the requirements
    /// specified by the `Validator`.
    public init(_ value: WrapperType) throws {
        guard try V.validate(value) else {
            throw ValidatorError(
                wrapperValue: value,
                validator: V.self)
        }

        self.value = value
    }

    /// Failible initializer that will only succeed,
    /// if the provided value fulfills the requirements specified by the `Validator`.
    public init?(value: WrapperType) {
        try? self.init(value)
    }
}

#if swift(>=3.0)
/// Validator wrapper which is valid when `V1` and `V2` validated to `true`.
public struct And<
    V1: Validator,
    V2: Validator>: Validator where
    V1.WrappedType == V2.WrappedType {
    public static func validate(_ value: V1.WrappedType) throws -> Bool {
        return try V1.validate(value) && V2.validate(value)
    }
}
#else
/// Validator wrapper which is valid when `V1` and `V2` validated to `true`.
public struct And<
    V1: Validator,
    V2: Validator where
        V1.WrappedType == V2.WrappedType>: Validator {

    public static func validate(value: V1.WrappedType) throws -> Bool {
        return try V1.validate(value) && V2.validate(value)
    }
}
#endif

#if swift(>=3.0)
// swiftlint:disable:next type_name
/// Validator wrapper which is valid when either `V1` or `V2` validated to `true`.
public struct Or<
    V1: Validator,
    V2: Validator>: Validator where
    V1.WrappedType == V2.WrappedType {
    #if swift(>=3.0)
    public static func validate(_ value: V1.WrappedType) throws -> Bool {
        return try V1.validate(value) || V2.validate(value)
    }
    #else
    public static func validate(value: V1.WrappedType) throws -> Bool {
        return try V1.validate(value) || V2.validate(value)
    }
    #endif
}
#else
// swiftlint:disable:next type_name
/// Validator wrapper which is valid when either `V1` or `V2` validated to `true`.
public struct Or<
    V1: Validator,
    V2: Validator where
V1.WrappedType == V2.WrappedType>: Validator {
    public static func validate(value: V1.WrappedType) throws -> Bool {
        return try V1.validate(value) || V2.validate(value)
    }
}
#endif

/// Validator wrapper which is valid when `V1` validated to `false`.
public struct Not<V1: Validator>: Validator {
    #if swift(>=3.0)
    public static func validate(_ value: V1.WrappedType) throws -> Bool {
        return try !V1.validate(value)
    }
    #else
    public static func validate(value: V1.WrappedType) throws -> Bool {
        return try !V1.validate(value)
    }
    #endif
}
