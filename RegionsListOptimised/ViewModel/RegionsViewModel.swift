//
//  RegionsViewModel.swift
//  RegionsListOptimised
//
//  Created by Anup Kuriakose on 27/11/2023.
//

import UIKit

struct regionData {
    var name: Regions
    var isSelected = false
}

class RegionsViewModel {
    
    var regionsOriginalData: [regionData] = []
    var regionsLoadingData: [regionData] = []
    
    // Function called during initialisation of RegionsData
    func initialiseRegionsData() {
        initialiseRegionsOriginalData()
        regionsLoadingData = regionsOriginalData
    }
    
    // Function called for initializing regionsOriginalData array
    func initialiseRegionsOriginalData() {
        for regionName in regionNames {
            regionsOriginalData.append(regionData(name: Regions(regionName: regionName)))
        }
    }
    
    // Function called to set all isSelected values in the array to False
    func setArrayValuesFalse(array: inout [regionData]) {
        for index in array.indices {
            array[index].isSelected = false
        }
    }
    
    // Function called to updated regionsOriginalData Array with values form regionsLoadingDataArray
    func updateOriginalDataWithLoading(regionName: String, isSelectedValue: Bool) {
        setArrayValuesFalse(array: &regionsOriginalData)
        for index in regionsOriginalData.indices {
            if regionsOriginalData[index].name.regionName == regionName {
                regionsOriginalData[index].isSelected = !isSelectedValue
            }
        }
    }
    
    // Function called when TableView cell is selected
    func cellSelectAction(index: Int) {
        let isSelectedPreviousState = regionsLoadingData[index].isSelected
        let nameSelected =  regionsLoadingData[index].name.regionName
        setArrayValuesFalse(array: &regionsLoadingData)
        regionsLoadingData[index].isSelected = !isSelectedPreviousState
        updateOriginalDataWithLoading(regionName: nameSelected, isSelectedValue: isSelectedPreviousState)
    }
    
    // Function to filter Table based on searchbar text
    func tableViewFiltering(searchBarText: String) {
        let filteredData = regionsOriginalData.filter { $0.name.regionName.lowercased().contains(searchBarText.lowercased()) }
        regionsLoadingData = searchBarText == "" ? regionsOriginalData : filteredData
    }
    
    // Function to return index of a particular element in the regions Original Data array
    func getIndexOfSelectedItem() -> Int? {
        let index = regionsOriginalData.firstIndex { regionData in
            regionData.isSelected == true }
        return index
    }
    
    // Function to return the Region name for selected cell in the Table View
    func getRegionNameFromOrignalWithIndex(index: Int) -> String {
        let regionName = regionsOriginalData[index].name.regionName
        return regionName
    }
    
    // Function to return the Region name for selected cell in the Table View
    func getRegionNameFromLoadingWithIndex(index: Int) -> String {
        let regionName = regionsLoadingData[index].name.regionName
        return regionName
    }
    // Function to respond back Reset button clicked.
    func backResetButtonClicked() {
        setArrayValuesFalse(array: &regionsOriginalData)
        regionsLoadingData = regionsOriginalData
    }
}
