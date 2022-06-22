//
//  ContentView.swift
//  DemoFirebaseAFPE
//
//  Created by Kelian Daste on 22/06/2022.
//

import SwiftUI
import FirebaseDatabase

struct ContentView: View {

    @State var carList: [Car] = []
    var body: some View {
        VStack {
            ForEach(carList) { car in
                VStack {
                    AsyncImage(url: URL(string: car.image)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 200, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                    .overlay {
                        VStack {
                            Spacer()
                            Text("\(car.brand) \(car.model)")
                                .foregroundColor(.white)
                        }
                    }
                    
                }
                
            }
            Spacer()
            Button("Ajouter Voiture"){
                addCar()
            }
            .buttonStyle(.borderedProminent)
        }
        .onAppear{
            getCars()
        }
    }
    
    func getCars(){
        let ref = Database.database().reference()
        ref.child("carList").observe(.value, with: { snapshot in
            carList.removeAll()
            if let value = snapshot.value as? [[String: Any]] {
                for car in value {
                    let brand = car["brand"] as? String ?? "No brand"
                    let model = car["model"] as? String ?? "No model"
                    let color = car["color"] as? String ?? "No color"
                    let kms = car["kms"] as? Int ?? 0
                    let isGas = car["isGas"] as? Bool ?? true
                    let image = car["image"] as? String ?? ""
                    let year = car["year"] as? Int ?? 2000

                    let newCar = Car(brand: brand,
                                     model: model,
                                     color: color,
                                     image: image,
                                     isGas: isGas,
                                     kms: kms,
                                     year: year)
                    carList.append(newCar)
                }
            }
        })
    }
    
    func addCar(){
        
        let car = Car(brand: "BMW",
                      model: "M4",
                      color: "Bleu",
                      image: "https://www.largus.fr/images/images/bmw-m4-cs-1.jpg",
                      isGas: false,
                      kms: 10000,
                      year: 2015)
        var newCarList = carList.map { $0.toDict()}
        newCarList.append(car.toDict())
        
        let ref = Database.database().reference()
        ref.child("carList").setValue(newCarList)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Car: Identifiable {
    var id = UUID()
    var brand: String
    var model: String
    var color: String
    var image: String
    var isGas: Bool
    var kms: Int
    var year: Int
    
    func toDict() -> [String: Any] {
        return [
            "brand": brand,
            "model": model,
            "color": color,
            "image": image,
            "isGas": isGas,
            "kms": kms,
            "year": year
        ]
    }
}
