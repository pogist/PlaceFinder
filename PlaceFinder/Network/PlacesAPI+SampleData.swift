//
//  PlacesAPI+SampleData.swift
//  PlaceFinder
//
//  Created by Murilo da Paixão on 12/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import Foundation
import UIKit

/**
 Adds an example of a real json response to PlacesAPI for testing purposes.
 Unfortunately there are some issues about leaving this big (and ugly) json in a separated file.
 
 - See more about this issue here: https://github.com/Moya/Moya/issues/866#issuecomment-269689502
 */
extension PlacesAPI {
    
    var sampleData: Data {
        switch self {
            
        case .searchNearestPlacesBy(_, _):
            let sampleDataString = """
{"html_attributions":[],"next_page_token":"CrQCJQEAAE16Q_TLaFbdNm0C1l6xGpXeOfxghCrwOH1cS1RQ6kTc8mTBX_2RGTvPnyNqudtllfN-nDne83yGTmr2zHm3JrFVj-0vZu4E0MHlmnVM1hz6bb0NmSwIvIXC_yTo0bWZYHO9WN5o_6wbSG-eHEaBpLMVyyCkqueoZ7O9785-NkAmoRPAlIhkbce3BwODtTRQdEhWh864b6H4R9pOelIjuHqMv3idkHDpmFZKL1GEB2ovrgrl45WBENthzLkR00vdReOZyTSVPhuMxiR1vQicgMpYWQAeG8X1W_f2qP1Pvieitrg78RJ2umfYYMZFvPZvVaHVcDkJDG0d014AkaIw05IdHo7DLJLlXoRCff3lJSwf1gcpf0rfe_F8iJ52rEtArix8pA7Pcg2CA7y2JQ0nO0USEHnaBJs77WRgRv3zPIgPa58aFB114-FyUo60QteRpnWNPamihME8","results":[{"geometry":{"location":{"lat":-3.7865296,"lng":-38.5190663},"viewport":{"northeast":{"lat":-3.785132420107278,"lng":-38.51770852010728},"southwest":{"lat":-3.787832079892722,"lng":-38.52040817989272}}},"icon":"https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png","id":"5d7f71665a02b5df11f81047d3eab5f8f34cd05b","name":"Farmácia Santana","opening_hours":{"open_now":true},"photos":[{"height":3096,"html_attributions":["<a href=\\\"https://maps.google.com/maps/contrib/115384212648421511704/photos\\\">Assis Duarte</a>"],"photo_reference":"CmRaAAAAek1hoa9tJhmmld3Ni_PE5v0HKCIGd4O536Fkkx9YsokS41a29G6e9rO4qfd8Q5Fc4LHsJTdvPJxR3CcEyyl-ryzSx5IcO-6ztNg5-H_8GZ4IwaqdBU-Vs6HITdj9O5W8EhDPb6hql0Ag2hDMpjrzQ0-BGhTIoS5_d9RePZ_hC_xVNMXcjDpysg","width":4128}],"place_id":"ChIJM4z_7FdUQQURJkcqZcsQyRA","plus_code":{"compound_code":"6F7J+99 Fortaleza - Zone 1, Fortaleza - CE, Brasil","global_code":"69836F7J+99"},"rating":4.5,"reference":"CmRbAAAAClQiL6oXen23qME_Al7odiX8QISWbOiSaJUMQLlWykIAmSv2lJt06Sur6z3SDggkRbDf1pirUTe5rnI-xJY9nyiRakc3KwNX1RvR7wSWb152Xsyielfc4q3ZPtu0-wPHEhD_BORvQGhSUR1d0Yi5x2LUGhRFjucY9_cnrNZhn2gVOb3OpLDarw","scope":"GOOGLE","types":["pharmacy","store","health","point_of_interest","establishment"],"vicinity":"R. Pedro Dantas, 217 - Dias Macedo, Fortaleza"},{"geometry":{"location":{"lat":-3.8010023,"lng":-38.5297916},"viewport":{"northeast":{"lat":-3.799698420107279,"lng":-38.52856007010728},"southwest":{"lat":-3.802398079892722,"lng":-38.53125972989272}}},"icon":"https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png","id":"062c8b8c7f418b5a441cf48c89e65233d96e1cb9","name":"Farmácias Pague Menos","opening_hours":{"open_now":true},"photos":[{"height":1836,"html_attributions":["<a href=\\\"https://maps.google.com/maps/contrib/103497812772037419476/photos\\\">Daniel Mello</a>"],"photo_reference":"CmRaAAAA7bX_HNE_GpypAAbI8kb-pCKz6HuvcJ9te7WjtC2M9Y1uqI9ggDr9YLO9gDsA3XE9nJWhPWDStinCAvBV-0QEGpFjZd9CCMPmnpEiIDkAqdTuU3vdQ88tUmk2oxFUO1n6EhDCR9NIlSqBYa3yJfdmCapeGhSoMiMwjiC7b_BFzlQdOeifYKCHJQ","width":3264}],"place_id":"ChIJl0Q4q1VOxwcRgxOualGL_r0","plus_code":{"compound_code":"5FXC+H3 Fortaleza - Zone 1, Fortaleza - CE, Brasil","global_code":"69835FXC+H3"},"rating":3.4,"reference":"CmRbAAAAyF6R3A6W8MAoLoDpUSi6KFmjvpIecla_eWIrCo5j43qLYmWrBWLoQ1wHkZllJQn8jRLFCGNUnOt014j3LLoJbihu976d1Uox1DGWizJEVOJ62ir-5mZ_1pxEN_-2VlAmEhDljsyS61n-1bBHpeUeyPZaGhQ3bDwfytbJC3SLJVK_3ehJzehyug","scope":"GOOGLE","types":["store","health","point_of_interest","establishment"],"vicinity":"Av. Dr. Silas Munguba, 5571 - Boa Vista, Fortaleza"},{"geometry":{"location":{"lat":-3.7991587,"lng":-38.5033375},"viewport":{"northeast":{"lat":-3.797808870107277,"lng":-38.50198767010728},"southwest":{"lat":-3.800508529892721,"lng":-38.50468732989273}}},"icon":"https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png","id":"a56146df1ae7c40936652ade19ddbba8e20bf81e","name":"Extrafarma","opening_hours":{"open_now":true},"photos":[{"height":1536,"html_attributions":["<a href=\\\"https://maps.google.com/maps/contrib/101816461809278830444/photos\\\">helio sousa</a>"],"photo_reference":"CmRaAAAAjrFBcADVDN6pVLFtMtxHtt6BTfT5mUqRcinEFjapBLQWPxw7hBvffRhgmgYpYVsg5Rq50v9uBhvvk7Qz55AhB65a4S5Bzak5kokc_CO7RN_QCDjqbU9KIUCz4QX6Mm1DEhB3tfKrtsqnYH-MIOb2ASfPGhSdSHQ32hbtf_pTMbjRygVRG-xWXQ","width":2048}],"place_id":"ChIJSfkGB3VPxwcR4alTyTkiTtE","plus_code":{"compound_code":"6F2W+8M Fortaleza - Zone 1, Fortaleza - CE, Brasil","global_code":"69836F2W+8M"},"rating":4.1,"reference":"CmRbAAAAeH4uH-was5IoxvXUtp4T4n6D2fIy0d-D6czXZOVCDUKjLaa7ILm_nn-fa16SXeJdr_qtFCOgT2yLhwxJCyOpnZ0O9mg924d519SemblNSW5dwZHwlDfo8C8sliqP8PMkEhCQJzv7jN4bIDiROGJuX0MsGhSHmMnWzX9XzY8YjIEita6HyJoizQ","scope":"GOOGLE","types":["store","health","point_of_interest","establishment"],"vicinity":"Avenida Oliveira Paiva, 170 - Oliveira Paiva II - Cidade Dos Funcionário, Fortaleza"}],"status":"OK"}
"""
            
            return sampleDataString.data(using: .utf8)!
            
        case .photo(_, _):
            let testingImage = UIImage(named: "pharmacy-testing-image")!
            return UIImageJPEGRepresentation(testingImage, 1.0)!
        }
    }
}
