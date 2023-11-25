//
//  PhotoPermission.swift
//  iOS
//

import Photos

class PhotoPermission: Permission {

    lazy var status: PermissionStatus = {
        return self.convertStatus(PHPhotoLibrary.authorizationStatus(for: .readWrite))
    }()
    
    func request(completion: @escaping (PermissionStatus) -> Void) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
            guard let self = self else { return }
            DispatchQueue.main.async {
                completion(self.convertStatus(status))
            }
        }
    }
    
    private func convertStatus(_ status: PHAuthorizationStatus) -> PermissionStatus {
        switch status {
        case .authorized:
            return .authorized
        case .denied, .restricted:
            return .denied
        case .limited:
            return .limited
        case .notDetermined:
            return .notDetermined
        @unknown default:
            return .denied
        }
    }
}
