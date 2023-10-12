//
//  RealmService.swift
//  chuckQuote
//
//  Created by Yoji on 10.10.2023.
//


import Foundation
import RealmSwift

final class RealmService {
    func getAll<T: Object> (model: T.Type, completion: @escaping (Result<[T], Error>) -> Void) {
        do {
            let realm = try Realm()
            
            let objectsRealm = realm.objects(model)
            let objects = Array(objectsRealm)
            completion(.success(objects))
        } catch {
            completion(.failure(NSError()))
        }
    }
    
    func add<T: Object> (object: T, completion: @escaping (Result<Void, Error>) -> Void) {
        self.handle(object: object, action: .add, completion: completion)
    }
    
    func delete<T: Object> (object: T, completion: @escaping (Result<Void, Error>) -> Void) {
        self.handle(object: object, action: .delete, completion: completion)
    }
    
    enum Action {
        case add
        case delete
    }
    
    private func handle <T: Object> (object: T, action: Action, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let realm = try Realm()
            
            try realm.write {
                switch action {
                case .add:
                    realm.add(object)
                case .delete:
                    realm.delete(object)
                }
                
                completion(.success(()))
            }
        } catch {
            completion(.failure(NSError()))
        }
    }
}

