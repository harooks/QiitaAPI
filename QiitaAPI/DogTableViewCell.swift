//
//  DogTableViewCell.swift
//  QiitaAPI
//
//  Created by Haruko Okada on 2/20/21.
//

import UIKit

class DogTableViewCell: UITableViewCell {

    var dog: Dog? {
        didSet {
            nameTextLabel.text = dog?.name
            temperamentTextLabel.text = dog?.temperament
            let url = URL(string: dog?.image.url ?? "")
            do {
                let data = try Data(contentsOf: url!)
                let image = UIImage(data: data)
                dogImageView.image = image
            }catch let err {
                print("Error : \(err.localizedDescription)")
            }
        }
    }
    
    let dogImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameTextLabel: UILabel = {
        let label = UILabel()
        label.text = "something in here something in here something in here something in here something in here"
        label.font = .systemFont(ofSize: 18)
        label.sizeToFit()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let temperamentTextLabel: UILabel = {
        let label = UILabel()
        label.text = "no temperament recorded"
        label.font = .systemFont(ofSize: 15)
        label.sizeToFit()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(dogImageView)
        addSubview(nameTextLabel)
        addSubview(temperamentTextLabel)
        [
            dogImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dogImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            dogImageView.widthAnchor.constraint(equalToConstant: 50),
            dogImageView.heightAnchor.constraint(equalToConstant: 50),
            
            nameTextLabel.heightAnchor.constraint(equalToConstant: 20),
            nameTextLabel.leadingAnchor.constraint(equalTo: dogImageView.trailingAnchor, constant: 20),
//            nameTextLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameTextLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            temperamentTextLabel.topAnchor.constraint(equalTo: nameTextLabel.bottomAnchor, constant: 5),
//            temperamentTextLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            temperamentTextLabel.leadingAnchor.constraint(equalTo: dogImageView.trailingAnchor, constant: 20),
            temperamentTextLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            ].forEach{ $0.isActive = true }
        
        dogImageView.layer.cornerRadius = 25
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
