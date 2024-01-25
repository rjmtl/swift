//  Copyright (c) 2013-2023 Snowplow Analytics Ltd. All rights reserved.
//
//  This program is licensed to you under the Apache License Version 2.0,
//  and you may not use this file except in compliance with the Apache License
//  Version 2.0. You may obtain a copy of the Apache License Version 2.0 at
//  http://www.apache.org/licenses/LICENSE-2.0.
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the Apache License Version 2.0 is distributed on
//  an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
//  express or implied. See the Apache License Version 2.0 for the specific
//  language governing permissions and limitations there under.

import CoreGraphics
import Foundation

/// Configuration for the current user and device information that is tracked along with events.
@objc(SPSubjectConfigurationProtocol)
public protocol SubjectConfigurationProtocol: AnyObject {
    /// The custom UserID.
    @objc
    var userId: String? { get set }
    /// The network UserID.
    /// Note: It's not generated by the tracker, it needs to be filled by the developer when instrumenting the tracker.
    @objc
    var networkUserId: String? { get set }
    /// The domain UserID.
    /// Note: It's not generated by the tracker, it needs to be filled by the developer when instrumenting the tracker.
    @objc
    var domainUserId: String? { get set }
    /// The user-agent.
    /// Note: It's not generated by the tracker, it needs to be filled by the developer when instrumenting the tracker.
    @objc
    var useragent: String? { get set }
    /// The IP address.
    /// Note: It's not generated by the tracker, it needs to be filled by the developer when instrumenting the tracker.
    @objc
    var ipAddress: String? { get set }
    /// The current timezone.
    @objc
    var timezone: String? { get set }
    /// The language set in the device.
    @objc
    var language: String? { get set }
    /// The screen resolution.
    @objc
    var screenResolution: SPSize? { get set }
    /// The screen viewport.
    /// Note: It's not generated by the tracker, it needs to be filled by the developer when instrumenting the tracker.
    @objc
    var screenViewPort: SPSize? { get set }
    /// The color depth.
    /// Note: It's not generated by the tracker, it needs to be filled by the developer when instrumenting the tracker.
    @objc
    var colorDepth: NSNumber? { get set }
    
    // MARK: - GeoLocation

    /// Latitude value for the geolocation context.
    @objc
    var geoLatitude: NSNumber? { get set }
    /// Longitude value for the geo context.
    @objc
    var geoLongitude: NSNumber? { get set }
    /// LatitudeLongitudeAccuracy value for the geolocation context.
    @objc
    var geoLatitudeLongitudeAccuracy: NSNumber? { get set }
    /// Altitude value for the geolocation context.
    @objc
    var geoAltitude: NSNumber? { get set }
    /// AltitudeAccuracy value for the geolocation context.
    @objc
    var geoAltitudeAccuracy: NSNumber? { get set }
    /// Bearing value for the geolocation context.
    @objc
    var geoBearing: NSNumber? { get set }
    /// Speed value for the geolocation context.
    @objc
    var geoSpeed: NSNumber? { get set }
    /// Timestamp value for the geolocation context.
    @objc
    var geoTimestamp: NSNumber? { get set }
}

/// This class represents the configuration of the subject.
/// The SubjectConfiguration can be used to setup the tracker with the basic information about the
/// user and the app which will be attached on all the events as contexts.
/// The contexts to track can be enabled in the `TrackerConfiguration` class.
@objc(SPSubjectConfiguration)
public class SubjectConfiguration: SerializableConfiguration, SubjectConfigurationProtocol, ConfigurationProtocol {
    convenience init(dictionary: [String : Any]) {
        self.init()
        if let userId = dictionary["userId"] as? String { self.userId = userId }
        if let networkUserId = dictionary["networkUserId"] as? String { self.networkUserId = networkUserId }
        if let domainUserId = dictionary["domainUserId"] as? String { self.domainUserId = domainUserId }
        if let useragent = dictionary["useragent"] as? String { self.useragent = useragent }
        if let ipAddress = dictionary["ipAddress"] as? String { self.ipAddress = ipAddress }
        if let timezone = dictionary["timezone"] as? String { self.timezone = timezone }
        if let language = dictionary["language"] as? String { self.language = language }
    }

    @objc
    public override init() {
        super.init()
    }

    private var _userId: String?
    /// The custom UserID.
    @objc
    public var userId: String? {
        get { return _userId ?? sourceConfig?.userId }
        set { _userId = newValue }
    }

