//
//  ViewController.swift
//  WeatherApp
//
//  Created by aleksandar.aleksic on 31.8.21..
//

import UIKit
import CoreLocation

class HomeController: UIViewController {
    
    lazy var homePresenter = HomePresenter(viewController: self)
    var locManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    @IBOutlet var cityListTableView: UITableView!
    @IBOutlet var inputTextSearch: UITextField!
    @IBOutlet var selectedCity: UILabel!
    @IBOutlet var locationButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        locManager.requestWhenInUseAuthorization()
        getSelectedCity()
    }
    
    @IBAction func clicked(_ sender: Any) {
        switch locManager.authorizationStatus{
        case .restricted, .denied:
            currentLocation = nil
        default:
            currentLocation = locManager.location
        }
        
        if let coordinate = currentLocation?.coordinate{
            DataPreparation.getCityListByLattLongData(latitude: coordinate.latitude, longitude: coordinate.latitude) { [self] list in
                homePresenter.setCityList(cityList: list)
                DispatchQueue.main.async {
                    cityListTableView.reloadData()
                }
            }
        }
    }
    
    
    private func getSelectedCity(){
        if let city = ManageCoreData.retriveCity(){
            DataPreparation.selectedCity = city
            selectedCity.text = city.title
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataPreparation.getlocationWeatherData()
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
        let city = homePresenter.getCity(position: indexPath.row)
        ManageCoreData.storeCity(city: city)
        DataPreparation.selectedCity = city
    }
}
