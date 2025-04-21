#import "Headers.h"

@implementation TGExtraLocalization

+ (instancetype)shared {
	static TGExtraLocalization *instance;
	static dispatch_once_t token;
	dispatch_once(&token, ^{
		instance = [TGExtraLocalization new];
		[instance loadDefault];
	});
	return instance;
}

- (void)loadDefault {
	NSString *selectedLanguageCode = [[NSUserDefaults standardUserDefaults] stringForKey:@"TGExtraLanguage"];
	
	if (!selectedLanguageCode) {
		selectedLanguageCode = @"en";
	}
	
	NSString *localizationFilePath = [NSString stringWithFormat:@"%@/TGExtra.bundle/%@.lproj/Localizable.strings", [[NSBundle mainBundle] resourcePath], selectedLanguageCode];
	localizationFilePath = jbroot([NSString stringWithFormat:@"/Library/Application Support/TGExtra.bundle/%@.lproj/Localizable.strings", selectedLanguageCode]);
	NSLogDebug(@"3[----]Loading language file: %@", localizationFilePath);

	
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:localizationFilePath];
	
	self.localization = [[objc_getClass("TGLocalization") alloc] initWithVersion:96929692 
                                                                   code:selectedLanguageCode
                                                                   dict:dict
                                                              isActive:YES];
	
}

+ (NSString *)localizedStringForKey:(NSString *)key {
	if (!key) return nil;
	
	NSString *localizedString = [[TGExtraLocalization shared].localization get:key];
	
	if (!localizedString) return key;
	
	return localizedString;
}
@end