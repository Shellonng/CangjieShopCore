package CangjieShopCore.models

import serialization.serialization.*
import std.core.Exception

public enum ResultStatus <: Equatable<ResultStatus> {
    | SUCCESS | FAILURE | EXCEPTION

    public func toInt64(): Int64 {
        return match (this) {
            case SUCCESS => -1
            case FAILURE => -2
            case EXCEPTION => -3

        }
    }

    public static func fromInt64(value: Int64): ResultStatus {
        return match (value) {
            case -1 => SUCCESS
            case -2 => FAILURE
            case -3 => EXCEPTION

            case _ => throw Exception("Invalid Result Status")
        }
    }

    public operator func ==(that: ResultStatus): Bool {
        return this.toInt64() == that.toInt64()
    }

    public operator func !=(that: ResultStatus): Bool {
        return !(this == that)
    }
}