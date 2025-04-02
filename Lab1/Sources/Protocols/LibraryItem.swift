//
//  LibraryItem.swift
//  Lab1
//
//  Created by Vladislav Shiptenko on 02.04.2025.
//

import Foundation

protocol LibraryItem {
    var id: UUID { get }
    var title: String { get }
    var author: String { get }
    var publicationYear: Int? { get }
    var genre: BookGenre { get }
}


