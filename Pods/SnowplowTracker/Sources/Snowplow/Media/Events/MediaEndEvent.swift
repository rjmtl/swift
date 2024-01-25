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

import Foundation

/** Media player event sent when playback stops when end of the media is reached or because no further data is available. */
@objc(SPMediaEndEvent)
public class MediaEndEvent: SelfDescribingAbstract, MediaPlayerUpdatingEvent {
    
    override var schema: String {
        return MediaSchemata.eventSchema("end")
    }
    
    override var payload: [String : Any] {
        return [:]
    }
    
    func update(player: MediaPlayerEntity) {
        player.ended = true
        player.paused = true
    }
}
