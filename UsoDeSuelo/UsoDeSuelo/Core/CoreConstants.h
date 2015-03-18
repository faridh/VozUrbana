//
//  CoreConstants.h
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#ifndef UsoDeSuelo_CoreConstants_h
#define UsoDeSuelo_CoreConstants_h

#ifdef DEBUG
#define kBackendURL @"stage.api.com"
#endif
#ifdef PRODUCTION
#define kBackendURL @"api.com"
#endif
#define kBackendPort @"80"

#define kErrorTitle @"Error"
#define kErrorMessageNoNetwork @"No hay una conexión disponible a Internet."

#endif