    private var _networkUserId: String?
    /// The network UserID.
    /// Note: It's not generated by the tracker, it needs to be filled by the developer when instrumenting the tracker.
    @objc
    public var networkUserId: String? {
        get { return _networkUserId ?? sourceConfig?.networkUserId }
        set { _networkUserId = newValue }
    }

    private var _domainUserId: String?
    /// The domain UserID.
    /// Note: It's not generated by the tracker, it needs to be filled by the developer when instrumenting the tracker.
    @objc
    public var domainUserId: String? {
        get { return _domainUserId ?? sourceConfig?.domainUserId }
        set { _domainUserId = newValue }
    }

    private var _useragent: String?
    /// The user-agent.
    /// Note: It's not generated by the tracker, it needs to be filled by the developer when instrumenting the tracker.
    @objc
    public var useragent: String? {
        get { return _useragent ?? sourceConfig?.useragent }
        set { _useragent = newValue }
    }

    private var _ipAddress: String?
    /// The IP address.
    /// Note: It's not generated by the tracker, it needs to be filled by the developer when instrumenting the tracker.
    @objc
    public var ipAddress: String? {
        get { return _ipAddress ?? sourceConfig?.ipAddress }
        set { _ipAddress = newValue }
    }

    private var _timezone: String?
    /// The current timezone.
    @objc
    public var timezone: String? {
        get { return _timezone ?? sourceConfig?.timezone }
        set { _timezone = newValue }
    }

    private var _language: String?
    /// The language set in the device.
    @objc
    public var language: String? {
        get { return _language ?? sourceConfig?.language }
        set { _language = newValue }
    }

    private var _screenResolution: SPSize?
    /// The screen resolution.
    @objc
    public var screenResolution: SPSize? {
        get { return _screenResolution ?? sourceConfig?.screenResolution }
        set { _screenResolution = newValue }
    }

    private var _screenViewPort: SPSize?
    /// The screen viewport.
    /// Note: It's not generated by the tracker, it needs to be filled by the developer when instrumenting the tracker.
    @objc
    public var screenViewPort: SPSize? {
        get { return _screenViewPort ?? sourceConfig?.screenViewPort }
        set { _screenViewPort = newValue }
    }

    private var _colorDepth: NSNumber?
    /// The color depth.
    /// Note: It's not generated by the tracker, it needs to be filled by the developer when instrumenting the tracker.
    @objc
    public var colorDepth: NSNumber? {
        get { return _colorDepth ?? sourceConfig?.colorDepth }
        set { _colorDepth = newValue }
    }

    // GeoLocation builders

    private var _geoLatitude: NSNumber?
    /// Latitude value for the geolocation context.
    @objc
    public var geoLatitude: NSNumber? {
        get { return _geoLatitude ?? sourceConfig?.geoLatitude }
        set { _geoLatitude = newValue }
    }

    private var _geoLongitude: NSNumber?
    /// Longitude value for the geo context.
    @objc
    public var geoLongitude: NSNumber? {
        get { return _geoLongitude ?? sourceConfig?.geoLongitude }
        set { _geoLongitude = newValue }
    }

    private var _geoLatitudeLongitudeAccuracy: NSNumber?
    /// LatitudeLongitudeAccuracy value for the geolocation context.
    @objc
    public var geoLatitudeLongitudeAccuracy: NSNumber? {
        get { return _geoLatitudeLongitudeAccuracy ?? sourceConfig?.geoLatitudeLongitudeAccuracy }
        set { _geoLatitudeLongitudeAccuracy = newValue }
    }

    private var _geoAltitude: NSNumber?
    /// Altitude value for the geolocation context.
    @objc
    public var geoAltitude: NSNumber? {
        get { return _geoAltitude ?? sourceConfig?.geoAltitude }
        set { _geoAltitude = newValue }
    }

    private var _geoAltitudeAccuracy: NSNumber?
    /// AltitudeAccuracy value for the geolocation context.
    @objc
    public var geoAltitudeAccuracy: NSNumber? {
        get { return _geoAltitudeAccuracy ?? sourceConfig?.geoAltitudeAccuracy }
        set { _geoAltitudeAccuracy = newValue }
    }

