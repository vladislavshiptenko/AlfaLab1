//
//  TextBook.swift
//  Lab1
//
//  Created by Vladislav Shiptenko on 02.04.2025.
//


import Foundation

struct Textbook: LibraryItem {
    let id: UUID
    let title: String
    let author: String
    let publicationYear: Int?
    let genre: BookGenre
    let courseName: String
    init(
        id: UUID = UUID(),
        title: String,
        author: String,
        publicationYear: Int?,
        courseName: String
    ) {
        self.id = id
        self.title = title
        self.author = author
        self.publicationYear = publicationYear
        self.genre = BookGenre.education
        self.courseName = courseName
    }
}
