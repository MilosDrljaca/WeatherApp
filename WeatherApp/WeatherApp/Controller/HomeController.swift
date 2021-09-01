//
//  ViewController.swift
//  WeatherApp
//
//  Created by aleksandar.aleksic on 31.8.21..
//

import UIKit

class HomeController: UIViewController {
    
    lazy var homePresenter = HomePresenter(viewController: self)
    
    @IBOutlet var cityListTableView: UITableView!
    @IBOutlet var inputTextSearch: UITextField!
    @IBOutlet var selectedCity: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataPreparation.getlocationWeatherData()
        getSelectedCity()
    }
    
    private func getSelectedCity(){
        if let city = ManageCoreData.retriveCity(){
            DataPreparation.selectedCity = city
            selectedCity.text = city.title
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inputTextSearch.addTarget(self, action: #selector(changedValue), for: .editingChanged)
    }
   
    @objc func changedValue(_ textField: UITextField){
        if let word = textField.text{
            DataPreparation.getCityListData(with: word)
            homePresenter.cityList = DataPreparation.cityList.filter { city in
                city.title.contains(word)
            }
        }
        
        cityListTableView.reloadData()
    }

}

extension HomeController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homePresenter.getCityListSize()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cityListTableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        cell.textLabel?.text = homePresenter.getCity(position: indexPath.row).title

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCity.text = homePresenter.getCity(position: indexPath.row).title
        ManageCoreData.storeCity(city: homePresenter.getCity(position: indexPath.row))
        DataPreparation.selectedCity = ManageCoreData.retriveCity()
    }
}
