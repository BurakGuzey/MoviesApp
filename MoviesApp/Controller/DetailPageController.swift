//
//  File.swift
//  MoviesApp
//
//  Created by Burak Güzey on 2.07.2022.
//

import Foundation
import UIKit

class DetailPageController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var detailPageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailPageTableView.dataSource = self
        detailPageTableView.delegate = self
        
        detailPageTableView.register(UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: "FirstCell")
        
    }
}

extension DetailPageController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCell", for: indexPath) as! ImageCell
        return cell
    }
}
