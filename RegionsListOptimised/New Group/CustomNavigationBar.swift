//
//  CustomNavigationBar.swift
//  RegionsListOptimised
//
//  Created by Anup Kuriakose on 23/11/2023.
//

import UIKit

// MARK: - CustomNavigationBarDelegate Protocol

protocol CustomNavigationBarDelegate: AnyObject {
    func customNavigationBarDoneButtonTapped(_ navigationBar: CustomNavigationBar)
    func customNavigationBarBackButtonTapped(_ navigationBar: CustomNavigationBar)
}

// MARK: - CustomNavigationBar Class

class CustomNavigationBar: UIView {

    let searchBar = UISearchBar()
    let navigationBar = UINavigationBar()
    var navigationItem = UINavigationItem()
    var doneButton = UIBarButtonItem()
    var backButtonImage: UIImage!
    var doneLabel = UILabel()
    weak var delegate: CustomNavigationBarDelegate?

    // MARK: - Initialization Functions

    // Override Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)

        // Add SubViews
        addSubview(navigationBar)
        addSubview(searchBar)

        // SetUp NavigationBar and Constraints
        setUpNavigationBar()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Function to setUpNavigationBar
    func setUpNavigationBar() {
        setUpNavigationBarBackground()
        setUpDoneButton()
        setUpBackButton()
    }

    // Function to setUpNavigationBackground
    private func setUpNavigationBarBackground() {
        navigationBar.backgroundColor = .white
        navigationBar.isTranslucent = false
        navigationBar.setItems([navigationItem], animated: false)
    }

    // Function to setUpDoneButton
    private func setUpDoneButton() {
        doneLabel.text = "Done"
        doneLabel.textColor = .systemGreen
        let doneButtonTapGesture = UITapGestureRecognizer(target: self, action: #selector(doneButtonTapped))
        doneLabel.isUserInteractionEnabled = true
        doneLabel.addGestureRecognizer(doneButtonTapGesture)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneLabel)
    }

    // Function to setUpBackButton
    private func setUpBackButton() {
        backButtonImage = UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
    }

    // SetUp Constraints Function
    func setUpConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.translatesAutoresizingMaskIntoConstraints = false

        // SetUp Navigation Bar Constraints
        NSLayoutConstraint.activate([
            navigationBar.leftAnchor.constraint(equalTo: leftAnchor),
            navigationBar.rightAnchor.constraint(equalTo: rightAnchor),
            navigationBar.topAnchor.constraint(equalTo: topAnchor)
        ])

        // SetUp SearchBar Constraints
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - CustomNavigationBar Protocol and Other Call functions

extension CustomNavigationBar {

    // Selector function to respond to doneButtonTapped
    @objc func doneButtonTapped() {
        delegate?.customNavigationBarDoneButtonTapped(self)
    }

    // Selector function to respond to backButtonTapped
    @objc func backButtonTapped() {
        delegate?.customNavigationBarBackButtonTapped(self)
    }

    // Function called to set SearchBar delegate from another class
    func setSearchBarDelegate(delegate: UISearchBarDelegate) {
        searchBar.delegate = delegate
    }

    // Function called to set NavigationItemTitle
    func setUpNavigationItemTitle(title: String) {
        navigationItem.title = title
    }

    // Function to clear SearchBar
    func clearSearchBar() {
        searchBar.text = ""
    }
}
