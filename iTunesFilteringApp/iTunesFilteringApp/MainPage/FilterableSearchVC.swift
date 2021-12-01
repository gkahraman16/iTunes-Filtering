//
//  ViewController.swift
//  HBCase
//
//  Created by Gozde Kahraman on 10.11.2021.
//

import UIKit
import RxSwift
import RxCocoa

class FilterableSearchVC: UIViewController {
    private let viewModel = FilterableSearchVM()
    let disposeBag = DisposeBag()
    
    @IBOutlet var loadingView: UIActivityIndicatorView!
    @IBOutlet var searchField: UISearchBar!
    @IBOutlet var typeSegmentedControl: UISegmentedControl!
    @IBOutlet var errorView: ErrorView! {
        didSet {
            errorView.isHidden = true
        }
    }
    
    @IBOutlet var resultsCV: UICollectionView! {
        didSet {
            resultsCV
                .register(UINib(nibName: String(describing: ItemViewCell.self), bundle: nil),
                          forCellWithReuseIdentifier: "ItemViewCell")
           
            resultsCV.allowsSelection = true
            viewModel.items
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] _ in
                        self?.resultsCV.reloadData()})
                .disposed(by: disposeBag)
        }
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "iSearch"
        bind()
    }

    func bind() {
        bindSearch()
        bindSegmentSelection()
        bindWarningView()
    }
   
    func bindSearch() {
        searchField.searchTextField.rx.controlEvent(.editingChanged)
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .map { self.searchField.text }
            .subscribe(onNext: { [weak self] text in
                self?.viewModel.searchText.accept(text)
            }).disposed(by: disposeBag)
    }
    
    func bindSegmentSelection() {
        typeSegmentedControl.rx.controlEvent(.valueChanged)
            .asObservable()
            .map { self.typeSegmentedControl.selectedSegmentIndex }
            .subscribe(onNext: { [weak self] index in
                let filter = self?.typeSegmentedControl.titleForSegment(at: index)?.lowercased()
                self?.viewModel.selectedFilter.accept(filter)
            }).disposed(by: disposeBag)

    }
    
    func bindWarningView() {
        viewModel.pageStatus
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] status in
                switch status {
                case .error:
                    self?.errorView.isHidden = false
                    self?.errorView.errorStyle = ErrorStyle.error.rawValue
                    self?.resultsCV.isHidden = true
                    self?.loadingView.stopAnimating()
                case .noResult:
                    self?.errorView.isHidden = false
                    self?.errorView.errorStyle = ErrorStyle.noResult.rawValue
                    self?.resultsCV.isHidden = true
                    self?.loadingView.stopAnimating()
                case .success:
                    self?.errorView.isHidden = true
                    self?.resultsCV.isHidden = false
                    self?.loadingView.stopAnimating()
                case .loading:
                    self?.errorView.isHidden = true
                    self?.resultsCV.isHidden = false
                    self?.loadingView.startAnimating()
                }
                
            })
            .disposed(by: disposeBag)
    }
}

extension FilterableSearchVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.value?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemViewCell", for: indexPath) as! ItemViewCell
        guard let item = viewModel.items.value?[indexPath.row] else { return cell }
        cell.configure(with: item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedItem = viewModel.items.value?[indexPath.row] else { return }
        let vm = ItemDetailVM(item: selectedItem)
        let vc = ItemDetailVC()
        vc.viewModel = vm
        navigationController?.pushViewController(vc, animated: false)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let numberOfItems = viewModel.items.value?.count, indexPath.row == numberOfItems - 1, numberOfItems % 20 == 0 {
            viewModel.filterSearchResults(with: viewModel.searchText.value, mediaType: viewModel.selectedFilter.value, limit: numberOfItems + 20)
        }
    }
}

extension FilterableSearchVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.resultsCV.frame.width / 2 - 24
        let height: CGFloat = 280.0
        return CGSize(width: width, height: height)
    }
}

