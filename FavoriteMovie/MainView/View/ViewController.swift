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
        var movieList = convertToMovieModel(array: cellText)
        var movieItem = MovieModel.init(movie: name, year: year)
        
        if movieList.contains(movieItem){
            print("error")
            let alert = UIAlertController(title: "Error", message: "This movie is already in your lis", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true)
            mainView.nameOfMovie.text = ""
            mainView.yearOfMovie.text = ""

        }else{
            viewModel.writeMovie(movie: movieItem)
            mainView.nameOfMovie.text = ""
            mainView.yearOfMovie.text = ""
            self.cellText.append(FirebaseModel(movie: name, year: year, key: ""))
            self.mainView.tableView.beginUpdates()
            self.mainView.tableView.insertRows(at: [IndexPath.init(row: self.cellText.count-1, section: 0)], with: .automatic)
            self.mainView.tableView.endUpdates()
            
            
        }

    }
    func convertToMovieModel(array: [FirebaseModel]) -> [MovieModel]{
       var result = [MovieModel]()
        for i in array{
            result.append(MovieModel(movie: i.movie, year: i.year))
        }
        return result
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
