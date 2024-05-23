//
//  SelectProductCountPresenter.swift
//  MarketPlace
//
//  Created by Nikita Marin on 09.07.2023.
//

import UIKit

// MARK: - SelectProductCountPresenter
final class SelectProductCountPresenter {
    weak var view: SelectProductCountViewInput?
    private var output: SelectProductCountPresenterOutput?
    private let cartService: CartService
    
    private var selectedProductInfo: ProductInCartInfo
    private var selectedCount: Int
    private var previousIndexPath: IndexPath?
    
    init(
        output: SelectProductCountPresenterOutput?,
        cartService: CartService,
        productLocalDataSources: ProductLocalDataSources
    ) {
        self.output = output
        self.cartService = cartService
        self.selectedCount = productLocalDataSources.getSelectedProductInCartInfo().count
        self.selectedProductInfo = productLocalDataSources.getSelectedProductInCartInfo()
    }
    
    deinit {
        print("deinit Select Product Count presenter")
    }
}

// MARK: - SelectProductCountViewOutput
extension SelectProductCountPresenter: SelectProductCountViewOutput {
    func getTableRowCount() -> Int {
        return 9
    }
    
    func getRemainCount() -> Int {
        return selectedProductInfo.product.quantity
    }
    
    func configureCell(
        _ cell: UITableViewCell,
        at indexPath: IndexPath
    ) {
        cell.textLabel?.text = "\(indexPath.item + 1)"
        if indexPath.item + 1 == selectedCount {
            previousIndexPath = indexPath
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    func selectCount(at indexPath: IndexPath) {
        view?.clearTextField()
        selectedCount = indexPath.item + 1
        DispatchQueue.main.async { [weak view, previousIndexPath] in
            if let previousIndexPath = previousIndexPath {
                view?.reloadCount(at: [
                    previousIndexPath,
                    indexPath
                ])
            } else {
                view?.reloadCount(at: [indexPath])
            }
        }
    }
    
    func readyTapped(with count: String) {
        let intCount = Int(count) ?? selectedCount
        let remainCount = selectedProductInfo.product.quantity
        cartService.updateCount(
            count: intCount > remainCount ? remainCount : intCount,
            product: selectedProductInfo
        )
        output?.goToCartModule()
    }
    
    func handleTextInput(_ text: String) {
        if let number = Int(text) {
            view?.setUncheck(at: [0, selectedCount - 1])
            selectedCount = number
        } else {
            selectedCount = 1
            previousIndexPath = [0, selectedCount - 1]
            view?.setCheck(at: [0, selectedCount - 1])
        }
    }
    
    func deinitEvent() {
        output?.moduleDidUnload()
    }
}
