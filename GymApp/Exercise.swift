//
//  Exercise.swift
//  GymApp
//
//  Created by Magnus Müller on 18.09.22.
//

import Foundation

// stores the data of a Exercise, perform to Codable -> decodable with JSONDecoder
struct Exercise: Identifiable, Codable{
    ///  identification of an instance
    var id: UUID = UUID()
    /// name of an exercise
    var name: String = "Exercise"
    /// stores a List of GymSets (default 2)
    var sets: [GymSet] = [GymSet(),GymSet()]
    
    func setAmt() -> Int{
        return sets.count

    }
    func getName() -> String{
        return name
    }
    func getLastSet() -> GymSet{
        if(self.setAmt()>0){
            return sets[self.setAmt()-1]
        }
        return GymSet()
    }
    
    
    mutating func removeLastSet() {
        sets.remove(at: sets.count-1)
    }
    // add a Set with default values
    mutating func addSet(weight: String?,repAmt: Int?) {
        sets.append(GymSet(weight: weight ?? "20.00", repAmt: repAmt ?? 8))
    }
    
}

// stores data of a Gymset
struct GymSet: Identifiable, Codable {
    /// identification of an instance
    var id = UUID()
    ///  weight of instance (default 20KG)
    var weight: String = "20.00"
    ///  rep amount of instance (default 8)
    var repAmt : Int = 8
}
