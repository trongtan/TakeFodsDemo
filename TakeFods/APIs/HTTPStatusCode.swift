//
//  HTTPStatusCode.swift
//  TakeFods
//
//  Created by Tan Vu on 6/8/16.
//  Copyright © 2016 DevHack. All rights reserved.
//

import Foundation

enum HTTPStatusCode: Int {
  case OK = 200
  case BadRequest = 400
  case Unauthorized = 401
  case PaymentRequired = 402
  case Forbidden = 403
  case NotFound = 404
  case MethodNotAllowed = 405
  case NotAcceptable = 406
  case ProxyAuthenticationRequired = 407
  case RequestTimeout = 408
  case Conflict = 409
  case Gone = 410
  case LengthRequired = 411
  case PreconditionFailed = 412
  case PayloadTooLarge = 413
  case URITooLong = 414
  case UnsupportedMediaType = 415
  case RequestedRangeNotSatisfiable = 416
  case ExpectationFailed = 417
  case UnprocessableEntity = 422
  case Locked = 423
  case FailedDependency = 424
  case UpgradeRequired = 426
  case PreconditionRequired = 428
  case TooManyRequests = 429
  case RequestHeaderFieldsTooLarge = 431
  case InternalServerError = 500
  case NotImplemented = 501
  case BadGateway = 502
  case ServiceUnavailable = 503
  case GatewayTimeout = 504
  case HTTPVersionNotSupported = 505
  case VariantAlsoNegotiates = 506
  case InsufficientStorage = 507
  case LoopDetected = 508
  case NotExtended = 510
  case NetworkAuthenticationRequired = 511
}
