//
//  RegionCell.swift
//  RegionsListOptimised
//
//  Created by Anup Kuriakose on 27/11/2023.
//

import UIKit

class RegionCell: UITableViewCell {
    let globeImgView = UIImageView()
    let selectTickImgView = UIImageView()
    var regionNameLbl = UILabel()
    let separatorLine = UIView()
    var globeImgGreen = UIImage(systemName: "globe.asia.australia.fill")?.withTintColor(.green, renderingMode: .alwaysOriginal)
    var globeImgGray = UIImage(systemName: "globe.asia.australia.fill")?.withTintColor(.systemGray5, renderingMode: .alwaysOriginal)
    let selectTickImg = UIImage(systemName: "checkmark")

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Add all elements in the TableView Cell
        setUpSubViews()

        // Add Initial images into ImageViews
        initialiseImagesandLabels()

        // Setup All constraints
        setUpGlobeImageViewConstraints()
        setUpRegionNameLblConstraints()
        setUpSelectImgViewConstraints()
        setUpSeparatorLineConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Subviews

    // Setup SubViews
    private func setUpSubViews() {
        contentView.addSubview(globeImgView)
        contentView.addSubview(regionNameLbl)
        contentView.addSubview(selectTickImgView)
        contentView.addSubview(separatorLine)
    }

    // MARK: - Initialize Images and Labels

    private func initialiseImagesandLabels() {
        globeImgView.image = globeImgGray
        selectTickImgView.image = selectTickImg?.withTintColor(.green, renderingMode: .alwaysOriginal)
        selectTickImgView.isHidden = true
        regionNameLbl.font = .systemFont(ofSize: 16)
    }

    // MARK: - Setup All Constraints

    // GlobeImgView Constraints
    private func setUpGlobeImageViewConstraints() {
        globeImgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            globeImgView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            globeImgView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            globeImgView.heightAnchor.constraint(equalToConstant: 30),
            globeImgView.widthAnchor.constraint(equalToConstant: 30),
        ])
    }

    // RegionNameLbl Constraints
    private func setUpRegionNameLblConstraints() {
        regionNameLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            regionNameLbl.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 10),
            regionNameLbl.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            regionNameLbl.leftAnchor.constraint(equalTo: globeImgView.rightAnchor, constant: 20),
            regionNameLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    // SelectImgView Constraints
    private func setUpSelectImgViewConstraints() {
        selectTickImgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectTickImgView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            selectTickImgView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            selectTickImgView.heightAnchor.constraint(equalToConstant: 25),
            selectTickImgView.widthAnchor.constraint(equalToConstant: 25)
        ])
    }

    // SeparatorLine Constraints
    private func setUpSeparatorLineConstraints() {
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.backgroundColor = .systemGray5
        NSLayoutConstraint.activate([
            separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorLine.leftAnchor.constraint(equalTo: globeImgView.rightAnchor, constant: 5),
            separatorLine.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 0.6)
        ])
    }

    // MARK: - Configure Cell

    func configure(viewModel: RegionsViewModel, index: Int) {
        //let regionName = viewModel.regionsLoadingData[index].name.regionName
        let regionName = viewModel.getRegionNameFromLoadingWithIndex(index: index)
        let cellSelectedStatus = viewModel.regionsLoadingData[index].isSelected

        regionNameLbl.text = regionName

        globeImgView.image = cellSelectedStatus ? globeImgGreen : globeImgGray
        selectTickImgView.isHidden = !cellSelectedStatus
        regionNameLbl.font = cellSelectedStatus ? .boldSystemFont(ofSize: 16) : .systemFont(ofSize: 16)
    }
}

