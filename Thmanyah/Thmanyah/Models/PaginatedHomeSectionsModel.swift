struct PaginatedHomeSections: Decodable {
    let sections: [HomeSection]
    let pagination: Pagination
    
    struct Pagination: Decodable {
        let next_page: String?
    }
}
