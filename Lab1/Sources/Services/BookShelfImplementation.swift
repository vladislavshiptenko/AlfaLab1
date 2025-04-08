//
//  BookShelfImplementation.swift
//  Lab1
//
//  Created by Vladislav Shiptenko on 02.04.2025.
//

import Foundation

final class BookShelfImplementation: BookShelf {
    private var storage: [UUID: LibraryItem] = [:]
    func add(item: LibraryItem) throws {
        storage[item.id] = item
    }
    
    func removeItem(byID id: UUID) throws {
        guard storage.removeValue(forKey: id) != nil else {
            throw LibraryError.itemNotFound
        }
    }
    
    func search(query: String) -> [LibraryItem] {
        let lowercasedQuery = query.lowercased()
        
        return storage.values.filter { item in
            let titleContains      = item.title.lowercased().contains(lowercasedQuery)
            let authorContains     = item.author.lowercased().contains(lowercasedQuery)
            
            return titleContains || authorContains
        }
    }
    
    func listAll() -> [LibraryItem] {
        return Array(storage.values)
    }
}
