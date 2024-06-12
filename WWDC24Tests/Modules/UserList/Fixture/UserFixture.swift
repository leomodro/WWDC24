//
//  UserFixture.swift
//  WWDC24
//
//  Created by Leonardo Modro on 12/06/24.
//

@testable import WWDC24

extension User {
    static func fixture(id: Int = 1,
                        firstName: String = "John",
                        lastName: String = "Doe",
                        age: Int = 27,
                        gender: Gender = .male,
                        role: User.Role = .user) -> Self {
        .init(id: id, firstName: firstName, lastName: lastName, age: age, gender: gender, role: role)
    }
}
