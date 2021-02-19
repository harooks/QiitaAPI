//
//  ViewController.swift
//  QiitaAPI
//
//  Created by Haruko Okada on 2/15/21.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    var dogArray = [Dog]()
    
    let tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(tableView)
        tableView.frame.size = view.frame.size
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DogTableViewCell.self, forCellReuseIdentifier: "Cell")
        navigationItem.title = "犬種一覧"
        getQiitaApi()
        print("view did load")
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
                    print("json:", dog)
                } catch (let err) {
                    print("can't retreive data", err)
                }
            }
        }
        
        task.resume()
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DogTableViewCell
        cell.dog = dogArray[indexPath.row]
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