    private var _geoBearing: NSNumber?
    /// Bearing value for the geolocation context.
    @objc
    public var geoBearing: NSNumber? {
        get { return _geoBearing ?? sourceConfig?.geoBearing }
        set { _geoBearing = newValue }
    }

    private var _geoSpeed: NSNumber?
    /// Speed value for the geolocation context.
    @objc
    public var geoSpeed: NSNumber? {
        get { return _geoSpeed ?? sourceConfig?.geoSpeed }
        set { _geoSpeed = newValue }
    }

    private var _geoTimestamp: NSNumber?
    /// Timestamp value for the geolocation context.
    @objc
    public var geoTimestamp: NSNumber? {
        get { return _geoTimestamp ?? sourceConfig?.geoTimestamp }
        set { _geoTimestamp = newValue }
    }
    
    // MARK: - Internal
    
    /// Fallback configuration to read from in case requested values are not present in this configuraiton.
    internal var sourceConfig: SubjectConfiguration?

    // MARK: - Builder

    /// The custom UserID.
    @objc
    public func userId(_ userId: String?) -> Self {
        self.userId = userId
        return self
    }

    /// The network UserID.
    /// Note: It's not generated by the tracker, it needs to be filled by the developer when instrumenting the tracker.
    @objc
    public func networkUserId(_ userId: String?) -> Self {
        self.networkUserId = userId
        return self
    }

    /// The domain UserID.
    /// Note: It's not generated by the tracker, it needs to be filled by the developer when instrumenting the tracker.
    @objc
    public func domainUserId(_ userId: String?) -> Self {
        self.domainUserId = userId
        return self
    }

    /// The user-agent.
    /// Note: It's not generated by the tracker, it needs to be filled by the developer when instrumenting the tracker.
    @objc
    public func useragent(_ useragent: String?) -> Self {
        self.useragent = useragent
        return self
    }

    /// The IP address.
    /// Note: It's not generated by the tracker, it needs to be filled by the developer when instrumenting the tracker.
    @objc
    public func ipAddress(_ ip: String?) -> Self {
        self.ipAddress = ip
        return self
    }

    /// The current timezone.
    @objc
    public func timezone(_ timezone: String?) -> Self {
        self.timezone = timezone
        return self
    }

    /// The language set in the device.
    @objc
    public func language(_ language: String?) -> Self {
        self.language = language
        return self
    }

    /// The screen resolution.
    @objc
    public func screenResolution(_ resolution: SPSize?) -> Self {
        self.screenResolution = resolution
        return self
    }

    /// The screen viewport.
    /// Note: It's not generated by the tracker, it needs to be filled by the developer when instrumenting the tracker.
    @objc
    public func screenViewPort(_ viewPort: SPSize?) -> Self {
        self.screenViewPort = viewPort
        return self
    }

    /// The color depth.
    /// Note: It's not generated by the tracker, it needs to be filled by the developer when instrumenting the tracker.
    @objc
    public func colorDepth(_ colorDepth: NSNumber?) -> Self {
        self.colorDepth = colorDepth
        return self
    }

    // GeoLocation builders

    /// Latitude value for the geolocation context.
    @objc
    public func geoLatitude(_ geoLatitude: NSNumber?) -> Self {
        self.geoLatitude = geoLatitude
        return self
    }

    /// Longitude value for the geo context.
    @objc
    public func geoLongitude(_ geoLongitude: NSNumber?) -> Self {
        self.geoLongitude = geoLongitude
        return self
    }

    /// LatitudeLongitudeAccuracy value for the geolocation context.
    @objc
    public func geoLatitudeLongitudeAccuracy(_ accuracy: NSNumber?) -> Self {
        self.geoLatitudeLongitudeAccuracy = accuracy
        return self
    }

    /// Altitude value for the geolocation context.
    @objc
    public func geoAltitude(_ geoAltitude: NSNumber?) -> Self {
        self.geoAltitude = geoAltitude
        return self
    }

    /// AltitudeAccuracy value for the geolocation context.
    @objc
    public func geoAltitudeAccuracy(_ accuracy: NSNumber?) -> Self {
        self.geoAltitudeAccuracy = accuracy
        return self
    }

    /// Bearing value for the geolocation context.
    @objc
    public func geoBearing(_ bearing: NSNumber?) -> Self {
        self.geoBearing = bearing
        return self
    }

    /// Speed value for the geolocation context.
    @objc
    public func geoSpeed(_ geoSpeed: NSNumber?) -> Self {
        self.geoSpeed = geoSpeed
        return self
    }

