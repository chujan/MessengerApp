//
//  StorageManager.swift
//  MessengerApp
//
//  Created by Chukwuemeka Jennifer on 30/09/2021.
//

import Foundation
import FirebaseStorage
/// Allows you to get, fetch and upload files to firebase storage

final class StorageManager {
    static let shared = StorageManager()
    private let storage = Storage.storage().reference()
    let metadata = StorageMetadata()
   
    public typealias UploadPictureCompletion = (Result<String, Error>) -> Void
    
    
    public func uploadProfilePicture(with data: Data, fileName: String,completion: @escaping UploadPictureCompletion) {
        storage.child("images/\(fileName)").putData(data, metadata: nil, completion:{[weak self] metadata, error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                print("failed to upload data to firebase for picture")
                completion(.failure(StorageErrors.failedToUpload))
                return
        }
              strongSelf.storage.child("images/\(fileName)").downloadURL(completion: {url, error in
                guard let url = url else {
                    print("Failed to get download url")
                    completion(.failure(StorageErrors.failedToGetDownLoadUrl))
                    
                    return
                }
                
                let urlString = url.absoluteString
                print("downlosd url returned: \(urlString)")
                completion(.success(urlString))
                
            })
       
        })
        
    }
    public func uploadMessagePhoto(with data: Data, fileName: String,completion: @escaping UploadPictureCompletion) {
        
        
        storage.child("message_images/\(fileName)").putData(data, metadata: nil, completion:{[weak self] metadata, error in
            guard error == nil else {
                print("failed to upload data to firebase for picture")
                completion(.failure(StorageErrors.failedToUpload))
                return
        }
            self?.storage.child("message_images/\(fileName)").downloadURL(completion: {url, error in
                guard let url = url else {
                    print("Failed to get download url")
                    completion(.failure(StorageErrors.failedToGetDownLoadUrl))
                    
                    return
                }
                
                let urlString = url.absoluteString
                print("downlosd url returned: \(urlString)")
                completion(.success(urlString))
                
            })
       
        })
        
    }
    public func uploadMessageVideo(with fileURL: URL, fileName: String,completion: @escaping UploadPictureCompletion) {
        
        metadata.contentType = "video/quicktime"
        if let videoData = NSData(contentsOf: fileURL) as Data? {
            storage.child("message_videos/\(fileName)").putData(videoData, metadata: metadata, completion: { [weak self] metadata,error in
                guard let strongSelf = self else {
                    return
                }
                guard error == nil else {
                    print("failed to upload video file to firebase for picture")
                    completion(.failure(StorageErrors.failedToUpload))
                    return
            }
                  strongSelf.storage.child("message_videos/\(fileName)").downloadURL(completion: {url, error in
                    guard let url = url else {
                        print("Failed to get download url")
                        completion(.failure(StorageErrors.failedToGetDownLoadUrl))
                        
                        return
                    }
                    
                    let urlString = url.absoluteString
                    print("downlosd url returned: \(urlString)")
                    completion(.success(urlString))
                    
                })
                
                
            })
                
            
            
               
           
            
            
        }
       
        
    }
    
    public enum StorageErrors: Error {
        case failedToUpload
        case failedToGetDownLoadUrl
    }
    
    public func downloadURL(for path: String,completion: @escaping (Result<URL, Error>) -> Void) {
        let reference = storage.child(path)
        reference.downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(StorageErrors.failedToGetDownLoadUrl))
                return
            }
            
            completion(.success(url))
            
        })
        
    }
}
