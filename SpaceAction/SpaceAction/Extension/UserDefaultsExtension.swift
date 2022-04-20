//
//  UserDefaultsExtension.swift
//  SpaceAction
//
//  Created by A on 4/13/22.
//

import Foundation

extension UserDefaults {
    //T - generic - любой тип данных. Encodable отвечает за сохранение упакованного контейнера
    func set<T: Encodable>(encodable: T, forKey key: String) {
        //класс JSONEncoder пытается объект превратить в Data и размещает Data по ключу
            if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    //Decodable отвечает за распаковку объекта, который хранится в памяти, и превращение его в объект
     func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
         //Decodable пытается получить Data из UserDefaults по ключу
        if let data = object(forKey: key) as? Data,
           //JSONDecoder пытается превратить Data в нужный тип и вернуть его значение либо nil
            let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}
