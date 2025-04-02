//
//  BookShelf.swift
//  Lab1
//
//  Created by Vladislav Shiptenko on 02.04.2025.
//

import Foundation

protocol BookShelf {
    func add(item: LibraryItem) throws
    func removeItem(byID id: UUID) throws
    func search(query: String) -> [LibraryItem]
    func listAll() -> [LibraryItem]
}