    /// Timestamp value for the geolocation context.
    @objc
    public func geoTimestamp(_ timestamp: NSNumber?) -> Self {
        self.geoTimestamp = timestamp
        return self
    }

    // MARK: - NSCopying

    @objc
    public override func copy(with zone: NSZone? = nil) -> Any {
        let copy = SubjectConfiguration()
        copy.userId = userId
        copy.networkUserId = networkUserId
        copy.domainUserId = domainUserId
        copy.useragent = useragent
        copy.ipAddress = ipAddress
        copy.timezone = timezone
        copy.language = language
        copy.screenResolution = screenResolution
        copy.screenViewPort = screenViewPort
        copy.colorDepth = colorDepth

        // geolocation
        copy.geoLatitude = geoLatitude
        copy.geoLongitude = geoLongitude
        copy.geoLatitudeLongitudeAccuracy = geoLatitudeLongitudeAccuracy
        copy.geoAltitude = geoAltitude
        copy.geoAltitudeAccuracy = geoAltitudeAccuracy
        copy.geoSpeed = geoSpeed
        copy.geoBearing = geoBearing
        copy.geoTimestamp = geoTimestamp
        return copy
    }

    // MARK: - NSSecureCoding
    
    @objc
    public override class var supportsSecureCoding: Bool { return true }

    @objc
    public override func encode(with coder: NSCoder) {
        coder.encode(userId, forKey: "userId")
        coder.encode(networkUserId, forKey: "networkUserId")
        coder.encode(domainUserId, forKey: "domainUserId")
        coder.encode(useragent, forKey: "useragent")
        coder.encode(ipAddress, forKey: "ipAddress")
        coder.encode(timezone, forKey: "timezone")
        coder.encode(language, forKey: "language")
        coder.encode(screenResolution, forKey: "screenResolution")
        coder.encode(screenViewPort, forKey: "screenViewPort")
        coder.encode(colorDepth, forKey: "colorDepth")
        // geolocation
        coder.encode(geoLatitude, forKey: "geoLatitude")
        coder.encode(geoLongitude, forKey: "geoLongitude")
        coder.encode(geoLatitudeLongitudeAccuracy, forKey: "geoLatitudeLongitudeAccuracy")
        coder.encode(geoAltitude, forKey: "geoAltitude")
        coder.encode(geoAltitudeAccuracy, forKey: "geoAltitudeAccuracy")
        coder.encode(geoSpeed, forKey: "geoSpeed")
        coder.encode(geoBearing, forKey: "geoBearing")
        coder.encode(geoTimestamp, forKey: "geoTimestamp")
    }

    required init?(coder: NSCoder) {
        super.init()
        userId = coder.decodeObject(forKey: "userId") as? String
        networkUserId = coder.decodeObject(forKey: "networkUserId") as? String
        domainUserId = coder.decodeObject(forKey: "domainUserId") as? String
        useragent = coder.decodeObject(forKey: "useragent") as? String
        ipAddress = coder.decodeObject(forKey: "ipAddress") as? String
        timezone = coder.decodeObject(forKey: "timezone") as? String
        language = coder.decodeObject(forKey: "language") as? String
        screenResolution = coder.decodeObject(forKey: "screenResolution") as? SPSize
        screenViewPort = coder.decodeObject(forKey: "screenViewPort") as? SPSize
        colorDepth = coder.decodeObject(forKey: "colorDepth") as? NSNumber
        // geolocation
        geoLatitude = coder.decodeObject(forKey: "geoLatitude") as? NSNumber
        geoLongitude = coder.decodeObject(forKey: "geoLongitude") as? NSNumber
        geoLatitudeLongitudeAccuracy = coder.decodeObject(forKey: "geoLatitudeLongitudeAccuracy") as? NSNumber
        geoAltitude = coder.decodeObject(forKey: "geoAltitude") as? NSNumber
        geoAltitudeAccuracy = coder.decodeObject(forKey: "geoAltitudeAccuracy") as? NSNumber
        geoSpeed = coder.decodeObject(forKey: "geoSpeed") as? NSNumber
        geoBearing = coder.decodeObject(forKey: "geoBearing") as? NSNumber
        geoTimestamp = coder.decodeObject(forKey: "geoTimestamp") as? NSNumber
    }
}
