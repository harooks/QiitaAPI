//
//  ViewController.swift
//  QiitaAPI
//
//  Created by Haruko Okada on 2/15/21.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    var qiitaArray = [Qiita]()
    
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
        tableView.register(QiitaTableViewCell.self, forCellReuseIdentifier: "Cell")
        navigationItem.title = "Qiita記事一覧"
        getQiitaApi()
        print("view did load")
    }
    
    private func getQiitaApi() {
        
        guard let url = URL(string: "https://qiita.com/api/v2/items?page=1&per_page=20") else { return }
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
                    let qiita = try JSONDecoder().decode([Qiita].self, from: data)
                    self.qiitaArray = qiita
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    print("json:", qiita)
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
        return qiitaArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! QiitaTableViewCell
        cell.qiita = qiitaArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let url = URL(string:"https://www.example.com")
        let url = URL(string: qiitaArray[indexPath.row].url)
        if let url = url{
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true, completion: nil)
        }
    }
    
}



