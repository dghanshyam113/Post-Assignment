//
//  ViewController.swift
//  Post Assignment
//
//  Created by Admin on 13/02/21.
//  Copyright © 2021 Ghanshyam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var postViewModel = PostViewModel()
    var backView = UIView()
    var activityView: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLoader()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        featchData()
    }

    func featchData() {
        
        showLoader()
        
        postViewModel.fetchPost{ [weak self] post in
            
            DispatchQueue.main.async {
                
                self?.hideLoader()
                
                switch post {
                    
                case .success(let data) :
                    
                    print("posts",data)
                    
                    self?.postViewModel = PostViewModel(model: data)
                    self?.collectionView.reloadData()
                    
                case .failure(let error) :
                    
                    print(error)
                    
                }
            }
        }
    }
}

extension ViewController {
    
    func initLoader() {
        
        let label = UILabel()
        label.frame = CGRect(x: view.bounds.width/2 - 50, y: view.bounds.height/2 + 20, width: 200, height: 50)
        label.text = "Please Wait..."
        backView.frame = view.bounds
        backView.addSubview(label)
        backView.backgroundColor = .white
        backView.alpha = 0
    }
    
    func showLoader() {
        
        backView.alpha = 1
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.color = .systemBlue
        activityView?.center = self.backView.center
        activityView?.startAnimating()
        backView.addSubview(activityView!)
        view.addSubview(backView)
    }
    
    func hideLoader() {
        
        if activityView != nil {
            activityView?.stopAnimating()
        }
        
        backView.alpha = 0
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return postViewModel.posts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
        
        cell.titleOutlet.text = postViewModel.posts?[indexPath.row].title
        cell.descriptionOutlet.text = postViewModel.posts?[indexPath.row].body
        
        return cell
    }
}
