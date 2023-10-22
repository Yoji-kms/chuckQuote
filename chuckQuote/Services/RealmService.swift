//
//  RealmService.swift
//  chuckQuote
//
//  Created by Yoji on 10.10.2023.
//


import Foundation
import RealmSwift
import Security

final class RealmService {
    private lazy var realmConfig = {
        let keychainSearchingQuery = [
            kSecClass as String: kSecClassKey,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(keychainSearchingQuery as CFDictionary, &item)
        
        guard status != errSecItemNotFound else {
            var key = Data(count: 64)
            _ = key.withUnsafeMutableBytes { pointer in
                SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
            }
            
            let keychainItemQuery = [
                kSecValueData as String: key,
                kSecClass as String: kSecClassKey
            ]
            
            let status = SecItemAdd(keychainItemQuery as CFDictionary, nil)
            let config = Realm.Configuration(encryptionKey: key)
            return config
        }
        
        guard let key = item as? Data else {
            let config = Realm.Configuration()
            return config
        }
        
        let config = Realm.Configuration(encryptionKey: key)
        return config
    }()
    
    func getAll<T: Object> (model: T.Type, completion: @escaping (Result<[T], Error>) -> Void) {
        do {
            let realm = try Realm(configuration: realmConfig)
            
            let objectsRealm = realm.objects(model)
            let objects = Array(objectsRealm)
            completion(.success(objects))
        } catch {
            completion(.failure(NSError()))
        }
    }
    
    func getObjectByKeyValue<T: Object> (
        model: T.Type,
        keyValue: String,
        completion: @escaping (Result<T?, Error>) -> Void
    ){
        do {
            let realm = try Realm(configuration: realmConfig)
            
            guard let object = realm.object(ofType: model.self, forPrimaryKey: keyValue) else {
                completion(.success(nil))
                return
            }
            
            completion(.success(object))
        } catch {
            completion(.failure(NSError()))
        }
    }
    
    func add<T: Object> (object: T, keyValue: String, completion: @escaping (Result<Void, Error>) -> Void) {
        self.handle(object: object, action: .add(keyValue), completion: completion)
    }
    
    func delete<T: Object> (object: T, completion: @escaping (Result<Void, Error>) -> Void) {
        self.handle(object: object, action: .delete, completion: completion)
    }
    
    enum Action {
        case add(String)
        case delete
    }
    
    private func handle <T: Object> (object: T, action: Action, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let realm = try Realm(configuration: realmConfig)
            
            try realm.write {
                switch action {
                case .add(let keyValue):
                    if (!object.isExisted(keyValue: keyValue, realm: realm)) {
                        realm.add(object)
                    }
                case .delete:
                    realm.delete(object)
                }
                
                completion(.success(()))
            }
        } catch {
            completion(.failure(NSError()))
        }
    }
    
    private func checkExistance<T: Object>(model: T.Type) {
        
    }
}

extension Object {
    func isExisted(keyValue: String, realm: Realm) -> Bool {
        return realm.object(ofType: Self.self, forPrimaryKey: keyValue) != nil 
    }
}
