/**
 * Flurry Analytics Module. Flurry library is Copyright(c) 2010 by Flurry, Inc.
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiFlurryModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "FlurryAnalytics.h"

@implementation TiFlurryModule

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] Flurry Analytics Module loaded");
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma Public APIs

-(void)initialize:(id)args
{
	ENSURE_SINGLE_ARG(args,NSString);
	[FlurryAnalytics startSession:args];
}

-(void)reportOnClose:(id)value
{
	ENSURE_SINGLE_ARG(value,NSObject);
	BOOL yn = [TiUtils boolValue:value];
	[FlurryAnalytics setSessionReportsOnCloseEnabled:yn];
}

-(void)setUserId:(id)args
{
    ENSURE_SINGLE_ARG(args, NSString);
    [FlurryAnalytics setUserID:[args objectAtIndex:0]];
}

-(void)setAge:(id)args
{
    ENSURE_SINGLE_ARG(args, NSObject);
    [FlurryAnalytics setAge:[TiUtils intValue:[args objectAtIndex:0]]];
}

-(void)setGender:(id)args
{
    ENSURE_SINGLE_ARG(args, NSString);
    [FlurryAnalytics setGender:[TiUtils stringValue:[args objectAtIndex:0]]];
}

-(void)logEvent:(id)args
{
	NSString *event = [args objectAtIndex:0];
	NSDictionary *props = nil;
	if ([args count] > 1)
	{
		props = [args objectAtIndex:1];
	}
	if (props==nil)
	{
		[FlurryAnalytics logEvent:event];
	}
	else 
	{
		[FlurryAnalytics logEvent:event withParameters:props];
	}
}

-(void)logTimedEvent:(id)args
{
	NSString *event = [args objectAtIndex:0];
	NSDictionary *props = nil;
	if ([args count] > 1)
	{
		props = [args objectAtIndex:1];
	}
	if (props==nil)
	{
		[FlurryAnalytics logEvent:event timed:TRUE];
	}
	else 
	{
		[FlurryAnalytics logEvent:event withParameters:props timed:TRUE];
	}
}

-(void)endTimedEvent:(id)args
{
    NSString *event = [args objectAtIndex:0];
    NSDictionary *props = [args count] > 1 ? [args objectAtIndex:1] : NULL;
    
    [FlurryAnalytics endTimedEvent:event withParameters:props];
}



@end
