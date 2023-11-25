//
//  PermissionStatus.swift
//  iOS
//

enum PermissionStatus: CustomStringConvertible {

    case authorized
    case limited
    case denied
    case notDetermined
    
    var description: String {
        switch self {
        case .authorized:
            return "Authorized"
        case .denied:
            return "Denied"
        case .notDetermined:
            return "Not Determined"
        case .limited:
            return "Limited"
        }
    }
}
