import ComposableArchitecture
import Foundation
import FirebaseCore
import FirebaseFirestore

public struct FirestorePersistenceKey<T: Codable>: PersistenceReaderKey {
    var key: String
    
    public typealias Value = [T]
    
    public init(key: String) {
        self.key = key
    }
    
    public var id: String {
        self.key
    }
    
    public func load(initialValue: Value?) -> Value? {
        return initialValue
    }
    
    public func subscribe(initialValue: Value?, didSet: @escaping (Value?) -> Void) -> Shared<Value>.Subscription {
        let db = Firestore.firestore().collection(self.key)
        
        db.addSnapshotListener { querySanpshots, error in
            guard let documents = querySanpshots?.documents else {
                print("No documents")
                return
            }
            let items = documents.compactMap({ try? $0.data(as: T.self)})
            didSet(items)
        }
        
        return .init {
            print("cancel")
        }
    }
}



extension PersistenceReaderKey {
    public static func firestore<Value>(_ key: String) -> Self where Self == PersistenceKeyDefault<FirestorePersistenceKey<Value>> {
        
        return PersistenceKeyDefault(FirestorePersistenceKey(key: key), [])
    }
}
