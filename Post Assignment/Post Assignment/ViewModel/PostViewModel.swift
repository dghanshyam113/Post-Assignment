//
//  PostViewModel.swift
//  Post Assignment
//
//  Created by Admin on 13/02/21.
//  Copyright © 2021 Ghanshyam. All rights reserved.
//

import Foundation

class PostViewModel {
    
    var posts:[Post]?
    
    // MARK: - Initialization
    init(model: [Post]? = nil) {
        if let inputModel = model {
            posts = inputModel
        }
    }
}

extension PostViewModel {
    
    func fetchPost(completion: @escaping (Result<[Post], Error>) -> Void) {
        HTTPManager.shared.get(urlString: "posts", completionBlock: { [weak self] result in
            
            guard self != nil else {return}
            
            switch result {
                
            case .failure(let error):
                print ("failure", error)
                
            case .success(let data) :
                
                let decoder = JSONDecoder()
                
                do {
                    let posts = try decoder.decode([Post].self, from: data)
                    completion(.success(posts))
                    
                } catch {
                    completion(.failure(error))
                }
            }
        })
    }
}
