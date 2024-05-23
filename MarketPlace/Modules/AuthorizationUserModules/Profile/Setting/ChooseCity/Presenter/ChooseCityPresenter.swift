//
//  ChooseCityPresenter.swift
//  MarketPlace
//
//  Created by Nikita Marin on 07.07.2023.
//

import UIKit

// MARK: - ChooseCityPresenter
final class ChooseCityPresenter {
    weak var view: ChooseCityViewInput?
    private var output: ChooseCityPresenterOutput?
    private let daDataApiService: DaDataApiService
    private var loadedAreas: [Area] = []
    private var selectedArea: Area?
    private var previousIndexPath: IndexPath?
    
    init(
        output: ChooseCityPresenterOutput?,
        daDataApiService: DaDataApiService
    ) {
        self.output = output
        self.daDataApiService = daDataApiService
    }
    
    deinit {
        print("deinit Choose City Presenter")
    }
}

// MARK: - ChooseCityViewOutput
extension ChooseCityPresenter: ChooseCityViewOutput {
    func getCityCount() -> Int {
        loadedAreas.count
    }
    
    func configureCell(
        _ cell: UITableViewCell,
        at indexPath: IndexPath
    ) {
        cell.textLabel?.text = loadedAreas[indexPath.item].value
        if selectedArea?.value == loadedAreas[indexPath.item].value {
            previousIndexPath = indexPath
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    func selectCity(at indexPath: IndexPath) {
        selectedArea = loadedAreas[indexPath.item]
        DispatchQueue.main.async { [weak view, previousIndexPath] in
            if let previousIndexPath = previousIndexPath {
                view?.reloadCity(at: [
                    previousIndexPath,
                    indexPath
                ])
            } else {
                view?.reloadCity(at: [indexPath])
            }
        }
    }
    
    func handleTextInput(_ text: String) {
        daDataApiService.getPopulatedAreas(by: text) { [weak self] result in
            switch result {
            case .success(let response):
                self?.loadedAreas = response.suggestions
                DispatchQueue.main.async { [weak self] in
                    self?.view?.reloadData()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func backTapped() {
        output?.goToProfileModule()
    }
}
