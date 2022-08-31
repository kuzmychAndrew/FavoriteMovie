//
//  ViewController.swift
//  FavoriteMovie
//
//  Created by Андрій Кузьмич on 31.08.2022.
//

import UIKit

final class ViewController: UIViewController {
    private var mainView: MainView {return view as! MainView}
    private var cellText:[String] = []
    private  var firebase = FirebaseService()
    private var viewModel = ViewBuilder.createModule()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        mainView.addBtn.addTarget(self, action: #selector(addHabit), for: .touchUpInside)
        // Do any additional setup after loading the view.
        //mainView.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        firebase.readMovie{(newMovie) in
            print(newMovie)
            self.cellText = newMovie
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
        if cellText.contains("\(name + year)"){
            print("error")
            let alert = UIAlertController(title: "Error", message: "This movie is already in your lis", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true)
            mainView.nameOfMovie.text = ""
            mainView.yearOfMovie.text = ""
            
        }else{
            viewModel.writeMovie(name: name, year: year)
            mainView.nameOfMovie.text = ""
            mainView.yearOfMovie.text = ""
            viewModel.readMovie{ (movies) in
                print(movies)
                
                self.cellText = movies
                self.mainView.tableView.reloadData()

            }
            
        }

    }
   

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainView.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let movieItem = cellText[indexPath.row]
        cell.textLabel?.text = movieItem
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellText.count
    }
    
}
