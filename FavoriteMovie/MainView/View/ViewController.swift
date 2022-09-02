//
//  ViewController.swift
//  FavoriteMovie
//
//  Created by Андрій Кузьмич on 31.08.2022.
//

import UIKit

final class ViewController: UIViewController {
    private var mainView: MainView {return view as! MainView}
    private var cellText: [FirebaseModel] = []
    private  var firebase = FirebaseService()
    private var viewModel = ViewBuilder.createModule()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        mainView.addBtn.addTarget(self, action: #selector(addHabit), for: .touchUpInside)
        // Do any additional setup after loading the view.
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        firebase.readMovie{(newMovie) in
            print(newMovie)
            self.cellText = Array(newMovie)
            self.mainView.tableView.reloadData()
        }
    }
    

    override func loadView() {
        super.loadView()
        self.view = MainView(frame: UIScreen.main.bounds)
        
        
    }
    
    @objc func addHabit(sender: UIButton){
        
        guard
            let name = mainView.nameOfMovie.text,
            let year = mainView.yearOfMovie.text
        else{return}
        var movieItem = FirebaseModel(movie: name, year: year)
        viewModel.writeMovie(movie: movieItem, comletion:{  (checkVM) in
            if checkVM == true{
                print("error")
                let alert = UIAlertController(title: "Error", message: "This movie is already in your lis", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                self.mainView.nameOfMovie.text = ""
                self.mainView.yearOfMovie.text = ""

            }else{
    
                self.mainView.nameOfMovie.text = ""
                self.mainView.yearOfMovie.text = ""
                self.cellText.append(movieItem)
                self.mainView.tableView.beginUpdates()
                self.mainView.tableView.insertRows(at: [IndexPath.init(row: self.cellText.count-1, section: 0)], with: .automatic)
                self.mainView.tableView.endUpdates()
            }
        })
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainView.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let movieItem = cellText[indexPath.row]
        cell.textLabel?.text = "\(movieItem.movie) \(movieItem.year)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellText.count
    }
    
}
