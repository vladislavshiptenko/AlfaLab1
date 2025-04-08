//
//  Book.swift
//  Lab1
//
//  Created by Vladislav Shiptenko on 02.04.2025.
//

import Foundation

struct Book: LibraryItem {
    let id: UUID
    let title: String
    let author: String
    let publicationYear: Int?
    let genre: BookGenre
    init(
        id: UUID = UUID(),
        title: String,
        author: String,
        publicationYear: Int?,
        genre: BookGenre,
    ) {
        self.id = id
        self.title = title
        self.author = author
        self.publicationYear = publicationYear
        self.genre = genre
    }
}
