//
//  PermissionManager.swift
//  iOS
//

import Foundation

class PermissionManager {
    
    private var permission: Permission?
    
    func setPermission(permission: Permission) {
        self.permission = permission
    }
    
    func checkPermission(completion: @escaping (PermissionStatus) -> Void) {
        guard let permission = permission else {
            return
        }
        
        if permission.status == .notDetermined {
            permission.request { permissionStatus in
                completion(permissionStatus)
            }
        } else {
            completion(permission.status)
        }
    }
}
