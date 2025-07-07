//
//  BrandInMapViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 07.07.25.
//

import UIKit
import MapKit

final class BrandInMapViewController: BaseViewController<BrandInMapViewModel> {
    
    private let mapView: MKMapView = {
        let view = MKMapView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = viewModel.fetchData()
        
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: data.coordinates, span: span)
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = data.coordinates
        pin.title = data.name
        mapView.addAnnotation(pin)
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
