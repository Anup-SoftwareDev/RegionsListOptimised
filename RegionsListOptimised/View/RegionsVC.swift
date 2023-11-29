//
//  ViewController.swift
//  RegionsListOptimised
//
//  Created by Anup Kuriakose on 23/11/2023.
//

import UIKit

class RegionsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, CustomNavigationBarDelegate {
    
      let tableView = UITableView()
      let customNavigationBar = CustomNavigationBar()
      let viewModel = RegionsViewModel()
      
   
     
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
        setUpTableView()
        setUpCustomNavigationBar()
        viewModel.initialiseRegionsData()
    }
    
    // Setup Subviews
    private func setUpSubViews(){
        view.addSubview(customNavigationBar)
        view.addSubview(tableView)
    }
    
    // Setup Table View
    private func setUpTableView() {
        // Setup Tableview delegate and DataSource
        tableView.delegate = self
        tableView.dataSource = self
        
        //Setup TableView Cells
        tableView.register(RegionCell.self, forCellReuseIdentifier: "RegionCell")
        tableView.separatorStyle = .none
        
        //Setup TableView Constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    // SetUpCustomNavigationBar Function
    private func setUpCustomNavigationBar(){
        
        //Setup CustomNavigationBar
        customNavigationBar.setUpNavigationItemTitle(title: "Select region")
        customNavigationBar.setSearchBarDelegate(delegate: self)
        customNavigationBar.delegate = self
        
        //Setup CustomNavigationBar Constraints
        customNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customNavigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            customNavigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            customNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
    }

}

// MARK: - CustomNavigationBar Functions
extension RegionsVC {
    
    // Protocol function for BarDone Button
    func customNavigationBarDoneButtonTapped(_ navigationBar: CustomNavigationBar) {
        let selectedRegionIndex = viewModel.getIndexOfSelectedItem()
        guard let validIndex = selectedRegionIndex else {
            presentMsgFunction(title: "No Selection", message: "Please Select a Region")
            return
        }
        presentMsgFunction(title: "Region Selected", message: viewModel.getRegionNameFromOrignalWithIndex(index: validIndex))
    }
    
    // Protocol function for BarBackButton
    func customNavigationBarBackButtonTapped(_ navigationBar: CustomNavigationBar) {
        viewModel.backResetButtonClicked()
        customNavigationBar.clearSearchBar()
        tableView.reloadData()
    }
    
    // SearchBar function to handle response to text input in searchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.tableViewFiltering(searchBarText: searchText)
        tableView.reloadData()
    }
    
    // Function to present Message to user when Regured
    func presentMsgFunction(title: String, message: String){
        let msgBox = UIAlertController(title: title, message: message, preferredStyle: .alert)
        msgBox.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(msgBox, animated: true)
    }
    
}

// MARK: - TableView Delegate and DataSource Functions

extension RegionsVC {
    
    // Function to Set the number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.regionsLoadingData.count
    }
    
    // Function to configure each cell in Table View
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionCell", for: indexPath) as! RegionCell
        cell.configure(viewModel: viewModel, index: indexPath.row)
        return cell
    }
    
    // Function that reseponds to selection or deselection of tableView Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellSelectAction(index: indexPath.row)
        tableView.reloadData()
    }
    
}

