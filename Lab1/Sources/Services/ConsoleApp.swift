//
//  ConsoleApp.swift
//  Lab1
//
//  Created by Vladislav Shiptenko on 02.04.2025.
//

import Foundation

final class ConsoleApp: App {
    let bookShelf: BookShelf
    init(bookShelf: BookShelf) {
        self.bookShelf = bookShelf
    }
    func printMenu() {
        print("""
        -------------------------------------
        Выберите действие:
        1. Добавить книгу
        2. Добавить комикс
        3. Добавить учебник
        4. Удалить по ID
        5. Посмотреть список всех книг/предметов
        6. Поиск
        7. Выйти из приложения
        -------------------------------------
        """)
    }
    func run() {
        var isRunning = true
        while isRunning {
            printMenu()
            guard let input = readLine() else {
                print("Ошибка чтения ввода. Попробуйте еще раз.")
                continue
            }
            switch input {
            case "1":
                do {
                    let newBook = try createBook()
                    try bookShelf.add(item: newBook)
                    print("Книга «\(newBook.title)» добавлена в библиотеку!")
                } catch {
                    print("Не удалось добавить книгу. Ошибка: \(error)")
                }
                
            case "2":
                do {
                    let newComic = try createComic()
                    try bookShelf.add(item: newComic)
                    print("Комикс «\(newComic.title)» (№\(newComic.issueNumber)) добавлен в библиотеку!")
                } catch {
                    print("Не удалось добавить комикс. Ошибка: \(error)")
                }
            case "3":
                do {
                    let newTextbook = try createTextbook()
                    try bookShelf.add(item: newTextbook)
                    print("Учебник «\(newTextbook.title)» (курс \(newTextbook.courseName)) добавлен в библиотеку!")
                } catch {
                    print("Не удалось добавить учебник. Ошибка: \(error)")
                }
            case "4":
                print("Введите ID (UUID) для удаления:")
                if let idString = readLine(), let uuid = UUID(uuidString: idString) {
                    do {
                        try bookShelf.removeItem(byID: uuid)
                        print("Элемент успешно удалён.")
                    } catch {
                        print("Ошибка при удалении: \(error)")
                    }
                } else {
                    print("Неверный формат ID.")
                }
                
            case "5":
                let items = bookShelf.listAll()
                if items.isEmpty {
                    print("Библиотека пуста.")
                } else {
                    print("-------------------------------------")
                    for item in items {
                        printItemInfo(item)
                    }
                    print("-------------------------------------")
                }
            case "6":
                print("Введите запрос для поиска (название или автор):")
                if let query = readLine() {
                    let foundItems = bookShelf.search(query: query)
                    if foundItems.isEmpty {
                        print("Ничего не найдено по запросу «\(query)»")
                    } else {
                        print("-------------------------------------")
                        for item in foundItems {
                            printItemInfo(item)
                        }
                        print("-------------------------------------")
                    }
                } else {
                    print("Ошибка чтения ввода.")
                }
                
            case "7":
                isRunning = false
            default:
                print("Неизвестная команда. Попробуйте ещё раз.")
            }
        }
        
        print("Завершение работы приложения.")
    }
    func createBook() throws -> Book {
        print("Введите название книги:")
        guard let title = readLine(), !title.isEmpty else {
            throw LibraryError.invalidInput
        }
        print("Введите автора книги:")
        guard let author = readLine(), !author.isEmpty else {
            throw LibraryError.invalidInput
        }
        
        print("Введите год издания (или пусто, если нет):")
        let yearString = readLine()
        let year = Int(yearString ?? "")
        
        print("Выберите жанр (введите номер):")
        let allGenres: [BookGenre] = [.fiction, .mystery, .sciFi, .biography, .history, .education]
        for (index, genre) in allGenres.enumerated() {
            print("\(index + 1). \(genre.rawValue)")
        }
        guard
            let genreInput = readLine(),
            let genreIndex = Int(genreInput),
            genreIndex > 0, genreIndex <= allGenres.count
        else {
            throw LibraryError.invalidInput
        }
        let selectedGenre = allGenres[genreIndex - 1]
        
        return Book(
            title: title,
            author: author,
            publicationYear: year,
            genre: selectedGenre
        )
    }
    func createComic() throws -> Comic {
        print("Введите название комикса:")
        guard let title = readLine(), !title.isEmpty else {
            throw LibraryError.invalidInput
        }
        print("Введите автора (или издателя) комикса:")
        guard let author = readLine(), !author.isEmpty else {
            throw LibraryError.invalidInput
        }

        print("Введите год издания (или пусто, если нет):")
        let yearString = readLine()
        let year = Int(yearString ?? "")

        print("Введите номер выпуска:")
        guard let issueNumberString = readLine(), let issueNumber = Int(issueNumberString) else {
            throw LibraryError.invalidInput
        }

        print("Выберите жанр (введите номер):")
        let allGenres: [BookGenre] = [.fiction, .mystery, .sciFi, .biography, .history, .education]
        for (index, genre) in allGenres.enumerated() {
            print("\(index + 1). \(genre.rawValue)")
        }
        guard
            let genreInput = readLine(),
            let genreIndex = Int(genreInput),
            genreIndex > 0, genreIndex <= allGenres.count
        else {
            throw LibraryError.invalidInput
        }
        let selectedGenre = allGenres[genreIndex - 1]

        return Comic(
            title: title,
            author: author,
            publicationYear: year,
            genre: selectedGenre,
            issueNumber: issueNumber
        )
    }
    func createTextbook() throws -> Textbook {
        print("Введите название учебника:")
        guard let title = readLine(), !title.isEmpty else {
            throw LibraryError.invalidInput
        }
        print("Введите автора учебника:")
        guard let author = readLine(), !author.isEmpty else {
            throw LibraryError.invalidInput
        }

        print("Введите год издания (или пусто, если нет):")
        let yearString = readLine()
        let year = Int(yearString ?? "")

        print("Введите название курса:")
        guard let courseName = readLine(), !courseName.isEmpty else {
            throw LibraryError.invalidInput
        }

        return Textbook(
            title: title,
            author: author,
            publicationYear: year,
            courseName: courseName
        )
    }
    func printItemInfo(_ item: LibraryItem) {
        print("ID: \(item.id)")
        print("Название: \(item.title)")
        print("Автор: \(item.author)")
        if let year = item.publicationYear {
            print("Год издания: \(year)")
        } else {
            print("Год издания: отсутствует")
        }
        print("Жанр: \(item.genre.rawValue)")
        switch item {
        case let comic as Comic:
            print("Выпуск №\(comic.issueNumber) (Комикс)")
        case let textbook as Textbook:
            print("Курс \(textbook.courseName) (Учебник)")
        case _ as Book:
            print("Обычная книга")
        default:
            break
        }

        print("-------------------------------------")
    }
}
