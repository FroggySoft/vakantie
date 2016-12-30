//
//  InfoController.m
//  Vakantie
//
//  Created by Rob on 5/14/10.
//  Copyright 2010 FroggySoft. All rights reserved.
//

#import "InfoController.h"


@implementation InfoController
@synthesize mLabel , mBtnTerug , mBtnInfo , mBtnNoord , mBtnMidden , mBtnZuid , mBtnVlaanderen;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	[mLabel setText:@"Schoolvakanties voor de schooljaren 2010/11 t/m 2013/14."];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

-(void) selectOk: (id)sender
{
	[self.view removeFromSuperview];
}
-(void) selectInfo: (id)sender
{
	[mLabel setText:@"Schoolvakanties voor de schooljaren 2013/2014 t/m 2015/2016.\n\nwww.froggysoft.nl\n\nDit programma toont aan de hand van de aangegeven regio, periode en jaar de data van de vakanties. Ook kan men vaststellen of op een bepaalde datum of in een bepaalde week één of meerdere regio\'s vakantie hebben.\nEr wordt geen onderscheid meer gemaakt tussen basisonderwijs en voortgezet onderwijs.\nDe zomer-, kerst- en de meivakantie zijn centraal vastgesteld, de data voor de voorjaarsvakantie en herfstvakantie zijn adviesdata. Geadviseerd wordt om bij de school na te gaan op welke dagen deze gesloten is in verband met vakantie."];
}
-(void) selectNoord: (id)sender
{
	[mLabel setText:@"Regio Noord omvat:\nGroningen\nFriesland\nDrenthe\nOverijssel\nFlevoland behalve Zeewolde\nGelderland:  Hattem\nUtrecht:  Eemnes en Loosdrecht\nNoord-Holland"];
}
-(void) selectMidden: (id)sender
{
	[mLabel setText:@"Regio Midden omvat:\nFlevoland: Zeewolde\nGelderland: Aalten,Apeldoorn,\n  Barneveld,Bergh,Borculo,\n  Brummen,Buren,Culemborg,\n  Dinxperlo,Doetinchem,\n  Echteld,Ede,Eibergen,\n  Elburg,Epe,Ermelo,\n  Geldermalsen,Gendringen,\n  Gorssel,Groenlo,Heerde,\n  Harderwijk,Hengelo,Hoevelaken,\n  Hummelo en Keppel,Kesteren,\n  Lichtenvoorde,Lienden,\n  Lingewaal,Lochem,Neede,\n  Neerijnen,Nijkerk,Nunspeet,\n  Oldebroek,Putten,Ruurlo,\n  Scherpenzeel,Steenderen,\n  Tiel,Voorst,Vorden,\n  Wageningen,Wehl,Warnsveld,\n  Winterswijk,Wisch,Zelhelm,\n  Zutphen\nUtrecht behalve Eemnes en\n  Loosdrecht\nZuid-Holland\nNoord-Brabant: Werkendam en\n  Woudrichem"];	
}
-(void) selectZuid: (id)sender
{
	[mLabel setText:@"Regio Zuid omvat:\nGelderland: Ammerzoden,Angerlo,\n    Arnhem,Bemmel,Beuningen,\n    Brakel,Didam,Dodewaard,\n    Doesburg,Druten,Duiven,\n    Groesbeek,Hedel,Heumen,\n    Heerewaarden,Kerkwijk,\n    Maasdriel,Millingen a/d Rijn,\n    Nijmegen,Over-betuwe,Renkum,\n    Rheden,Rijnwaarden,Rozendaal,\n    Ubbergen,Valburg,Westervoort,\n    West Maas&Waal,Wijchen,\n    Zaltbommel,Zevenaar\nZeeland\nNoord-Brabant behalve Werkendam\n    en Woudrichem\nLimburg."];	
}
-(void) selectVlaanderen: (id)sender
{
	[mLabel setText:@"Vlaanderen omvat:\nBrussel, Antwerpen, Kortrijk, Gent, Brugge, Leuven, Mechelen, Oostende, Hasselt\n\nen:\nAalter, Aarschot, Aartselaar, Affligem, Alken, Alveringem, Antwerpen, Anzegem, Ardooie, Arendonk, As, Asse, Assenede, Avelgem, Baarle-Hertog, Balen, Beernem, Beerse, Beersel, Begijnendijk, Bekkevoort, Beringen,Berlaar, Berlare, Bertem, Bever, Beveren, Bierbeek, Bilzen, Blankenberge, Bocholt, Boechout, Bonheiden, Boom, Boortmeerbeek, Borgloon, Bornem, Borsbeek, Boutersem, Brakel, Brasschaat, Brecht, Bredene, Bree, , Brugge, Buggenhout, Damme, De Haan, De Panne, De Pinte, Deerlijk, Deinze, Denderleeuw,Dendermonde, Dentergem, Dessel, Destelbergen, Diepenbeek, Diest, Diksmuide, Dilbeek, Dilsen-Stokkem, Drogenbos, Duffel, Edegem, Eeklo, Erpe-Mere, Essen, Evergem, Galmaarden, Gavere, Geel, Geetbets, Genk, Gent, Geraardsbergen, Gingelom, Gistel, Glabbeek, Gooik, Grimbergen, Grobbendonk, Haacht, Haaltert, Halen, Halle, Ham, Hamme, Hamont-Achel, Harelbeke, Hasselt, Hechtel-Eksel, Heers, Heist-op-den-Berg, Hemiksem, Herent, Herentals, Herenthout, Herk-de-Stad, Herne, Herselt, Herstappe, Herzele, Heusden-Zolder, Heuvelland, Hoegaarden, Hoeilaart, Hoeselt, Holsbeek, Hooglede, Hoogstraten, Horebeke, Houthalen-Helchteren, Houthulst, Hove, Huldenberg, Hulshout, Ichtegem, Ieper, Ingelmunster, Izegem, Jabbeke, Kalmthout, Kampenhout, Kapellen, Kapelle-op-den-Bos, Kaprijke, Kasterlee, Keerbergen, Kinrooi, Kluisbergen, Knesselare, Knokke-Heist, Koekelare, Koksijde, Kontich, Kortemark, Kortenaken, Kortenberg, Kortessem, Kortrijk, Kraainem, Kruibeke, Kruishoutem, Kuurne, Laakdal, Laarne, Lanaken, Landen, Langemark-Poelkapelle, Lebbeke, Lede, Ledegem,Lendelede, Lennik, Leopoldsburg, Leuven, Lichtervelde, Liedekerke, Lier, Lierde, Lille, Linkebeek, Lint, Linter, Lochristi, Lokeren, Lommel, Londerzeel, Lo-Reninge, Lovendegem, Lubbeek, Lummen, Maarkedal, Maaseik, Maasmechelen, Machelen, Maldegem, Malle, Mechelen, Meerhout, Meeuwen-Gruitrode, Meise, Melle,Menen, Merchtem, Merelbeke, Merksplas, Mesen, Meulebeke, Middelkerke, Moerbeke, Mol, Moorslede, Mortsel, Nazareth, Neerpelt, Nevele, Niel, Nieuwerkerken, Nieuwpoort, Nijlen, Ninove, Olen, Oostende, Oosterzele, Oostkamp, Oostrozebeke, Opglabbeek, Opwijk, Oudenaarde, Oudenburg, Oud-Heverlee, Oud-Turnhout,Overijse, Overpelt, Peer, Pepingen, Pittem, Poperinge, Putte, Puurs, Ranst, Ravels, Retie, Riemst, Rijkevorsel, Roeselare, Ronse, Roosdaal, Rotselaar, Ruiselede, Rumst, Schelle, Scherpenheuvel-Zichem, Schilde, Schoten, Sint-Amands, Sint-Genesius-Rode, Sint-Gillis-Waas, Sint-Katelijne-Waver, Sint-Laureins, Sint-Lievens-Houtem, Sint-Martens-Latem, Sint-Niklaas, Sint-Pieters-Leeuw, Sint-Truiden, Spiere-Helkijn, Stabroek, Staden, Steenokkerzeel, Stekene, Temse, Ternat, Tervuren, Tessenderlo, Tielt, Tielt-Winge, Tienen, Tongeren, Torhout, Tremelo, Turnhout, Veurne,Vilvoorde, Vleteren, Voeren, Vorselaar, Vosselaar, Waarschoot, Waasmunster, Wachtebeke, Waregem, Wellen, Wemmel, Wervik, Westerlo, Wetteren, Wevelgem, Wezembeek-Oppem, Wichelen, Wielsbeke, Wijnegem, Willebroek, Wingene, Wommelgem, Wortegem-Petegem, Wuustwezel, Zandhoven, Zaventem, Zedelgem, Zele, Zelzate, Zemst, Zingem, Zoersel, Zomergem, Zonhoven, Zonnebeke, Zottegem, Zoutleeuw, Zuienkerke, Zulte, Zutendaal, Zwalm, Zwevegem, Zwijndrecht"];	
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
