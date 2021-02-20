//
//  ViewController.swift
//  QiitaAPI
//
//  Created by Haruko Okada on 2/15/21.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UISearchBarDelegate {
    
    var dogArray = [Dog]()
    
    var filteredDogArray = [Dog]()

    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive
    }
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

//    let searchBar: UISearchBar = {
//        let sb = UISearchBar()
//        sb.searchBarStyle = UISearchBar.Style.prominent
////        sb.translatesAutoresizingMaskIntoConstraints = false
//        sb.placeholder = " Search"
//        sb.sizeToFit()
//        print("where is the search bar")
//        return sb
//    }()
    
    let searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        return sc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
        tableView.frame.size = view.frame.size
        filteredDogArray = dogArray
        tableView.delegate = self
        tableView.dataSource = self
//        searchController.searchBar = self
        tableView.register(DogTableViewCell.self, forCellReuseIdentifier: "Cell")
        getQiitaApi()

        print("view did load")
    }
    
    func setView() {
        navigationItem.title = "犬種一覧"
        view.addSubview(tableView)
        searchController.searchBar.delegate = self
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
    private func getQiitaApi() {
        
        guard let url = URL(string: "https://api.thedogapi.com/v1/breeds") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        print("hello")
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("can't retreive data", err)
                return
            }
            
            if let data = data {
                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    let dog = try JSONDecoder().decode([Dog].self, from: data)
                    self.dogArray = dog
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
//                    print("json:", dog)
                } catch (let err) {
                    print("can't retreive data", err)
                }
            }
        }
        
        task.resume()
        
    }
    
 

 
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredDogArray = []
        if searchText == "" {
            filteredDogArray = dogArray
        } else {
            for dog in dogArray{
                if dog.name.lowercased().contains(searchText.lowercased()) {
                    filteredDogArray.append(dog)
                }

            }
        }
//            print("searchBar method ran")
        
        self.tableView.reloadData()
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredDogArray.count
        } else {
            return dogArray.count
        }
       

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DogTableViewCell
        
        if isFiltering {
            cell.dog = filteredDogArray[indexPath.row]
        } else {
            cell.dog = dogArray[indexPath.row]
        }

        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        //let url = URL(string:"https://www.example.com")
//        let url = URL(string: dogArray[indexPath.row].url)
//        if let url = url{
//            let vc = SFSafariViewController(url: url)
//            present(vc, animated: true, completion: nil)
//        }
//    }
    
}



