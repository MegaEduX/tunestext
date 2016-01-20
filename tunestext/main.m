//
//  main.m
//  tunestext
//
//  Created by Eduardo Almeida on 20/01/16.
//  Copyright © 2016 Eduardo Almeida. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ScriptingBridge/ScriptingBridge.h>

#import "iTunes.h"

static NSString *kNowPlayingNameFile = @"/tmp/tunestext_name.txt";
static NSString *kNowPlayingArtistFile = @"/tmp/tunestext_artist.txt";

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *lastTrackName = nil;
        NSString *lastTrackArtist = nil;
        
        iTunesApplication *iTunes = [SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"];
        
        for (;; sleep(1)) {
            if (lastTrackName && lastTrackArtist)
                if ([lastTrackName isEqual:iTunes.currentTrack.name] && [lastTrackArtist isEqual:iTunes.currentTrack.artist])
                    continue;
            
            lastTrackName = iTunes.currentTrack.name;
            lastTrackArtist = iTunes.currentTrack.artist;
            
            [lastTrackName writeToFile:kNowPlayingNameFile atomically:false encoding:NSUTF8StringEncoding error:nil];
            [lastTrackArtist writeToFile:kNowPlayingArtistFile atomically:false encoding:NSUTF8StringEncoding error:nil];
            
            NSLog(@"Wrote to file!");
        }
    }
    return 0;
}
