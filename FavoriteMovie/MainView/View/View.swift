//
//  View.swift
//  FavoriteMovie
//
//  Created by Андрій Кузьмич on 31.08.2022.
//

import UIKit

final class MainView: UIView{
    let nameOfMovie = UITextField()
    let yearOfMovie = UITextField()
    let addBtn = UIButton()
    var tableView = UITableView()
    
    override init(frame: CGRect) {
          super.init(frame: frame)
          self.backgroundColor = .white
          createSubViews()
       }
       
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    func createSubViews(){
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        
        nameOfMovie.translatesAutoresizingMaskIntoConstraints = false
        nameOfMovie.layer.cornerRadius = 3
        nameOfMovie.layer.borderColor = UIColor.lightGray .cgColor
        nameOfMovie.layer.borderWidth = 1
        nameOfMovie.font = UIFont.systemFont(ofSize: 24)
        nameOfMovie.placeholder = "Movie"
        self.addSubview(nameOfMovie)
        
        yearOfMovie.translatesAutoresizingMaskIntoConstraints = false
        yearOfMovie.layer.cornerRadius = 3
        yearOfMovie.layer.borderColor = UIColor.lightGray .cgColor
        yearOfMovie.layer.borderWidth = 1
        yearOfMovie.font = UIFont.systemFont(ofSize: 24)
        yearOfMovie.placeholder = "Year"
        self.addSubview(yearOfMovie)
        
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        addBtn.setTitle("Add", for: .normal)
        addBtn.layer.cornerRadius = 5.0
        addBtn.backgroundColor = .systemBlue
        self.addSubview(addBtn)
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            nameOfMovie.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 20.0),
            nameOfMovie.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -10.0),
            nameOfMovie.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 10.0),
            
            yearOfMovie.topAnchor.constraint(equalTo: nameOfMovie.bottomAnchor, constant: 10.0),
            yearOfMovie.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -10.0),
            yearOfMovie.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 10.0),
            
            addBtn.topAnchor.constraint(equalTo: yearOfMovie.bottomAnchor, constant: 20.0),
            addBtn.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -80.0),
            addBtn.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 80.0),
            
            tableView.topAnchor.constraint(equalTo: addBtn.bottomAnchor, constant: 20.0),
            tableView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -10.0),
            tableView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 10.0),
            tableView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: 10.0)
        
        ])
        self.tableView = tableView
    }
}
