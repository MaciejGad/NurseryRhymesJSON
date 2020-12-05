import Foundation

extension Optional where Wrapped == String {
    func emptyToNil() -> Self {
        switch self {
        case .some(let value) where value.count > 0:
            return value
        default:
            return nil
        }
    }
    
    func nilToEmpty() -> Wrapped {
        switch self {
        case .none:
            return ""
        case .some(let value):
            return value
        }
    }
}
