//
//  Permission.swift
//  iOS
//

protocol Permission {
    var status: PermissionStatus { get }
    func request(completion: @escaping (PermissionStatus) -> Void)
}
